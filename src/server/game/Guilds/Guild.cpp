/*
 * Copyright (C) 2005 - 2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
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

#include "DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Player.h"
#include "Opcodes.h"
#include "ObjectMgr.h"
#include "Guild.h"
#include "Chat.h"
#include "SocialMgr.h"
#include "Util.h"
#include "Language.h"
#include "World.h"
#include "Config.h"
#include "ScriptMgr.h"

Guild::Guild()
{
    m_Id = 0;
    m_Name = "";
    m_LeaderGuid = 0;
    GINFO = MOTD = "";
    m_EmblemStyle = 0;
    m_EmblemColor = 0;
    m_BorderStyle = 0;
    m_BorderColor = 0;
    m_BackgroundColor = 0;
    m_accountsNumber = 0;

    m_CreatedDate = time(0);

    m_GuildBankMoney = 0;

    m_GuildEventLogNextGuid = 0;
    m_GuildBankEventLogNextGuid_Money = 0;

    for (uint8 i = 0; i < GUILD_BANK_MAX_TABS; ++i)
        m_GuildBankEventLogNextGuid_Item[i] = 0;
}

Guild::~Guild()
{
    SQLTransaction temp = SQLTransaction(NULL);
    DeleteGuildBankItems(temp);
}

bool Guild::Create(Player* leader, std::string gname)
{
    if (sObjectMgr.GetGuildByName(gname))
        return false;

    WorldSession* lSession = leader->GetSession();
    if (!lSession)
        return false;

    m_LeaderGuid = leader->GetGUID();
    m_Name = gname;
    GINFO = "";
    MOTD = "No message set.";
    m_GuildBankMoney = 0;
    m_Id = sObjectMgr.GenerateGuildId();

    sLog.outDebug("GUILD: creating guild %s to leader: %u", gname.c_str(), GUID_LOPART(m_LeaderGuid));

    // gname already assigned to Guild::name, use it to encode string for DB
    CharacterDatabase.escape_string(gname);

    std::string dbGINFO = GINFO;
    std::string dbMOTD = MOTD;
    CharacterDatabase.escape_string(dbGINFO);
    CharacterDatabase.escape_string(dbMOTD);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    // CharacterDatabase.PExecute("DELETE FROM guild WHERE guildid='%u'", Id); - MAX(guildid)+1 not exist
    trans->PAppend("DELETE FROM guild_member WHERE guildid='%u'", m_Id);
    trans->PAppend("INSERT INTO guild (guildid,name,leaderguid,info,motd,createdate,EmblemStyle,EmblemColor,BorderStyle,BorderColor,BackgroundColor,BankMoney) "
        "VALUES('%u','%s','%u', '%s', '%s', UNIX_TIMESTAMP(NOW()),'%u','%u','%u','%u','%u','" UI64FMTD "')",
        m_Id, gname.c_str(), GUID_LOPART(m_LeaderGuid), dbGINFO.c_str(), dbMOTD.c_str(), m_EmblemStyle, m_EmblemColor, m_BorderStyle, m_BorderColor, m_BackgroundColor, m_GuildBankMoney);
    CharacterDatabase.CommitTransaction(trans);

    CreateDefaultGuildRanks(lSession->GetSessionDbLocaleIndex());

    return AddMember(m_LeaderGuid, (uint32)GR_GUILDMASTER);
}

void Guild::CreateDefaultGuildRanks(LocaleConstant locale_idx)
{
    CharacterDatabase.PExecute("DELETE FROM guild_rank WHERE guildid='%u'", m_Id);
    CharacterDatabase.PExecute("DELETE FROM guild_bank_right WHERE guildid = '%u'", m_Id);

    CreateRank(sObjectMgr.GetTrinityString(LANG_GUILD_MASTER, locale_idx),   GR_RIGHT_ALL);
    CreateRank(sObjectMgr.GetTrinityString(LANG_GUILD_OFFICER, locale_idx),  GR_RIGHT_ALL);
    CreateRank(sObjectMgr.GetTrinityString(LANG_GUILD_VETERAN, locale_idx),  GR_RIGHT_GCHATLISTEN | GR_RIGHT_GCHATSPEAK);
    CreateRank(sObjectMgr.GetTrinityString(LANG_GUILD_MEMBER, locale_idx),   GR_RIGHT_GCHATLISTEN | GR_RIGHT_GCHATSPEAK);
    CreateRank(sObjectMgr.GetTrinityString(LANG_GUILD_INITIATE, locale_idx), GR_RIGHT_GCHATLISTEN | GR_RIGHT_GCHATSPEAK);
}

bool Guild::AddMember(uint64 plGuid, uint32 plRank)
{
    Player* pl = sObjectMgr.GetPlayer(plGuid);
    if (pl)
    {
        if (pl->GetGuildId() != 0)
            return false;
    }
    else
    {
        if (Player::GetGuildIdFromDB(plGuid) != 0)           // player already in guild
            return false;
    }

    sScriptMgr.OnGuildAddMember(this, pl, plRank);

    // remove all player signs from another petitions
    // this will be prevent attempt joining player to many guilds and corrupt guild data integrity
    Player::RemovePetitionsAndSigns(plGuid, 9);

    // fill player data
    MemberSlot newmember;

    if (pl)
    {
        newmember.accountId = pl->GetSession()->GetAccountId();
        newmember.Name   = pl->GetName();
        newmember.ZoneId = pl->GetZoneId();
        newmember.Level  = pl->getLevel();
        newmember.Class  = pl->getClass();
    }
    else
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT name,zone,level,class,account FROM characters WHERE guid = '%u'", GUID_LOPART(plGuid));
        if (!result)
            return false;                                   // player doesn't exist

        Field *fields       = result->Fetch();
        newmember.Name      = fields[0].GetString();
        newmember.ZoneId    = fields[1].GetUInt32();
        newmember.Level     = fields[2].GetUInt8();
        newmember.Class     = fields[3].GetUInt8();
        newmember.accountId = fields[4].GetInt32();

        if (newmember.Level < 1 || //newmember.Level > STRONG_MAX_LEVEL ||
            newmember.Class < CLASS_WARRIOR || newmember.Class >= MAX_CLASSES)
        {
            sLog.outError("Player (GUID: %u) has a broken data in field `characters` table, cannot add him to guild.",GUID_LOPART(plGuid));
            return false;
        }
    }

    newmember.RankId  = plRank;
    newmember.OFFnote = (std::string)"";
    newmember.Pnote   = (std::string)"";
    newmember.LogoutTime = time(NULL);
    newmember.BankResetTimeMoney = 0;                       // this will force update at first query
    for (uint8 i = 0; i < GUILD_BANK_MAX_TABS; ++i)
        newmember.BankResetTimeTab[i] = 0;
    members[GUID_LOPART(plGuid)] = newmember;

    std::string dbPnote   = newmember.Pnote;
    std::string dbOFFnote = newmember.OFFnote;
    CharacterDatabase.escape_string(dbPnote);
    CharacterDatabase.escape_string(dbOFFnote);

    CharacterDatabase.PExecute("INSERT INTO guild_member (guildid,guid,rank,pnote,offnote) VALUES ('%u', '%u', '%u','%s','%s')",
        m_Id, GUID_LOPART(plGuid), newmember.RankId, dbPnote.c_str(), dbOFFnote.c_str());

    // If player not in game data in data field will be loaded from guild tables, no need to update it!!
    if (pl)
    {
        pl->SetInGuild(m_Id);
        pl->SetRank(newmember.RankId);
        pl->SetGuildIdInvited(0);
    }

    UpdateAccountsNumber();

    return true;
}

void Guild::SetMOTD(std::string motd)
{
    MOTD = motd;

    sScriptMgr.OnGuildMOTDChanged(this, motd);

    // motd now can be used for encoding to DB
    CharacterDatabase.escape_string(motd);
    CharacterDatabase.PExecute("UPDATE guild SET motd='%s' WHERE guildid='%u'", motd.c_str(), m_Id);
}

void Guild::SetGINFO(std::string ginfo)
{
    GINFO = ginfo;

    sScriptMgr.OnGuildInfoChanged(this, ginfo);

    // ginfo now can be used for encoding to DB
    CharacterDatabase.escape_string(ginfo);
    CharacterDatabase.PExecute("UPDATE guild SET info='%s' WHERE guildid='%u'", ginfo.c_str(), m_Id);
}

bool Guild::LoadGuildFromDB(QueryResult guildDataResult)
{
    if (!guildDataResult)
        return false;

    Field *fields = guildDataResult->Fetch();

    m_Id              = fields[0].GetUInt32();
    m_Name            = fields[1].GetString();
    m_LeaderGuid      = MAKE_NEW_GUID(fields[2].GetUInt32(), 0, HIGHGUID_PLAYER);
    m_EmblemStyle     = fields[3].GetUInt32();
    m_EmblemColor     = fields[4].GetUInt32();
    m_BorderStyle     = fields[5].GetUInt32();
    m_BorderColor     = fields[6].GetUInt32();
    m_BackgroundColor = fields[7].GetUInt32();
    GINFO             = fields[8].GetString();
    MOTD              = fields[9].GetString();
    m_CreatedDate     = fields[10].GetUInt64();
    m_GuildBankMoney  = fields[11].GetUInt64();

    uint32 purchasedTabs   = fields[12].GetUInt32();
    if (purchasedTabs > GUILD_BANK_MAX_TABS)
        purchasedTabs = GUILD_BANK_MAX_TABS;

    m_TabListMap.resize(purchasedTabs);
    for (uint8 i = 0; i < purchasedTabs; ++i)
        m_TabListMap[i] = new GuildBankTab();

    return true;
}

bool Guild::CheckGuildStructure()
{
    // Repair the structure of guild
    // If the guildmaster doesn't exist or isn't the member of guild
    // attempt to promote another member
    int32 GM_rights = GetRank(GUID_LOPART(m_LeaderGuid));
    if (GM_rights == -1)
    {
        DelMember(m_LeaderGuid);
        // check no members case (disbanded)
        if (members.empty())
            return false;
    }
    else if (GM_rights != GR_GUILDMASTER)
        SetLeader(m_LeaderGuid);

    // Check config if multiple guildmasters are allowed
    if (sConfig.GetBoolDefault("Guild.AllowMultipleGuildMaster", 0) == 0)
        for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
            if (itr->second.RankId == GR_GUILDMASTER && GUID_LOPART(m_LeaderGuid) != itr->first) // Allow only 1 guildmaster
                ChangeRank(itr->first, GR_OFFICER); // set right of member to officer

    return true;
}

bool Guild::LoadRanksFromDB(QueryResult guildRanksResult)
{
    if (!guildRanksResult)
    {
        sLog.outError("Guild %u has broken `guild_rank` data, creating new...",m_Id);
        CreateDefaultGuildRanks(DEFAULT_LOCALE);
        return true;
    }

    Field *fields;
    bool broken_ranks = false;

    //GUILD RANKS are sequence starting from 0 = GUILD_MASTER (ALL PRIVILEGES) to max 9 (lowest privileges)
    //the lower rank id is considered higher rank - so promotion does rank-- and demotion does rank++
    //between ranks in sequence cannot be gaps - so 0,1,2,4 cannot be
    //min ranks count is 5 and max is 10.

    do
    {
        fields = guildRanksResult->Fetch();
        //condition that would be true when all ranks in QueryResult will be processed and guild without ranks is being processed
        if (!fields)
            break;

        uint32 guildId       = fields[0].GetUInt32();
        if (guildId < m_Id)
        {
            //there is in table guild_rank record which doesn't have guildid in guild table, report error
            sLog.outErrorDb("Guild %u does not exist but it has a record in guild_rank table, deleting it!", guildId);
            CharacterDatabase.PExecute("DELETE FROM guild_rank WHERE guildid = '%u'", guildId);
            continue;
        }

        if (guildId > m_Id)
            //we loaded all ranks for this guild already, break cycle
            break;
        uint32 rankID        = fields[1].GetUInt32();
        std::string rankName = fields[2].GetString();
        uint32 rankRights    = fields[3].GetUInt32();
        uint32 rankMoney     = fields[4].GetUInt32();

        if (rankID != m_Ranks.size())                       // guild_rank.ids are sequence 0,1,2,3..
            broken_ranks =  true;

        //first rank is guildmaster, prevent loss leader rights
        if (m_Ranks.empty())
            rankRights |= GR_RIGHT_ALL;

        AddRank(rankName,rankRights,rankMoney);
    }while (guildRanksResult->NextRow());

    if (m_Ranks.size() < GUILD_RANKS_MIN_COUNT)             // if too few ranks, renew them
    {
        m_Ranks.clear();
        sLog.outError("Guild %u has broken `guild_rank` data, creating new...", m_Id);
        CreateDefaultGuildRanks(DEFAULT_LOCALE);
        broken_ranks = false;
    }
    // guild_rank have wrong numbered ranks, repair
    if (broken_ranks)
    {
        sLog.outError("Guild %u has broken `guild_rank` data, repairing...", m_Id);
        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        trans->PAppend("DELETE FROM guild_rank WHERE guildid='%u'", m_Id);
        for (size_t i = 0; i < m_Ranks.size(); ++i)
        {
            std::string name = m_Ranks[i].Name;
            uint32 rights = m_Ranks[i].Rights;
            CharacterDatabase.escape_string(name);
            trans->PAppend("INSERT INTO guild_rank (guildid,rid,rname,rights) VALUES ('%u', '%u', '%s', '%u')", m_Id, uint32(i), name.c_str(), rights);
        }
        CharacterDatabase.CommitTransaction(trans);
    }

    return true;
}

bool Guild::LoadMembersFromDB(QueryResult guildMembersResult)
{
    if (!guildMembersResult)
        return false;

    UpdateAccountsNumber();

    do
    {
        Field *fields = guildMembersResult->Fetch();
        //this condition will be true when all rows in QueryResult are processed and new guild without members is going to be loaded - prevent crash
        if (!fields)
            break;

        uint32 guildId       = fields[0].GetUInt32();
        if (guildId < m_Id)
        {
            //there is in table guild_member record which doesn't have guildid in guild table, report error
            sLog.outErrorDb("Guild %u does not exist but it has a record in guild_member table, deleting it!", guildId);
            CharacterDatabase.PExecute("DELETE FROM guild_member WHERE guildid = '%u'", guildId);
            continue;
        }

        if (guildId > m_Id)
            //we loaded all members for this guild already, break cycle
            break;

        MemberSlot newmember;
        uint64 guid      = MAKE_NEW_GUID(fields[1].GetUInt32(), 0, HIGHGUID_PLAYER);
        newmember.RankId = fields[2].GetUInt32();
        //don't allow member to have not existing rank!
        if (newmember.RankId >= m_Ranks.size())
            newmember.RankId = GetLowestRank();

        newmember.Pnote                 = fields[3].GetString();
        newmember.OFFnote               = fields[4].GetString();
        newmember.BankResetTimeMoney    = fields[5].GetUInt32();
        newmember.BankRemMoney          = fields[6].GetUInt32();
        for (uint8 i = 0; i < GUILD_BANK_MAX_TABS; ++i)
        {
            newmember.BankResetTimeTab[i] = fields[7+(2*i)].GetUInt32();
            newmember.BankRemSlotsTab[i]  = fields[8+(2*i)].GetUInt32();
        }

        newmember.Name                  = fields[19].GetString();
        newmember.Level                 = fields[20].GetUInt8();
        newmember.Class                 = fields[21].GetUInt8();
        newmember.ZoneId                = fields[22].GetUInt32();
        newmember.LogoutTime            = fields[23].GetUInt64();
        newmember.accountId             = fields[24].GetInt32();

        //this code will remove unexisting character guids from guild
        if (newmember.Level < 1 /*|| newmember.Level > STRONG_MAX_LEVEL*/) // can be at broken `data` field
        {
            sLog.outError("Player (GUID: %u) has a broken data in field `characters`.`data`, deleting him from guild!",GUID_LOPART(guid));
            CharacterDatabase.PExecute("DELETE FROM guild_member WHERE guid = '%u'", GUID_LOPART(guid));
            continue;
        }
        if (!newmember.ZoneId)
        {
            sLog.outError("Player (GUID: %u) has broken zone-data", GUID_LOPART(guid));
            // here it will also try the same, to get the zone from characters-table, but additional it tries to find
            // the zone through xy coords .. this is a bit redundant, but shouldn't be called often
            newmember.ZoneId = Player::GetZoneIdFromDB(guid);
        }
        if (newmember.Class < CLASS_WARRIOR || newmember.Class >= MAX_CLASSES) // can be at broken `class` field
        {
            sLog.outError("Player (GUID: %u) has a broken data in field `characters`.`class`, deleting him from guild!",GUID_LOPART(guid));
            CharacterDatabase.PExecute("DELETE FROM guild_member WHERE guid = '%u'", GUID_LOPART(guid));
            continue;
        }

        members[GUID_LOPART(guid)]      = newmember;

    }while (guildMembersResult->NextRow());

    if (members.empty())
        return false;

    return true;
}

