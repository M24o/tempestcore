/*
 * Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef _DATABASEWORKERPOOL_H
#define _DATABASEWORKERPOOL_H

#include <ace/Atomic_Op_T.h>
#include <ace/Thread_Mutex.h>

#include "Common.h"
#include "Callback.h"
#include "MySQLConnection.h"
#include "Transaction.h"
#include "DatabaseWorker.h"
#include "PreparedStatement.h"
#include "Log.h"
#include "QueryResult.h"
#include "QueryHolder.h"
#include "AdhocStatement.h"

class PingOperation : public SQLOperation
{
    /// Operation for idle delaythreads
    bool Execute()
    {
        for (;;)
            if (m_conn->LockIfReady())
            {
                m_conn->Ping();
                m_conn->Unlock();
                return true;
            }

        return false;
    }
};

template <class T>
class DatabaseWorkerPool
{
    private:
        typedef ACE_Atomic_Op<ACE_SYNCH_MUTEX, uint32> AtomicUInt;

    public:
        DatabaseWorkerPool() :
        m_queue(new ACE_Activation_Queue(new ACE_Message_Queue<ACE_MT_SYNCH>)),
        m_connections(0)
        {
            m_connections.resize(IDX_SIZE);

            mysql_library_init(-1, NULL, NULL);
            WPFatal (mysql_thread_safe(), "Used MySQL library isn't thread-safe.");
        }

        ~DatabaseWorkerPool()
        {
            sLog.outSQLDriver("~DatabaseWorkerPool for '%s'.", m_connectionInfo.database.c_str());
            mysql_library_end();
        }

        bool Open(const std::string& infoString, uint8 async_threads, uint8 synch_threads)
        {
            m_connectionInfo = MySQLConnectionInfo(infoString);

            sLog.outSQLDriver("Opening databasepool '%s'. Async threads: %u, synch threads: %u", m_connectionInfo.database.c_str(), async_threads, synch_threads);

            /// Open asynchronous connections (delayed operations)
            m_connections[IDX_ASYNC].resize(async_threads);
            for (uint8 i = 0; i < async_threads; ++i)
            {
                T* t = new T(m_queue, m_connectionInfo);
                t->Open();
                m_connections[IDX_ASYNC][i] = t;
                ++m_connectionCount;
            }

            /// Open synchronous connections (direct, blocking operations)
            m_connections[IDX_SYNCH].resize(synch_threads);
            for (uint8 i = 0; i < synch_threads; ++i) 
            {
                T* t = new T(m_connectionInfo);
                t->Open();
                m_connections[IDX_SYNCH][i] = t;
                ++m_connectionCount;
            }

            sLog.outSQLDriver("Databasepool opened succesfuly. %u connections running.", (uint32)m_connectionCount.value());
            return true;
        }

        void Close()
        {
            sLog.outSQLDriver("Closing down databasepool '%s'.", m_connectionInfo.database.c_str());

            /// Shuts down delaythreads for this connection pool.
            m_queue->queue()->deactivate();
            for (uint8 i = 0; i < m_connections[IDX_ASYNC].size(); ++i)
            {
                /// TODO: Better way. probably should flip a boolean and check it on low level code before doing anything on the mysql ctx
                /// Now we just wait until m_queue gives the signal to the worker threads to stop
                T* t = m_connections[IDX_ASYNC][i];
                t->m_worker->wait(); // t->Close(); is called from worker thread                
                --m_connectionCount;
            }

            sLog.outSQLDriver("Asynchronous connections on databasepool '%s' terminated. Proceeding with synchronous connections.", m_connectionInfo.database.c_str());

            /// Shut down the synchronous connections
            for (uint8 i = 0; i < m_connections[IDX_SYNCH].size(); ++i)
            {
                T* t = m_connections[IDX_SYNCH][i];
                //while (1)
                //    if (t->LockIfReady()) -- For some reason deadlocks us 
                t->Close();
                --m_connectionCount;
            }
            
            sLog.outSQLDriver("All connections on databasepool %s closed.", m_connectionInfo.database.c_str());
        }

        void Execute(const char* sql)
        {
            if (!sql)
                return;

            BasicStatementTask* task = new BasicStatementTask(sql);
            Enqueue(task);
        }

        void PExecute(const char* sql, ...)
        {
            if (!sql)
                return;

            va_list ap;
            char szQuery[MAX_QUERY_LEN];
            va_start(ap, sql);
            vsnprintf(szQuery, MAX_QUERY_LEN, sql, ap);
            va_end(ap);

            Execute(szQuery);
        }

        void DirectExecute(const char* sql)
        {
            if (!sql)
                return;
            
            T* t = GetFreeConnection();
            t->Execute(sql);
            t->Unlock();
        }

        void DirectPExecute(const char* sql, ...)
        {
            if (!sql)
                return;

            va_list ap;
            char szQuery[MAX_QUERY_LEN];
            va_start(ap, sql);
            vsnprintf(szQuery, MAX_QUERY_LEN, sql, ap);
            va_end(ap);

            return DirectExecute(szQuery);
        }

        QueryResult Query(const char* sql, MySQLConnection* conn = NULL)
        {
            if (!conn)
                conn = GetFreeConnection();

            ResultSet* result = conn->Query(sql);
            conn->Unlock();
            if (!result || !result->GetRowCount())
                return QueryResult(NULL);

            result->NextRow();
            return QueryResult(result);
        }

        QueryResult PQuery(const char* sql, MySQLConnection* conn, ...)
        {
            if (!sql)
                return QueryResult(NULL);

            va_list ap;
            char szQuery[MAX_QUERY_LEN];
            va_start(ap, sql);
            vsnprintf(szQuery, MAX_QUERY_LEN, sql, ap);
            va_end(ap);

            return Query(szQuery, conn);
        }

        QueryResult PQuery(const char* sql, ...)
        {
            if (!sql)
                return QueryResult(NULL);

            va_list ap;
            char szQuery[MAX_QUERY_LEN];
            va_start(ap, sql);
            vsnprintf(szQuery, MAX_QUERY_LEN, sql, ap);
            va_end(ap);

            return Query(szQuery);
        }

        ACE_Future<QueryResult> AsyncQuery(const char* sql)
        {
            QueryResultFuture res;
            BasicStatementTask* task = new BasicStatementTask(sql, res);
            Enqueue(task);
            return res;         //! Actual return value has no use yet
        }

        ACE_Future<QueryResult> AsyncPQuery(const char* sql, ...)
        {
            va_list ap;
            char szQuery[MAX_QUERY_LEN];
            va_start(ap, sql);
            vsnprintf(szQuery, MAX_QUERY_LEN, sql, ap);
            va_end(ap);

            return AsyncQuery(szQuery);
        }

        QueryResultHolderFuture DelayQueryHolder(SQLQueryHolder* holder)
        {
            QueryResultHolderFuture res;
            SQLQueryHolderTask* task = new SQLQueryHolderTask(holder, res);
            Enqueue(task);
            return res;     //! Fool compiler, has no use yet
        }

        SQLTransaction BeginTransaction()
        {
            return SQLTransaction(new Transaction);
        }

        void CommitTransaction(SQLTransaction transaction)
        {
            #ifdef SQLQUERY_LOG
            if (transaction->GetSize() == 0)
            {
                sLog.outSQLDriver("Transaction contains 0 queries. Not executing.");
                return;
            }
            if (transaction->GetSize() == 1)
            {
                sLog.outSQLDriver("Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
            }
            #endif
            Enqueue(new TransactionTask(transaction));
        }

        PreparedStatement* GetPreparedStatement(uint32 index)
        {
            return new PreparedStatement(index);
        }

        void Execute(PreparedStatement* stmt)
        {
            PreparedStatementTask* task = new PreparedStatementTask(stmt);
            Enqueue(task);
        }

        void escape_string(std::string& str)
        {
            if (str.empty())
                return;

            char* buf = new char[str.size()*2+1];
            escape_string(buf,str.c_str(),str.size());
            str = buf;
            delete[] buf;
        }

        PreparedQueryResult Query(PreparedStatement* stmt)
        {
            T* t = GetFreeConnection();
            PreparedResultSet* ret = t->Query(stmt);
            t->Unlock();

            if (!ret || !ret->GetRowCount())
                return PreparedQueryResult(NULL);

            return PreparedQueryResult(ret);
        }

        void KeepAlive()
        {
            /// Ping syncrhonous connections
            for (uint8 i = 0; i < m_connections[IDX_SYNCH].size(); ++i)
                m_connections[IDX_SYNCH][i]->Ping();

            /// Assuming all worker threads are free, every worker thread will receive 1 ping operation request
            /// If one or more worker threads are busy, the ping operations will not be split evenly, but this doesn't matter
            /// as the sole purpose is to prevent connections from idling.
            for (size_t i = 0; i < m_connections[IDX_ASYNC].size(); ++i)
                Enqueue(new PingOperation);
        }

    private:
        unsigned long escape_string(char *to, const char *from, unsigned long length)
        {
            if (!to || !from || !length)
                return 0;
            
            T* t = GetFreeConnection();
            unsigned long ret = mysql_real_escape_string(t->GetHandle(), to, from, length);
            t->Unlock();
            return ret;
        }

        void Enqueue(SQLOperation* op)
        {
            m_queue->enqueue(op);
        }

        T* GetFreeConnection()
        {
            uint8 i = 0;
            size_t num_cons = m_connections[IDX_SYNCH].size();
            for (;;)    /// Block forever until a connection is free
            {
                T* t = m_connections[IDX_SYNCH][++i % num_cons ];
                if (t->LockIfReady())   /// Must be matched with t->Unlock() or you will get deadlocks
                    return t;
            }

            // This will be called when Celine Dion learns to sing
            return NULL;
        }

    private:
        enum
        {
            IDX_ASYNC,
            IDX_SYNCH,
            IDX_SIZE,
        };

        ACE_Activation_Queue*           m_queue;             //! Queue shared by async worker threads.
        std::vector< std::vector<T*> >  m_connections;
        AtomicUInt                      m_connectionCount;       //! Counter of MySQL connections;
        MySQLConnectionInfo             m_connectionInfo;
};

#endif