void Guild::SetMemberStats(uint64 guid)
{
    MemberList::iterator itr = members.find(GUID_LOPART(guid));
    if (itr == members.end())
        return;

    Player *pl = ObjectAccessor::FindPlayer(guid);
    if (!pl)
        return;
    itr->second.Name   = pl->GetName();
    itr->second.Level  = pl->getLevel();
    itr->second.Class  = pl->getClass();
    itr->second.ZoneId = pl->GetZoneId();
}

void Guild::SetLeader(uint64 guid)
{
    m_LeaderGuid = guid;
    ChangeRank(guid, GR_GUILDMASTER);

    CharacterDatabase.PExecute("UPDATE guild SET leaderguid='%u' WHERE guildid='%u'", GUID_LOPART(guid), m_Id);
}

void Guild::DelMember(uint64 guid, bool isDisbanding, bool isKicked)
{
    Player *player = sObjectMgr.GetPlayer(guid);
    sScriptMgr.OnGuildRemoveMember(this, player, isDisbanding, isKicked);

    //guild master can be deleted when loading guild and guid doesn't exist in characters table
    //or when he is removed from guild by gm command
    if (m_LeaderGuid == guid && !isDisbanding)
    {
        MemberSlot* oldLeader = NULL;
        MemberSlot* best = NULL;
        uint64 newLeaderGUID = 0;
        for (Guild::MemberList::iterator i = members.begin(); i != members.end(); ++i)
        {
            if (i->first == GUID_LOPART(guid))
            {
                oldLeader = &(i->second);
                continue;
            }

            if (!best || best->RankId > i->second.RankId)
            {
                best = &(i->second);
                newLeaderGUID = i->first;
            }
        }
        if (!best)
        {
            Disband();
            return;
        }

        SetLeader(newLeaderGUID);

        // If player not online data in data field will be loaded from guild tabs no need to update it !!
        if (Player *newLeader = sObjectMgr.GetPlayer(newLeaderGUID))
            newLeader->SetRank(GR_GUILDMASTER);

        // when leader non-exist (at guild load with deleted leader only) not send broadcasts
        if (oldLeader)
        {
            BroadcastEvent(GE_LEADER_CHANGED, 0, 2, oldLeader->Name, best->Name, "");

            BroadcastEvent(GE_LEFT, guid, 1, oldLeader->Name, "", "");
        }
    }

    members.erase(GUID_LOPART(guid));

    // If player not online data in data field will be loaded from guild tabs no need to update it !!
    if (player)
    {
        player->SetInGuild(0);
        player->SetRank(0);
    }

    CharacterDatabase.PExecute("DELETE FROM guild_member WHERE guid = '%u'", GUID_LOPART(guid));

    if (!isDisbanding)
        UpdateAccountsNumber();
}

void Guild::ChangeRank(uint64 guid, uint32 newRank)
{
    MemberList::iterator itr = members.find(GUID_LOPART(guid));
    if (itr != members.end())
        itr->second.RankId = newRank;

    Player *player = sObjectMgr.GetPlayer(guid);
    // If player not online data in data field will be loaded from guild tabs no need to update it !!
    if (player)
        player->SetRank(newRank);

    CharacterDatabase.PExecute("UPDATE guild_member SET rank='%u' WHERE guid='%u'", newRank, GUID_LOPART(guid));
}

void Guild::SetPNOTE(uint64 guid,std::string pnote)
{
    MemberList::iterator itr = members.find(GUID_LOPART(guid));
    if (itr == members.end())
        return;

    itr->second.Pnote = pnote;

    // pnote now can be used for encoding to DB
    CharacterDatabase.escape_string(pnote);
    CharacterDatabase.PExecute("UPDATE guild_member SET pnote = '%s' WHERE guid = '%u'", pnote.c_str(), itr->first);
}

void Guild::SetOFFNOTE(uint64 guid,std::string offnote)
{
    MemberList::iterator itr = members.find(GUID_LOPART(guid));
    if (itr == members.end())
        return;
    itr->second.OFFnote = offnote;
    // offnote now can be used for encoding to DB
    CharacterDatabase.escape_string(offnote);
    CharacterDatabase.PExecute("UPDATE guild_member SET offnote = '%s' WHERE guid = '%u'", offnote.c_str(), itr->first);
}

void Guild::BroadcastToGuild(WorldSession *session, const std::string& msg, uint32 language)
{
    if (session && session->GetPlayer() && HasRankRight(session->GetPlayer()->GetRank(),GR_RIGHT_GCHATSPEAK))
    {
        WorldPacket data;
        ChatHandler(session).FillMessageData(&data, CHAT_MSG_GUILD, language, 0, msg.c_str());

        for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
        {
            Player *pl = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));

            if (pl && pl->GetSession() && HasRankRight(pl->GetRank(),GR_RIGHT_GCHATLISTEN) && !pl->GetSocial()->HasIgnore(session->GetPlayer()->GetGUIDLow()))
                pl->GetSession()->SendPacket(&data);
        }
    }
}

void Guild::BroadcastToOfficers(WorldSession *session, const std::string& msg, uint32 language)
{
    if (session && session->GetPlayer() && HasRankRight(session->GetPlayer()->GetRank(), GR_RIGHT_OFFCHATSPEAK))
    {
        for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
        {
            WorldPacket data;
            ChatHandler::FillMessageData(&data, session, CHAT_MSG_OFFICER, language, NULL, 0, msg.c_str(), NULL);

            Player *pl = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));

            if (pl && pl->GetSession() && HasRankRight(pl->GetRank(),GR_RIGHT_OFFCHATLISTEN) && !pl->GetSocial()->HasIgnore(session->GetPlayer()->GetGUIDLow()))
                pl->GetSession()->SendPacket(&data);
        }
    }
}

void Guild::BroadcastPacket(WorldPacket *packet)
{
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        Player *player = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));
        if (player)
            player->GetSession()->SendPacket(packet);
    }
}

void Guild::BroadcastPacketToRank(WorldPacket *packet, uint32 rankId)
{
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        if (itr->second.RankId == rankId)
        {
            Player *player = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));
            if (player)
                player->GetSession()->SendPacket(packet);
        }
    }
}

void Guild::CreateRank(std::string name_,uint32 rights)
{
    if (m_Ranks.size() >= GUILD_RANKS_MAX_COUNT)
        return;

    // ranks are sequence 0,1,2,... where 0 means guildmaster
    uint32 new_rank_id = m_Ranks.size();

    AddRank(name_, rights, 0);

    //existing records in db should be deleted before calling this procedure and m_PurchasedTabs must be loaded already

    for (uint32 i = 0; i < uint32(GetPurchasedTabs()); ++i)
    {
        //create bank rights with 0
        CharacterDatabase.PExecute("INSERT INTO guild_bank_right (guildid,TabId,rid) VALUES ('%u','%u','%u')", m_Id, i, new_rank_id);
    }
    // name now can be used for encoding to DB
    CharacterDatabase.escape_string(name_);
    CharacterDatabase.PExecute("INSERT INTO guild_rank (guildid,rid,rname,rights) VALUES ('%u', '%u', '%s', '%u')", m_Id, new_rank_id, name_.c_str(), rights);
}

void Guild::AddRank(const std::string& name_,uint32 rights, uint32 money)
{
    m_Ranks.push_back(RankInfo(name_,rights,money));
}

void Guild::DelRank()
{
    // client won't allow to have less than GUILD_RANKS_MIN_COUNT ranks in guild
    if (m_Ranks.size() <= GUILD_RANKS_MIN_COUNT)
        return;

    // delete lowest guild_rank
    uint32 rank = GetLowestRank();
    CharacterDatabase.PExecute("DELETE FROM guild_rank WHERE rid >= '%u' AND guildid='%u'", rank, m_Id);

    m_Ranks.pop_back();
}

std::string Guild::GetRankName(uint32 rankId)
{
    if (rankId >= m_Ranks.size())
        return "<unknown>";

    return m_Ranks[rankId].Name;
}

uint32 Guild::GetRankRights(uint32 rankId)
{
    if (rankId >= m_Ranks.size())
        return 0;

    return m_Ranks[rankId].Rights;
}

void Guild::SetRankName(uint32 rankId, std::string name_)
{
    if (rankId >= m_Ranks.size())
        return;

    m_Ranks[rankId].Name = name_;

    // name now can be used for encoding to DB
    CharacterDatabase.escape_string(name_);
    CharacterDatabase.PExecute("UPDATE guild_rank SET rname='%s' WHERE rid='%u' AND guildid='%u'", name_.c_str(), rankId, m_Id);
}

void Guild::SetRankRights(uint32 rankId, uint32 rights)
{
    if (rankId >= m_Ranks.size())
        return;

    m_Ranks[rankId].Rights = rights;

    CharacterDatabase.PExecute("UPDATE guild_rank SET rights='%u' WHERE rid='%u' AND guildid='%u'", rights, rankId, m_Id);
}

int32 Guild::GetRank(uint32 LowGuid)
{
    MemberList::const_iterator itr = members.find(LowGuid);
    if (itr == members.end())
        return -1;

    return itr->second.RankId;
}

void Guild::Disband()
{
    sScriptMgr.OnGuildDisband(this);
    BroadcastEvent(GE_DISBANDED, 0, 0, "", "", "");

    while (!members.empty())
    {
        MemberList::const_iterator itr = members.begin();
        DelMember(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER), true);
    }

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    trans->PAppend("DELETE FROM guild WHERE guildid = '%u'", m_Id);
    trans->PAppend("DELETE FROM guild_rank WHERE guildid = '%u'", m_Id);
    trans->PAppend("DELETE FROM guild_bank_tab WHERE guildid = '%u'", m_Id);

    //Free bank tab used memory and delete items stored in them
    DeleteGuildBankItems(trans, true);

    trans->PAppend("DELETE FROM guild_bank_item WHERE guildid = '%u'", m_Id);
    trans->PAppend("DELETE FROM guild_bank_right WHERE guildid = '%u'", m_Id);
    trans->PAppend("DELETE FROM guild_bank_eventlog WHERE guildid = '%u'", m_Id);
    trans->PAppend("DELETE FROM guild_eventlog WHERE guildid = '%u'", m_Id);
    CharacterDatabase.CommitTransaction(trans);
    sObjectMgr.RemoveGuild(m_Id);
}

void Guild::Roster(WorldSession *session /*= NULL*/)
{
                                                            // we can only guess size
    WorldPacket data(SMSG_GUILD_ROSTER, (4+MOTD.length()+1+GINFO.length()+1+4+m_Ranks.size()*(4+4+GUILD_BANK_MAX_TABS*(4+4))+members.size()*50));
    data << (uint32)members.size();
    data << MOTD;
    data << GINFO;

    data << (uint32)m_Ranks.size();
    for (RankList::const_iterator ritr = m_Ranks.begin(); ritr != m_Ranks.end(); ++ritr)
    {
        data << uint32(ritr->Rights);
        data << uint32(ritr->BankMoneyPerDay);              // count of: withdraw gold(gold/day) Note: in game set gold, in packet set bronze.
        for (int i = 0; i < GUILD_BANK_MAX_TABS; ++i)
        {
            data << uint32(ritr->TabRight[i]);              // for TAB_i rights: view tabs = 0x01, deposit items =0x02
            data << uint32(ritr->TabSlotPerDay[i]);         // for TAB_i count of: withdraw items(stack/day)
        }
    }
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        if (Player *pl = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER)))
        {
            data << uint64(pl->GetGUID());
            data << uint8(1);
            data << pl->GetName();
            data << uint32(itr->second.RankId);
            data << uint8(pl->getLevel());
            data << uint8(pl->getClass());
            data << uint8(0);                               // new 2.4.0
            data << uint32(pl->GetZoneId());
            data << itr->second.Pnote;
            data << itr->second.OFFnote;
        }
        else
        {
            data << uint64(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));
            data << uint8(0);
            data << itr->second.Name;
            data << uint32(itr->second.RankId);
            data << uint8(itr->second.Level);
            data << uint8(itr->second.Class);
            data << uint8(0);                               // new 2.4.0
            data << uint32(itr->second.ZoneId);
            data << float(float(time(NULL)-itr->second.LogoutTime) / DAY);
            data << itr->second.Pnote;
            data << itr->second.OFFnote;
        }
    }
    if (session)
        session->SendPacket(&data);
    else
        BroadcastPacket(&data);
    sLog.outDebug("WORLD: Sent (SMSG_GUILD_ROSTER)");
}

void Guild::Query(WorldSession *session)
{
    WorldPacket data(SMSG_GUILD_QUERY_RESPONSE, (8*32+200));// we can only guess size

    data << uint32(m_Id);
    data << m_Name;

    for (size_t i = 0 ; i < GUILD_RANKS_MAX_COUNT; ++i)     // show always 10 ranks
    {
        if (i < m_Ranks.size())
            data << m_Ranks[i].Name;
        else
            data << (uint8)0;                               // null string
    }

    data << uint32(m_EmblemStyle);
    data << uint32(m_EmblemColor);
    data << uint32(m_BorderStyle);
    data << uint32(m_BorderColor);
    data << uint32(m_BackgroundColor);
    data << uint32(0);                                      // something new in WotLK

    session->SendPacket(&data);
    sLog.outDebug("WORLD: Sent (SMSG_GUILD_QUERY_RESPONSE)");
}

void Guild::SetEmblem(uint32 emblemStyle, uint32 emblemColor, uint32 borderStyle, uint32 borderColor, uint32 backgroundColor)
{
    m_EmblemStyle = emblemStyle;
    m_EmblemColor = emblemColor;
    m_BorderStyle = borderStyle;
    m_BorderColor = borderColor;
    m_BackgroundColor = backgroundColor;

    CharacterDatabase.PExecute("UPDATE guild SET EmblemStyle=%u, EmblemColor=%u, BorderStyle=%u, BorderColor=%u, BackgroundColor=%u WHERE guildid = %u", m_EmblemStyle, m_EmblemColor, m_BorderStyle, m_BorderColor, m_BackgroundColor, m_Id);
}

void Guild::UpdateLogoutTime(uint64 guid)
{
    MemberList::iterator itr = members.find(GUID_LOPART(guid));
    if (itr == members.end())
        return;

    itr->second.LogoutTime = time(NULL);
}

/**
 * Updates the number of accounts that are in the guild
 * A player may have many characters in the guild, but with the same account
 */
void Guild::UpdateAccountsNumber()
{
    // We use a set to be sure each element will be unique
    std::set<uint32> accountsIdSet;
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
        accountsIdSet.insert(itr->second.accountId);

    m_accountsNumber = accountsIdSet.size();
}

// *************************************************
// Guild Eventlog part
// *************************************************
// Display guild eventlog
void Guild::DisplayGuildEventLog(WorldSession *session)
{
    // Sending result
    WorldPacket data(MSG_GUILD_EVENT_LOG_QUERY, 0);
    // count, max count == 100
    data << uint8(m_GuildEventLog.size());
    for (GuildEventLog::const_iterator itr = m_GuildEventLog.begin(); itr != m_GuildEventLog.end(); ++itr)
    {
        // Event type
        data << uint8(itr->EventType);
        // Player 1
        data << uint64(itr->PlayerGuid1);
        // Player 2 not for left/join guild events
        if (itr->EventType != GUILD_EVENT_LOG_JOIN_GUILD && itr->EventType != GUILD_EVENT_LOG_LEAVE_GUILD)
            data << uint64(itr->PlayerGuid2);
        // New Rank - only for promote/demote guild events
        if (itr->EventType == GUILD_EVENT_LOG_PROMOTE_PLAYER || itr->EventType == GUILD_EVENT_LOG_DEMOTE_PLAYER)
            data << uint8(itr->NewRank);
        // Event timestamp
        data << uint32(time(NULL)-itr->TimeStamp);
    }
    session->SendPacket(&data);
    sLog.outDebug("WORLD: Sent (MSG_GUILD_EVENT_LOG_QUERY)");
}

// Add entry to guild eventlog
void Guild::LogGuildEvent(uint8 EventType, uint32 PlayerGuid1, uint32 PlayerGuid2, uint8 NewRank)
{
    GuildEventLogEntry NewEvent;
    // Create event
    NewEvent.EventType = EventType;
    NewEvent.PlayerGuid1 = PlayerGuid1;
    NewEvent.PlayerGuid2 = PlayerGuid2;
    NewEvent.NewRank = NewRank;
    NewEvent.TimeStamp = uint32(time(NULL));
    // Count new LogGuid
    m_GuildEventLogNextGuid = (m_GuildEventLogNextGuid + 1) % sWorld.getIntConfig(CONFIG_GUILD_EVENT_LOG_COUNT);
    // Check max records limit
    if (m_GuildEventLog.size() >= GUILD_EVENTLOG_MAX_RECORDS)
        m_GuildEventLog.pop_front();
    // Add event to list
    m_GuildEventLog.push_back(NewEvent);
    // Save event to DB
    CharacterDatabase.PExecute("DELETE FROM guild_eventlog WHERE guildid='%u' AND LogGuid='%u'", m_Id, m_GuildEventLogNextGuid);
    CharacterDatabase.PExecute("INSERT INTO guild_eventlog (guildid, LogGuid, EventType, PlayerGuid1, PlayerGuid2, NewRank, TimeStamp) VALUES ('%u','%u','%u','%u','%u','%u','" UI64FMTD "')",
        m_Id, m_GuildEventLogNextGuid, uint32(NewEvent.EventType), NewEvent.PlayerGuid1, NewEvent.PlayerGuid2, uint32(NewEvent.NewRank), NewEvent.TimeStamp);
}

// *************************************************
// Guild Bank part
// *************************************************
// Bank content related
void Guild::DisplayGuildBankContent(WorldSession *session, uint8 TabId)
{
    GuildBankTab const* tab = m_TabListMap[TabId];

    if (!IsMemberHaveRights(session->GetPlayer()->GetGUIDLow(), TabId, GUILD_BANK_RIGHT_VIEW_TAB))
        return;

    WorldPacket data(SMSG_GUILD_BANK_LIST, 1200);

    data << uint64(GetGuildBankMoney());
    data << uint8(TabId);
    data << uint32(GetMemberSlotWithdrawRem(session->GetPlayer()->GetGUIDLow(), TabId)); // remaining slots for today
    data << uint8(0);                                       // Tell client that there's no tab info in this packet

    data << uint8(GUILD_BANK_MAX_SLOTS);

    for (uint8 i=0; i < GUILD_BANK_MAX_SLOTS; ++i)
        AppendDisplayGuildBankSlot(data, tab, i);

    session->SendPacket(&data);

    sLog.outDebug("WORLD: Sent (SMSG_GUILD_BANK_LIST)");
}

void Guild::DisplayGuildBankContentUpdate(uint8 TabId, int32 slot1, int32 slot2)
{
    GuildBankTab const* tab = m_TabListMap[TabId];

    WorldPacket data(SMSG_GUILD_BANK_LIST, 1200);

    data << uint64(GetGuildBankMoney());
    data << uint8(TabId);

    size_t rempos = data.wpos();
    data << uint32(0);                                      // item withdraw amount, will be filled later
    data << uint8(0);                                       // Tell client that there's no tab info in this packet

    if (slot2 == -1)                                        // single item in slot1
    {
        data << uint8(1);                                   // item count

        AppendDisplayGuildBankSlot(data, tab, slot1);
    }
    else                                                    // 2 items (in slot1 and slot2)
    {
        data << uint8(2);                                   // item count

        if (slot1 > slot2)
            std::swap(slot1,slot2);

        AppendDisplayGuildBankSlot(data, tab, slot1);
        AppendDisplayGuildBankSlot(data, tab, slot2);
    }

    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        Player *player = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));
        if (!player)
            continue;

        if (!IsMemberHaveRights(itr->first,TabId,GUILD_BANK_RIGHT_VIEW_TAB))
            continue;

        data.put<uint32>(rempos,uint32(GetMemberSlotWithdrawRem(player->GetGUIDLow(), TabId)));

        player->GetSession()->SendPacket(&data);
    }

    sLog.outDebug("WORLD: Sent (SMSG_GUILD_BANK_LIST)");
}

void Guild::DisplayGuildBankContentUpdate(uint8 TabId, GuildItemPosCountVec const& slots)
{
    GuildBankTab const* tab = m_TabListMap[TabId];

    WorldPacket data(SMSG_GUILD_BANK_LIST, 1200);

    data << uint64(GetGuildBankMoney());
    data << uint8(TabId);

    size_t rempos = data.wpos();
    data << uint32(0);                                      // item withdraw amount, will be filled later
    data << uint8(0);                                       // Tell client that there's no tab info in this packet

    data << uint8(slots.size());                            // updates count

    for (GuildItemPosCountVec::const_iterator itr = slots.begin(); itr != slots.end(); ++itr)
        AppendDisplayGuildBankSlot(data, tab, itr->Slot);

    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        Player *player = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(itr->first, 0, HIGHGUID_PLAYER));
        if (!player)
            continue;

        if (!IsMemberHaveRights(itr->first,TabId,GUILD_BANK_RIGHT_VIEW_TAB))
            continue;

        data.put<uint32>(rempos,uint32(GetMemberSlotWithdrawRem(player->GetGUIDLow(), TabId)));

        player->GetSession()->SendPacket(&data);
    }

    sLog.outDebug("WORLD: Sent (SMSG_GUILD_BANK_LIST)");
}

Item* Guild::GetItem(uint8 TabId, uint8 SlotId)
{
    if (TabId >= GetPurchasedTabs() || SlotId >= GUILD_BANK_MAX_SLOTS)
        return NULL;
    return m_TabListMap[TabId]->Slots[SlotId];
}

// *************************************************
// Tab related

void Guild::DisplayGuildBankTabsInfo(WorldSession *session)
{
    WorldPacket data(SMSG_GUILD_BANK_LIST, 500);

    data << uint64(GetGuildBankMoney());
    data << uint8(0);                                       // TabInfo packet must be for TabId 0
    data << uint32(GetMemberSlotWithdrawRem(session->GetPlayer()->GetGUIDLow(), 0));
    data << uint8(1);                                       // Tell client that this packet includes tab info
    data << uint8(GetPurchasedTabs());                      // here is the number of tabs

    for (uint8 i = 0; i < GetPurchasedTabs(); ++i)
    {
        data << m_TabListMap[i]->Name.c_str();
        data << m_TabListMap[i]->Icon.c_str();
    }
    data << uint8(0);                                       // Do not send tab content
    session->SendPacket(&data);

    sLog.outDebug("WORLD: Sent (SMSG_GUILD_BANK_LIST)");
}

void Guild::DisplayGuildBankMoneyUpdate(WorldSession *session)
{
    WorldPacket data(SMSG_GUILD_BANK_LIST, 8+1+4+1+1);

    data << uint64(GetGuildBankMoney());
    data << uint8(0);                                       // TabId, default 0
    data << uint32(GetMemberSlotWithdrawRem(session->GetPlayer()->GetGUIDLow(), 0));
    data << uint8(0);                                       // Tell that there's no tab info in this packet
    data << uint8(0);                                       // not send items
    BroadcastPacket(&data);

    sLog.outDebug("WORLD: Sent (SMSG_GUILD_BANK_LIST)");
}

void Guild::CreateNewBankTab()
{
    if (GetPurchasedTabs() >= GUILD_BANK_MAX_TABS)
        return;

    uint32 tabId = GetPurchasedTabs();                      // next free id
    m_TabListMap.push_back(new GuildBankTab);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    trans->PAppend("DELETE FROM guild_bank_tab WHERE guildid='%u' AND TabId='%u'", m_Id, tabId);
    trans->PAppend("INSERT INTO guild_bank_tab (guildid,TabId) VALUES ('%u','%u')", m_Id, tabId);
    CharacterDatabase.CommitTransaction(trans);
}

void Guild::SetGuildBankTabInfo(uint8 TabId, std::string Name, std::string Icon)
{
    if (m_TabListMap[TabId]->Name == Name && m_TabListMap[TabId]->Icon == Icon)
        return;

    m_TabListMap[TabId]->Name = Name;
    m_TabListMap[TabId]->Icon = Icon;

    CharacterDatabase.escape_string(Name);
    CharacterDatabase.escape_string(Icon);
    CharacterDatabase.PExecute("UPDATE guild_bank_tab SET TabName='%s',TabIcon='%s' WHERE guildid='%u' AND TabId='%u'", Name.c_str(), Icon.c_str(), m_Id, uint32(TabId));
}

uint32 Guild::GetBankRights(uint32 rankId, uint8 TabId) const
{
    if (rankId >= m_Ranks.size() || TabId >= GUILD_BANK_MAX_TABS)
        return 0;

    return m_Ranks[rankId].TabRight[TabId];
}

// *************************************************
// Money deposit/withdraw related

void Guild::SendMoneyInfo(WorldSession *session, uint32 LowGuid)
{
    WorldPacket data(MSG_GUILD_BANK_MONEY_WITHDRAWN, 4);
    data << uint32(GetMemberMoneyWithdrawRem(LowGuid));
    session->SendPacket(&data);
    sLog.outDebug("WORLD: Sent MSG_GUILD_BANK_MONEY_WITHDRAWN");
}

bool Guild::MemberMoneyWithdraw(uint32 amount, uint32 LowGuid, SQLTransaction& trans)
{
    uint32 MoneyWithDrawRight = GetMemberMoneyWithdrawRem(LowGuid);

    if (MoneyWithDrawRight < amount || GetGuildBankMoney() < amount)
        return false;

    SetBankMoney(GetGuildBankMoney()-amount, trans);

    if (MoneyWithDrawRight < WITHDRAW_MONEY_UNLIMITED)
    {
        MemberList::iterator itr = members.find(LowGuid);
        if (itr == members.end())
            return false;
        itr->second.BankRemMoney -= amount;
        trans->PAppend("UPDATE guild_member SET BankRemMoney='%u' WHERE guildid='%u' AND guid='%u'",
            itr->second.BankRemMoney, m_Id, LowGuid);
    }
    return true;
}

void Guild::SetBankMoney(int64 money, SQLTransaction& trans)
{
    if (money < 0)                                          // I don't know how this happens, it does!!
        money = 0;
    m_GuildBankMoney = money;

    trans->PAppend("UPDATE guild SET BankMoney='" UI64FMTD "' WHERE guildid='%u'", money, m_Id);
}

// *************************************************
// Item per day and money per day related

bool Guild::MemberItemWithdraw(uint8 TabId, uint32 LowGuid, SQLTransaction& trans)
{
    uint32 SlotsWithDrawRight = GetMemberSlotWithdrawRem(LowGuid, TabId);

    if (SlotsWithDrawRight == 0)
        return false;

    if (SlotsWithDrawRight < WITHDRAW_SLOT_UNLIMITED)
    {
        MemberList::iterator itr = members.find(LowGuid);
        if (itr == members.end())
            return false;
        --itr->second.BankRemSlotsTab[TabId];
        trans->PAppend("UPDATE guild_member SET BankRemSlotsTab%u='%u' WHERE guildid='%u' AND guid='%u'",
            uint32(TabId), itr->second.BankRemSlotsTab[TabId], m_Id, LowGuid);
    }
    return true;
}

bool Guild::IsMemberHaveRights(uint32 LowGuid, uint8 TabId, uint32 rights) const
{
    MemberList::const_iterator itr = members.find(LowGuid);
    if (itr == members.end())
        return false;

    if (itr->second.RankId == GR_GUILDMASTER)
        return true;

    return (GetBankRights(itr->second.RankId,TabId) & rights) == rights;
}

uint32 Guild::GetMemberSlotWithdrawRem(uint32 LowGuid, uint8 TabId)
{
    MemberList::iterator itr = members.find(LowGuid);
    if (itr == members.end())
        return 0;

    if (itr->second.RankId == GR_GUILDMASTER)
        return WITHDRAW_SLOT_UNLIMITED;

    if ((GetBankRights(itr->second.RankId,TabId) & GUILD_BANK_RIGHT_VIEW_TAB) != GUILD_BANK_RIGHT_VIEW_TAB)
        return 0;

    uint32 curTime = uint32(time(NULL)/MINUTE);
    if (curTime - itr->second.BankResetTimeTab[TabId] >= 24*HOUR/MINUTE)
    {
        itr->second.BankResetTimeTab[TabId] = curTime;
        itr->second.BankRemSlotsTab[TabId] = GetBankSlotPerDay(itr->second.RankId, TabId);
        CharacterDatabase.PExecute("UPDATE guild_member SET BankResetTimeTab%u='%u', BankRemSlotsTab%u='%u' WHERE guildid='%u' AND guid='%u'",
            uint32(TabId), itr->second.BankResetTimeTab[TabId], uint32(TabId), itr->second.BankRemSlotsTab[TabId], m_Id, LowGuid);
    }
    return itr->second.BankRemSlotsTab[TabId];
}

uint32 Guild::GetMemberMoneyWithdrawRem(uint32 LowGuid)
{
    MemberList::iterator itr = members.find(LowGuid);
    if (itr == members.end())
        return 0;

    if (itr->second.RankId == GR_GUILDMASTER)
        return WITHDRAW_MONEY_UNLIMITED;

    uint32 curTime = uint32(time(NULL)/MINUTE);             // minutes
                                                            // 24 hours
    if (curTime > itr->second.BankResetTimeMoney + 24*HOUR/MINUTE)
    {
        itr->second.BankResetTimeMoney = curTime;
        itr->second.BankRemMoney = GetBankMoneyPerDay(itr->second.RankId);
        CharacterDatabase.PExecute("UPDATE guild_member SET BankResetTimeMoney='%u', BankRemMoney='%u' WHERE guildid='%u' AND guid='%u'",
            itr->second.BankResetTimeMoney, itr->second.BankRemMoney, m_Id, LowGuid);
    }
    return itr->second.BankRemMoney;
}

void Guild::SetBankMoneyPerDay(uint32 rankId, uint32 money)
{
    if (rankId >= m_Ranks.size())
        return;

    if (rankId == GR_GUILDMASTER)
        money = WITHDRAW_MONEY_UNLIMITED;

    m_Ranks[rankId].BankMoneyPerDay = money;

    for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
        if (itr->second.RankId == rankId)
            itr->second.BankResetTimeMoney = 0;

    CharacterDatabase.PExecute("UPDATE guild_rank SET BankMoneyPerDay='%u' WHERE rid='%u' AND guildid='%u'", money, rankId, m_Id);
    CharacterDatabase.PExecute("UPDATE guild_member SET BankResetTimeMoney='0' WHERE guildid='%u' AND rank='%u'", m_Id, rankId);
}

void Guild::SetBankRightsAndSlots(uint32 rankId, uint8 TabId, uint32 right, uint32 nbSlots, bool db)
{
    if (rankId >= m_Ranks.size() || TabId >= GetPurchasedTabs())
        return;

    if (rankId == GR_GUILDMASTER)
    {
        nbSlots = WITHDRAW_SLOT_UNLIMITED;
        right = GUILD_BANK_RIGHT_FULL;
    }

    m_Ranks[rankId].TabSlotPerDay[TabId] = nbSlots;
    m_Ranks[rankId].TabRight[TabId] = right;

    if (db)
    {
        for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
            if (itr->second.RankId == rankId)
                for (uint8 i = 0; i < GUILD_BANK_MAX_TABS; ++i)
                    itr->second.BankResetTimeTab[i] = 0;

        CharacterDatabase.PExecute("DELETE FROM guild_bank_right WHERE guildid='%u' AND TabId='%u' AND rid='%u'", m_Id, uint32(TabId), rankId);
        CharacterDatabase.PExecute("INSERT INTO guild_bank_right (guildid,TabId,rid,gbright,SlotPerDay) VALUES "
            "('%u','%u','%u','%u','%u')", m_Id, uint32(TabId), rankId, m_Ranks[rankId].TabRight[TabId], m_Ranks[rankId].TabSlotPerDay[TabId]);
        CharacterDatabase.PExecute("UPDATE guild_member SET BankResetTimeTab%u='0' WHERE guildid='%u' AND rank='%u'", uint32(TabId), m_Id, rankId);
    }
}

uint32 Guild::GetBankMoneyPerDay(uint32 rankId)
{
    if (rankId >= m_Ranks.size())
        return 0;

    if (rankId == GR_GUILDMASTER)
        return WITHDRAW_MONEY_UNLIMITED;
    return m_Ranks[rankId].BankMoneyPerDay;
}

uint32 Guild::GetBankSlotPerDay(uint32 rankId, uint8 TabId)
{
    if (rankId >= m_Ranks.size() || TabId >= GUILD_BANK_MAX_TABS)
        return 0;

    if (rankId == GR_GUILDMASTER)
        return WITHDRAW_SLOT_UNLIMITED;
    return m_Ranks[rankId].TabSlotPerDay[TabId];
}

// *************************************************
// Rights per day related

bool Guild::LoadBankRightsFromDB(QueryResult guildBankTabRightsResult)
{
    if (!guildBankTabRightsResult)
        return true;

    do
    {
        Field *fields      = guildBankTabRightsResult->Fetch();
        //prevent crash when all rights in result are already processed
        if (!fields)
            break;
        uint32 guildId     = fields[0].GetUInt32();
        if (guildId < m_Id)
        {
            //there is in table guild_bank_right record which doesn't have guildid in guild table, report error
            sLog.outErrorDb("Guild %u does not exist but it has a record in guild_bank_right table, deleting it!", guildId);
            CharacterDatabase.PExecute("DELETE FROM guild_bank_right WHERE guildid = '%u'", guildId);
            continue;
        }

        if (guildId > m_Id)
            //we loaded all ranks for this guild bank already, break cycle
            break;
        uint8 TabId        = fields[1].GetUInt8();
        uint32 rankId      = fields[2].GetUInt32();
        uint16 right       = fields[3].GetUInt16();
        uint16 SlotPerDay  = fields[4].GetUInt16();

        SetBankRightsAndSlots(rankId, TabId, right, SlotPerDay, false);

    }while (guildBankTabRightsResult->NextRow());

    return true;
}

// *************************************************
// Bank log related


void Guild::DisplayGuildBankLogs(WorldSession *session, uint8 TabId)
{
    if (TabId > GUILD_BANK_MAX_TABS)                   // tabs starts in 0
        return;

    if (TabId == GUILD_BANK_MAX_TABS)
    {
        // Here we display money logs
        WorldPacket data(MSG_GUILD_BANK_LOG_QUERY, m_GuildBankEventLog_Money.size()*(4*4+1)+1+1);
        data << uint8(TabId);                               // Here GUILD_BANK_MAX_TABS
        data << uint8(m_GuildBankEventLog_Money.size());    // number of log entries
        for (GuildBankEventLog::const_iterator itr = m_GuildBankEventLog_Money.begin(); itr != m_GuildBankEventLog_Money.end(); ++itr)
        {
            data << uint8(itr->EventType);
            data << uint64(MAKE_NEW_GUID(itr->PlayerGuid,0,HIGHGUID_PLAYER));
            data << uint32(itr->ItemOrMoney);
            data << uint32(time(NULL) - itr->TimeStamp);
        }
        session->SendPacket(&data);
    }
    else
    {
        // here we display current tab logs
        WorldPacket data(MSG_GUILD_BANK_LOG_QUERY, m_GuildBankEventLog_Item[TabId].size()*(4*4+1+1)+1+1);
        data << uint8(TabId);                               // Here a real Tab Id
        data << uint8(m_GuildBankEventLog_Item[TabId].size()); // number of log entries
        for (GuildBankEventLog::const_iterator itr = m_GuildBankEventLog_Item[TabId].begin(); itr != m_GuildBankEventLog_Item[TabId].end(); ++itr)
        {
            data << uint8(itr->EventType);
            data << uint64(MAKE_NEW_GUID(itr->PlayerGuid,0,HIGHGUID_PLAYER));
            data << uint32(itr->ItemOrMoney);
            data << uint32(itr->ItemStackCount);
            if (itr->EventType == GUILD_BANK_LOG_MOVE_ITEM || itr->EventType == GUILD_BANK_LOG_MOVE_ITEM2)
                data << uint8(itr->DestTabId);          // moved tab
            data << uint32(time(NULL) - itr->TimeStamp);
        }
        session->SendPacket(&data);
    }
    sLog.outDebug("WORLD: Sent (MSG_GUILD_BANK_LOG_QUERY)");
}

void Guild::LogBankEvent(SQLTransaction& trans, uint8 EventType, uint8 TabId, uint32 PlayerGuidLow, uint32 ItemOrMoney, uint16 ItemStackCount, uint8 DestTabId)
{
    //create Event
    GuildBankEventLogEntry NewEvent;
    NewEvent.EventType = EventType;
    NewEvent.PlayerGuid = PlayerGuidLow;
    NewEvent.ItemOrMoney = ItemOrMoney;
    NewEvent.ItemStackCount = ItemStackCount;
    NewEvent.DestTabId = DestTabId;
    NewEvent.TimeStamp = uint32(time(NULL));

    //add new event to the end of event list
    uint32 currentTabId = TabId;
    uint32 currentLogGuid = 0;
    if (NewEvent.isMoneyEvent())
    {
        m_GuildBankEventLogNextGuid_Money = (m_GuildBankEventLogNextGuid_Money + 1) % sWorld.getIntConfig(CONFIG_GUILD_BANK_EVENT_LOG_COUNT);
        currentLogGuid = m_GuildBankEventLogNextGuid_Money;
        currentTabId = GUILD_BANK_MONEY_LOGS_TAB;
        if (m_GuildBankEventLog_Money.size() >= GUILD_BANK_MAX_LOGS)
            m_GuildBankEventLog_Money.pop_front();

        m_GuildBankEventLog_Money.push_back(NewEvent);
    }
    else
    {
        m_GuildBankEventLogNextGuid_Item[TabId] = ((m_GuildBankEventLogNextGuid_Item[TabId]) + 1) % sWorld.getIntConfig(CONFIG_GUILD_BANK_EVENT_LOG_COUNT);
        currentLogGuid = m_GuildBankEventLogNextGuid_Item[TabId];
        if (m_GuildBankEventLog_Item[TabId].size() >= GUILD_BANK_MAX_LOGS)
            m_GuildBankEventLog_Item[TabId].pop_front();

        m_GuildBankEventLog_Item[TabId].push_back(NewEvent);
    }

    //save event to database
    trans->PAppend("DELETE FROM guild_bank_eventlog WHERE guildid='%u' AND LogGuid='%u' AND TabId='%u'", m_Id, currentLogGuid, currentTabId);

    trans->PAppend("INSERT INTO guild_bank_eventlog (guildid,LogGuid,TabId,EventType,PlayerGuid,ItemOrMoney,ItemStackCount,DestTabId,TimeStamp) VALUES ('%u','%u','%u','%u','%u','%u','%u','%u','" UI64FMTD "')",
        m_Id, currentLogGuid, currentTabId, uint32(NewEvent.EventType), NewEvent.PlayerGuid, NewEvent.ItemOrMoney, uint32(NewEvent.ItemStackCount), uint32(NewEvent.DestTabId), NewEvent.TimeStamp);
}

bool Guild::AddGBankItemToDB(uint32 GuildId, uint32 BankTab , uint32 BankTabSlot , uint32 GUIDLow, uint32 Entry, SQLTransaction& trans)
{
    trans->PAppend("DELETE FROM guild_bank_item WHERE guildid = '%u' AND TabId = '%u'AND SlotId = '%u'", GuildId, BankTab, BankTabSlot);
    trans->PAppend("INSERT INTO guild_bank_item (guildid,TabId,SlotId,item_guid,item_entry) "
        "VALUES ('%u', '%u', '%u', '%u', '%u')", GuildId, BankTab, BankTabSlot, GUIDLow, Entry);
    return true;
}

void Guild::AppendDisplayGuildBankSlot(WorldPacket& data, GuildBankTab const *tab, int slot)
{
    Item *pItem = tab->Slots[slot];
    uint32 entry = pItem ? pItem->GetEntry() : 0;

    data << uint8(slot);
    data << uint32(entry);
    if (entry)
    {
        data << uint32(0);                                  // 3.3.0 (0x8000, 0x8020)
        data << uint32(pItem->GetItemRandomPropertyId());   // random item property id + 8

        if (pItem->GetItemRandomPropertyId())
            data << uint32(pItem->GetItemSuffixFactor());   // SuffixFactor + 4

        data << uint32(pItem->GetCount());                  // +12 ITEM_FIELD_STACK_COUNT
        data << uint32(0);                                  // +16 Unknown value
        data << uint8(abs(pItem->GetSpellCharges()));       // spell charges

        uint8 enchCount = 0;
        size_t enchCountPos = data.wpos();

        data << uint8(enchCount);                           // number of enchantments
        for (uint32 i = PERM_ENCHANTMENT_SLOT; i < MAX_ENCHANTMENT_SLOT; ++i)
        {
            if (uint32 enchId = pItem->GetEnchantmentId(EnchantmentSlot(i)))
            {
                data << uint8(i);
                data << uint32(enchId);
                ++enchCount;
            }
        }
        data.put<uint8>(enchCountPos, enchCount);
    }
}

Item* Guild::StoreItem(uint8 tabId, GuildItemPosCountVec const& dest, Item* pItem, SQLTransaction& trans)
{
    if (!pItem)
        return NULL;

    Item* lastItem = pItem;

    for (GuildItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end();)
    {
        uint8 slot = itr->Slot;
        uint32 count = itr->Count;

        ++itr;

        if (itr == dest.end())
        {
            lastItem = _StoreItem(tabId, slot, pItem, count, false, trans);
            break;
        }

        lastItem = _StoreItem(tabId, slot, pItem, count, true, trans);
    }

    return lastItem;
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Guild::_StoreItem(uint8 tab, uint8 slot, Item *pItem, uint32 count, bool clone, SQLTransaction& trans)
{
    if (!pItem)
        return NULL;

    sLog.outDebug("GUILD STORAGE: StoreItem tab = %u, slot = %u, item = %u, count = %u", tab, slot, pItem->GetEntry(), count);

    Item* pItem2 = m_TabListMap[tab]->Slots[slot];

    if (!pItem2)
    {
        if (clone)
            pItem = pItem->CloneItem(count);
        else
            pItem->SetCount(count);

        if (!pItem)
            return NULL;

        m_TabListMap[tab]->Slots[slot] = pItem;

        pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
        pItem->SetUInt64Value(ITEM_FIELD_OWNER, 0);
        AddGBankItemToDB(GetId(), tab, slot, pItem->GetGUIDLow(), pItem->GetEntry(), trans);
        pItem->FSetState(ITEM_NEW);
        pItem->SaveToDB(trans);                                  // not in inventory and can be save standalone

        return pItem;
    }
    else
    {
        pItem2->SetCount(pItem2->GetCount() + count);
        pItem2->FSetState(ITEM_CHANGED);
        pItem2->SaveToDB(trans);                                 // not in inventory and can be save standalone

        if (!clone)
        {
            pItem->RemoveFromWorld();
            pItem->DeleteFromDB(trans);
            delete pItem;
        }

        return pItem2;
    }
}

void Guild::RemoveItem(uint8 tab, uint8 slot, SQLTransaction& trans)
{
    m_TabListMap[tab]->Slots[slot] = NULL;
    trans->PAppend("DELETE FROM guild_bank_item WHERE guildid='%u' AND TabId='%u' AND SlotId='%u'",
        GetId(), uint32(tab), uint32(slot));
}

uint8 Guild::_CanStoreItem_InSpecificSlot(uint8 tab, uint8 slot, GuildItemPosCountVec &dest, uint32& count, bool swap, Item* pSrcItem) const
{
    Item* pItem2 = m_TabListMap[tab]->Slots[slot];

    // ignore move item (this slot will be empty at move)
    if (pItem2 == pSrcItem)
        pItem2 = NULL;

    uint32 need_space;

    // empty specific slot - check item fit to slot
    if (!pItem2 || swap)
    {
        // non empty stack with space
        need_space = pSrcItem->GetMaxStackCount();
    }
    // non empty slot, check item type
    else
    {
        // check item type
        if (pItem2->GetEntry() != pSrcItem->GetEntry())
            return EQUIP_ERR_ITEM_CANT_STACK;

        // check free space
        if (pItem2->GetCount() >= pSrcItem->GetMaxStackCount())
            return EQUIP_ERR_ITEM_CANT_STACK;

        need_space = pSrcItem->GetMaxStackCount() - pItem2->GetCount();
    }

    if (need_space > count)
        need_space = count;

    GuildItemPosCount newPosition = GuildItemPosCount(slot,need_space);
    if (!newPosition.isContainedIn(dest))
    {
        dest.push_back(newPosition);
        count -= need_space;
    }

    return EQUIP_ERR_OK;
}

uint8 Guild::_CanStoreItem_InTab(uint8 tab, GuildItemPosCountVec &dest, uint32& count, bool merge, Item* pSrcItem, uint8 skip_slot) const
{
    ASSERT(pSrcItem);
    for (uint32 j = 0; j < GUILD_BANK_MAX_SLOTS; ++j)
    {
        // skip specific slot already processed in first called _CanStoreItem_InSpecificSlot
        if (j == skip_slot)
            continue;

        Item* pItem2 = m_TabListMap[tab]->Slots[j];

        // ignore move item (this slot will be empty at move)
        if (pItem2 == pSrcItem)
            pItem2 = NULL;

        // if merge skip empty, if !merge skip non-empty
        if ((pItem2 != NULL) != merge)
            continue;

        if (pItem2)
        {
            if (pItem2->GetEntry() == pSrcItem->GetEntry() && pItem2->GetCount() < pSrcItem->GetMaxStackCount())
            {
                uint32 need_space = pSrcItem->GetMaxStackCount() - pItem2->GetCount();
                if (need_space > count)
                    need_space = count;

                GuildItemPosCount newPosition = GuildItemPosCount(j, need_space);
                if (!newPosition.isContainedIn(dest))
                {
                    dest.push_back(newPosition);
                    count -= need_space;

                    if (count == 0)
                        return EQUIP_ERR_OK;
                }
            }
        }
        else
        {
            uint32 need_space = pSrcItem->GetMaxStackCount();
            if (need_space > count)
                need_space = count;

            GuildItemPosCount newPosition = GuildItemPosCount(j, need_space);
            if (!newPosition.isContainedIn(dest))
            {
                dest.push_back(newPosition);
                count -= need_space;

                if (count == 0)
                    return EQUIP_ERR_OK;
            }
        }
    }
    return EQUIP_ERR_OK;
}

uint8 Guild::CanStoreItem(uint8 tab, uint8 slot, GuildItemPosCountVec &dest, uint32 count, Item *pItem, bool swap) const
{
    sLog.outDebug("GUILD STORAGE: CanStoreItem tab = %u, slot = %u, item = %u, count = %u", tab, slot, pItem->GetEntry(), count);

    if (count > pItem->GetCount())
        return EQUIP_ERR_COULDNT_SPLIT_ITEMS;

    if (pItem->IsSoulBound())
        return EQUIP_ERR_CANT_DROP_SOULBOUND;

    // in specific tab
    if (tab >= m_TabListMap.size() || tab >= GUILD_BANK_MAX_TABS)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    // in specific slot
    if (slot != NULL_SLOT)
    {
        uint8 res = _CanStoreItem_InSpecificSlot(tab,slot,dest,count,swap,pItem);
        if (res != EQUIP_ERR_OK)
            return res;

        if (count == 0)
            return EQUIP_ERR_OK;
    }

    // not specific slot or have space for partly store only in specific slot

    // search stack in tab for merge to
    if (pItem->GetMaxStackCount() > 1)
    {
        uint8 res = _CanStoreItem_InTab(tab, dest, count, true, pItem, slot);
        if (res != EQUIP_ERR_OK)
            return res;

        if (count == 0)
            return EQUIP_ERR_OK;
    }

    // search free slot in bag for place to
    uint8 res = _CanStoreItem_InTab(tab, dest, count, false, pItem, slot);
    if (res != EQUIP_ERR_OK)
        return res;

    if (count == 0)
        return EQUIP_ERR_OK;

    return EQUIP_ERR_BANK_FULL;
}

void Guild::SetGuildBankTabText(uint8 TabId, std::string text)
{
    if (TabId >= GetPurchasedTabs())
        return;

    if (!m_TabListMap[TabId])
        return;

    if (m_TabListMap[TabId]->Text == text)
        return;

    utf8truncate(text, 500);                                 // DB and client size limitation

    m_TabListMap[TabId]->Text = text;

    CharacterDatabase.escape_string(text);
    CharacterDatabase.PExecute("UPDATE guild_bank_tab SET TabText='%s' WHERE guildid='%u' AND TabId='%u'", text.c_str(), m_Id, uint32(TabId));

    // announce
    SendGuildBankTabText(NULL,TabId);
}

void Guild::SendGuildBankTabText(WorldSession *session, uint8 TabId)
{
    GuildBankTab const* tab = m_TabListMap[TabId];

    WorldPacket data(MSG_QUERY_GUILD_BANK_TEXT, 1+tab->Text.size()+1);
    data << uint8(TabId);
    data << tab->Text;

    if (session)
        session->SendPacket(&data);
    else
        BroadcastPacket(&data);
}

void Guild::SwapItems(Player * pl, uint8 BankTab, uint8 BankTabSlot, uint8 BankTabDst, uint8 BankTabSlotDst, uint32 SplitedAmount)
{
    // empty operation
    if (BankTab == BankTabDst && BankTabSlot == BankTabSlotDst)
        return;

    Item *pItemSrc = GetItem(BankTab, BankTabSlot);
    if (!pItemSrc)                                      // may prevent crash
        return;

    if (pItemSrc->GetCount() == 0)
    {
        sLog.outCrash("Guild::SwapItems: Player %s(GUIDLow: %u) tried to move item %u from tab %u slot %u to tab %u slot %u, but item %u has a stack of zero!",
            pl->GetName(), pl->GetGUIDLow(), pItemSrc->GetEntry(), BankTab, BankTabSlot, BankTabDst, BankTabSlotDst, pItemSrc->GetEntry());
        //return; // Commented out for now, uncomment when it's verified that this causes a crash!!
    }

    if (SplitedAmount >= pItemSrc->GetCount())
        SplitedAmount = 0;                              // no split

    Item *pItemDst = GetItem(BankTabDst, BankTabSlotDst);

    if (BankTab != BankTabDst)
    {
        // check dest pos rights (if different tabs)
        if (!IsMemberHaveRights(pl->GetGUIDLow(), BankTabDst, GUILD_BANK_RIGHT_DEPOSIT_ITEM))
            return;

        // check source pos rights (if different tabs)
        uint32 remRight = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTab);
        if (remRight <= 0)
            return;
    }

    if (SplitedAmount)
    {                                                   // Bank -> Bank item split (in empty or non empty slot
        GuildItemPosCountVec dest;
        uint8 msg = CanStoreItem(BankTabDst, BankTabSlotDst, dest, SplitedAmount, pItemSrc, false);
        if (msg != EQUIP_ERR_OK)
        {
            pl->SendEquipError(msg, pItemSrc, NULL);
            return;
        }

        Item *pNewItem = pItemSrc->CloneItem(SplitedAmount);
        if (!pNewItem)
        {
            pl->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItemSrc, NULL);
            return;
        }

        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        LogBankEvent(trans, GUILD_BANK_LOG_MOVE_ITEM, BankTab, pl->GetGUIDLow(), pItemSrc->GetEntry(), SplitedAmount, BankTabDst);

        pl->ItemRemovedQuestCheck(pItemSrc->GetEntry(), SplitedAmount);
        pItemSrc->SetCount(pItemSrc->GetCount() - SplitedAmount);
        pItemSrc->FSetState(ITEM_CHANGED);
        pItemSrc->SaveToDB(trans);                           // not in inventory and can be save standalone
        StoreItem(BankTabDst, dest, pNewItem, trans);
        CharacterDatabase.CommitTransaction(trans);
    }
    else                                                // non split
    {
        GuildItemPosCountVec gDest;
        uint8 msg = CanStoreItem(BankTabDst, BankTabSlotDst, gDest, pItemSrc->GetCount(), pItemSrc, false);
        if (msg == EQUIP_ERR_OK)                        // merge to
        {
            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            LogBankEvent(trans, GUILD_BANK_LOG_MOVE_ITEM, BankTab, pl->GetGUIDLow(), pItemSrc->GetEntry(), pItemSrc->GetCount(), BankTabDst);

            RemoveItem(BankTab, BankTabSlot, trans);
            StoreItem(BankTabDst, gDest, pItemSrc, trans);
            CharacterDatabase.CommitTransaction(trans);
        }
        else                                            // swap
        {
            gDest.clear();
            msg = CanStoreItem(BankTabDst, BankTabSlotDst, gDest, pItemSrc->GetCount(), pItemSrc, true);
            if (msg != EQUIP_ERR_OK)
            {
                pl->SendEquipError(msg, pItemSrc, NULL);
                return;
            }

            GuildItemPosCountVec gSrc;
            msg = CanStoreItem(BankTab, BankTabSlot, gSrc, pItemDst->GetCount(), pItemDst, true);
            if (msg != EQUIP_ERR_OK)
            {
                pl->SendEquipError(msg, pItemDst, NULL);
                return;
            }

            if (BankTab != BankTabDst)
            {
                // check source pos rights (item swapped to src)
                if (!IsMemberHaveRights(pl->GetGUIDLow(), BankTab, GUILD_BANK_RIGHT_DEPOSIT_ITEM))
                    return;

                // check dest pos rights (item swapped to src)
                uint32 remRightDst = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTabDst);
                if (remRightDst <= 0)
                    return;
            }

            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            LogBankEvent(trans, GUILD_BANK_LOG_MOVE_ITEM, BankTab,    pl->GetGUIDLow(), pItemSrc->GetEntry(), pItemSrc->GetCount(), BankTabDst);
            LogBankEvent(trans, GUILD_BANK_LOG_MOVE_ITEM, BankTabDst, pl->GetGUIDLow(), pItemDst->GetEntry(), pItemDst->GetCount(), BankTab);

            RemoveItem(BankTab, BankTabSlot, trans);
            RemoveItem(BankTabDst, BankTabSlotDst, trans);
            StoreItem(BankTab, gSrc, pItemDst, trans);
            StoreItem(BankTabDst, gDest, pItemSrc, trans);
            CharacterDatabase.CommitTransaction(trans);
        }
    }
    DisplayGuildBankContentUpdate(BankTab,BankTabSlot,BankTab == BankTabDst ? BankTabSlotDst : -1);
    if (BankTab != BankTabDst)
        DisplayGuildBankContentUpdate(BankTabDst,BankTabSlotDst);
}

void Guild::MoveFromBankToChar(Player * pl, uint8 BankTab, uint8 BankTabSlot, uint8 PlayerBag, uint8 PlayerSlot, uint32 SplitedAmount)
{
    Item *pItemBank = GetItem(BankTab, BankTabSlot);
    Item *pItemChar = pl->GetItemByPos(PlayerBag, PlayerSlot);

    if (!pItemBank)                                     // Problem to get bank item
        return;

    if (SplitedAmount > pItemBank->GetCount())
        return;                                         // cheating?
    else if (SplitedAmount == pItemBank->GetCount())
        SplitedAmount = 0;                              // no split

    if (SplitedAmount)
    {                                                   // Bank -> Char split to slot (patly move)
        Item *pNewItem = pItemBank->CloneItem(SplitedAmount);
        if (!pNewItem)
        {
            pl->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItemBank, NULL);
            return;
        }

        ItemPosCountVec dest;
        uint8 msg = pl->CanStoreItem(PlayerBag, PlayerSlot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            pl->SendEquipError(msg, pNewItem, NULL);
            delete pNewItem;
            return;
        }

        // check source pos rights (item moved to inventory)
        uint32 remRight = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTab);
        if (remRight <= 0)
        {
            delete pNewItem;
            return;
        }

        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        LogBankEvent(trans, GUILD_BANK_LOG_WITHDRAW_ITEM, BankTab, pl->GetGUIDLow(), pItemBank->GetEntry(), SplitedAmount);

        pItemBank->SetCount(pItemBank->GetCount()-SplitedAmount);
        pItemBank->FSetState(ITEM_CHANGED);
        pItemBank->SaveToDB(trans);                          // not in inventory and can be save standalone
        pl->MoveItemToInventory(dest, pNewItem, true);
        pl->SaveInventoryAndGoldToDB(trans);

        MemberItemWithdraw(BankTab, pl->GetGUIDLow(), trans);
        CharacterDatabase.CommitTransaction(trans);
    }
    else                                                // Bank -> Char swap with slot (move)
    {
        ItemPosCountVec dest;
        uint8 msg = pl->CanStoreItem(PlayerBag, PlayerSlot, dest, pItemBank, false);
        if (msg == EQUIP_ERR_OK)                        // merge case
        {
            // check source pos rights (item moved to inventory)
            uint32 remRight = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTab);
            if (remRight <= 0)
                return;

            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            LogBankEvent(trans, GUILD_BANK_LOG_WITHDRAW_ITEM, BankTab, pl->GetGUIDLow(), pItemBank->GetEntry(), pItemBank->GetCount());

            RemoveItem(BankTab, BankTabSlot, trans);
            pl->MoveItemToInventory(dest, pItemBank, true);
            pl->SaveInventoryAndGoldToDB(trans);

            MemberItemWithdraw(BankTab, pl->GetGUIDLow(), trans);
            CharacterDatabase.CommitTransaction(trans);
        }
        else                                            // Bank <-> Char swap items
        {
            // check source pos rights (item swapped to bank)
            if (!IsMemberHaveRights(pl->GetGUIDLow(), BankTab, GUILD_BANK_RIGHT_DEPOSIT_ITEM))
                return;

            if (pItemChar)
            {
                if (!pItemChar->CanBeTraded())
                {
                    pl->SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pItemChar, NULL);
                    return;
                }
            }

            ItemPosCountVec iDest;
            msg = pl->CanStoreItem(PlayerBag, PlayerSlot, iDest, pItemBank, true);
            if (msg != EQUIP_ERR_OK)
            {
                pl->SendEquipError(msg, pItemBank, NULL);
                return;
            }

            GuildItemPosCountVec gDest;
            if (pItemChar)
            {
                msg = CanStoreItem(BankTab, BankTabSlot, gDest, pItemChar->GetCount(), pItemChar, true);
                if (msg != EQUIP_ERR_OK)
                {
                    pl->SendEquipError(msg, pItemChar, NULL);
                    return;
                }
            }

            // check source pos rights (item moved to inventory)
            uint32 remRight = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTab);
            if (remRight <= 0)
                return;

            if (pItemChar)
            {
                // logging item move to bank
                if (pl->GetSession()->GetSecurity() > SEC_PLAYER && sWorld.getBoolConfig(CONFIG_GM_LOG_TRADE))
                {
                    sLog.outCommand(pl->GetSession()->GetAccountId(), "GM %s (Account: %u) deposit item: %s (Entry: %d Count: %u) to guild bank (Guild ID: %u)",
                        pl->GetName(), pl->GetSession()->GetAccountId(),
                        pItemChar->GetProto()->Name1, pItemChar->GetEntry(), pItemChar->GetCount(),
                        m_Id);
                }
            }

            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            LogBankEvent(trans, GUILD_BANK_LOG_WITHDRAW_ITEM, BankTab, pl->GetGUIDLow(), pItemBank->GetEntry(), pItemBank->GetCount());
            if (pItemChar)
                LogBankEvent(trans, GUILD_BANK_LOG_DEPOSIT_ITEM, BankTab, pl->GetGUIDLow(), pItemChar->GetEntry(), pItemChar->GetCount());

            RemoveItem(BankTab, BankTabSlot, trans);
            if (pItemChar)
            {
                pl->MoveItemFromInventory(PlayerBag, PlayerSlot, true);
                pItemChar->DeleteFromInventoryDB(trans);
            }

            if (pItemChar)
                StoreItem(BankTab, gDest, pItemChar, trans);
            pl->MoveItemToInventory(iDest, pItemBank, true);
            pl->SaveInventoryAndGoldToDB(trans);

            MemberItemWithdraw(BankTab, pl->GetGUIDLow(), trans);
            CharacterDatabase.CommitTransaction(trans);
        }
    }
    DisplayGuildBankContentUpdate(BankTab,BankTabSlot);
}

void Guild::MoveFromCharToBank(Player * pl, uint8 PlayerBag, uint8 PlayerSlot, uint8 BankTab, uint8 BankTabSlot, uint32 SplitedAmount)
{
    Item *pItemBank = GetItem(BankTab, BankTabSlot);
    Item *pItemChar = pl->GetItemByPos(PlayerBag, PlayerSlot);

    if (!pItemChar)                                         // Problem to get item from player
        return;

    if (!pItemChar->CanBeTraded())
    {
        pl->SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pItemChar, NULL);
        return;
    }

    // check source pos rights (item moved to bank)
    if (!IsMemberHaveRights(pl->GetGUIDLow(), BankTab, GUILD_BANK_RIGHT_DEPOSIT_ITEM))
        return;

    if (SplitedAmount > pItemChar->GetCount())
        return;                                             // cheating?
    else if (SplitedAmount == pItemChar->GetCount())
        SplitedAmount = 0;                                  // no split

    if (SplitedAmount)
    {                                                       // Char -> Bank split to empty or non-empty slot (partly move)
        GuildItemPosCountVec dest;
        uint8 msg = CanStoreItem(BankTab, BankTabSlot, dest, SplitedAmount, pItemChar, false);
        if (msg != EQUIP_ERR_OK)
        {
            pl->SendEquipError(msg, pItemChar, NULL);
            return;
        }

        Item *pNewItem = pItemChar->CloneItem(SplitedAmount);
        if (!pNewItem)
        {
            pl->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItemChar, NULL);
            return;
        }

        // logging item move to bank (before items merge
        if (pl->GetSession()->GetSecurity() > SEC_PLAYER && sWorld.getBoolConfig(CONFIG_GM_LOG_TRADE))
        {
            sLog.outCommand(pl->GetSession()->GetAccountId(), "GM %s (Account: %u) deposit item: %s (Entry: %d Count: %u) to guild bank (Guild ID: %u)",
                pl->GetName(), pl->GetSession()->GetAccountId(),
                pItemChar->GetProto()->Name1, pItemChar->GetEntry(), SplitedAmount,m_Id);
        }

        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        LogBankEvent(trans, GUILD_BANK_LOG_DEPOSIT_ITEM, BankTab, pl->GetGUIDLow(), pItemChar->GetEntry(), SplitedAmount);

        pl->ItemRemovedQuestCheck(pItemChar->GetEntry(), SplitedAmount);
        pItemChar->SetCount(pItemChar->GetCount()-SplitedAmount);
        pItemChar->SetState(ITEM_CHANGED, pl);
        pl->SaveInventoryAndGoldToDB(trans);
        StoreItem(BankTab, dest, pNewItem, trans);
        CharacterDatabase.CommitTransaction(trans);

        DisplayGuildBankContentUpdate(BankTab, dest);
    }
    else                                                    // Char -> Bank swap with empty or non-empty (move)
    {
        GuildItemPosCountVec dest;
        uint8 msg = CanStoreItem(BankTab, BankTabSlot, dest, pItemChar->GetCount(), pItemChar, false);
        if (msg == EQUIP_ERR_OK)                            // merge
        {
            // logging item move to bank
            if (pl->GetSession()->GetSecurity() > SEC_PLAYER && sWorld.getBoolConfig(CONFIG_GM_LOG_TRADE))
            {
                sLog.outCommand(pl->GetSession()->GetAccountId(), "GM %s (Account: %u) deposit item: %s (Entry: %d Count: %u) to guild bank (Guild ID: %u)",
                    pl->GetName(), pl->GetSession()->GetAccountId(),
                    pItemChar->GetProto()->Name1, pItemChar->GetEntry(), pItemChar->GetCount(),
                    m_Id);
            }

            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            LogBankEvent(trans, GUILD_BANK_LOG_DEPOSIT_ITEM, BankTab, pl->GetGUIDLow(), pItemChar->GetEntry(), pItemChar->GetCount());

            pl->MoveItemFromInventory(PlayerBag, PlayerSlot, true);
            pItemChar->DeleteFromInventoryDB(trans);

            StoreItem(BankTab, dest, pItemChar, trans);
            pl->SaveInventoryAndGoldToDB(trans);
            CharacterDatabase.CommitTransaction(trans);

            DisplayGuildBankContentUpdate(BankTab, dest);
        }
        else                                                // Char <-> Bank swap items (posible NULL bank item)
        {
            ItemPosCountVec iDest;
            if (pItemBank)
            {
                msg = pl->CanStoreItem(PlayerBag, PlayerSlot, iDest, pItemBank, true);
                if (msg != EQUIP_ERR_OK)
                {
                    pl->SendEquipError(msg, pItemBank, NULL);
                    return;
                }
            }

            GuildItemPosCountVec gDest;
            msg = CanStoreItem(BankTab, BankTabSlot, gDest, pItemChar->GetCount(), pItemChar, true);
            if (msg != EQUIP_ERR_OK)
            {
                pl->SendEquipError(msg, pItemChar, NULL);
                return;
            }

            if (pItemBank)
            {
                // check bank pos rights (item swapped with inventory)
                uint32 remRight = GetMemberSlotWithdrawRem(pl->GetGUIDLow(), BankTab);
                if (remRight <= 0)
                    return;
            }

            // logging item move to bank
            if (pl->GetSession()->GetSecurity() > SEC_PLAYER && sWorld.getBoolConfig(CONFIG_GM_LOG_TRADE))
            {
                sLog.outCommand(pl->GetSession()->GetAccountId(), "GM %s (Account: %u) deposit item: %s (Entry: %d Count: %u) to guild bank (Guild ID: %u)",
                    pl->GetName(), pl->GetSession()->GetAccountId(),
                    pItemChar->GetProto()->Name1, pItemChar->GetEntry(), pItemChar->GetCount(),
                    m_Id);
            }

            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            if (pItemBank)
                LogBankEvent(trans, GUILD_BANK_LOG_WITHDRAW_ITEM, BankTab, pl->GetGUIDLow(), pItemBank->GetEntry(), pItemBank->GetCount());
            LogBankEvent(trans, GUILD_BANK_LOG_DEPOSIT_ITEM, BankTab, pl->GetGUIDLow(), pItemChar->GetEntry(), pItemChar->GetCount());

            pl->MoveItemFromInventory(PlayerBag, PlayerSlot, true);
            pItemChar->DeleteFromInventoryDB(trans);
            if (pItemBank)
                RemoveItem(BankTab, BankTabSlot, trans);

            StoreItem(BankTab,gDest,pItemChar, trans);
            if (pItemBank)
                pl->MoveItemToInventory(iDest, pItemBank, true);
            pl->SaveInventoryAndGoldToDB(trans);
            if (pItemBank)
                MemberItemWithdraw(BankTab, pl->GetGUIDLow(), trans);
            CharacterDatabase.CommitTransaction(trans);

            DisplayGuildBankContentUpdate(BankTab, gDest);
        }
    }
}

void Guild::BroadcastEvent(GuildEvents event, uint64 guid, uint8 strCount, std::string str1, std::string str2, std::string str3)
{
    WorldPacket data(SMSG_GUILD_EVENT, 1+1+(guid ? 8 : 0));
    data << uint8(event);
    data << uint8(strCount);

    switch(strCount)
    {
        case 0:
            break;
        case 1:
            data << str1;
            break;
        case 2:
            data << str1 << str2;
            break;
        case 3:
            data << str1 << str2 << str3;
            break;
        default:
            sLog.outError("Guild::BroadcastEvent: incorrect strings count %u!", strCount);
            break;
    }

    if (guid)
        data << uint64(guid);

    BroadcastPacket(&data);

    sLog.outDebug("WORLD: Sent SMSG_GUILD_EVENT");
}

void Guild::DeleteGuildBankItems(SQLTransaction& trans, bool alsoInDB /*= false*/)
{
    for (size_t i = 0; i < m_TabListMap.size(); ++i)
    {
        for (uint8 j = 0; j < GUILD_BANK_MAX_SLOTS; ++j)
        {
            if (Item*& pItem = m_TabListMap[i]->Slots[j])
            {
                pItem->RemoveFromWorld();

                if (alsoInDB)
                    pItem->DeleteFromDB(trans);

                delete pItem;
                pItem = NULL;
            }
        }
        delete m_TabListMap[i];
        m_TabListMap[i] = NULL;
    }
    m_TabListMap.clear();
}

bool GuildItemPosCount::isContainedIn(GuildItemPosCountVec const &vec) const
{
    for (GuildItemPosCountVec::const_iterator itr = vec.begin(); itr != vec.end(); ++itr)
        if (itr->Slot == this->Slot)
            return true;

    return false;
}
