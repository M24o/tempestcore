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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "BattlefieldMgr.h"
#include "Zones/BattlefieldWG.h"
#include "ObjectMgr.h"
#include "Player.h"

BattlefieldMgr::BattlefieldMgr()
{
    m_UpdateTimer = 0;
    //sLog.outDebug("Instantiating BattlefieldMgr");
}

BattlefieldMgr::~BattlefieldMgr()
{
    //sLog.outDebug("Deleting BattlefieldMgr");
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
        delete *itr;
}

void BattlefieldMgr::InitBattlefield()
{

    Battlefield* pBf = new BattlefieldWG;
    // respawn, init variables
    if(!pBf->SetupBattlefield())
    {
        sLog.outDebug("Battlefield : Wintergrasp init failed.");
        delete pBf;
    }
    else
    {
        m_BattlefieldSet.push_back(pBf);
        sLog.outDebug("Battlefield : Wintergrasp successfully initiated.");
    }

    /* For Cataclysm: Tol Barad
    pBf = new BattlefieldTB;
    // respawn, init variables
    if(!pBf->SetupBattlefield())
    {
        sLog.outDebug("Battlefield : Tol Barad init failed.");
        delete pBf;
    }
    else
    {
        m_BattlefieldSet.push_back(pBf);
        sLog.outDebug("Battlefield : Tol Barad successfully initiated.");
    }*/
}

void BattlefieldMgr::AddZone(uint32 zoneid, Battlefield *handle)
{
    m_BattlefieldMap[zoneid] = handle;
}

void BattlefieldMgr::HandlePlayerEnterZone(Player *plr, uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
        return;

    if (itr->second->HasPlayer(plr))
        return;

    itr->second->HandlePlayerEnterZone(plr, zoneid);
    sLog.outDebug("Player %u entered outdoorpvp id %u", plr->GetGUIDLow(), itr->second->GetTypeId());
}

void BattlefieldMgr::HandlePlayerLeaveZone(Player *plr, uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
        return;

    // teleport: remove once in removefromworld, once in updatezone
    if (!itr->second->HasPlayer(plr))
        return;

    itr->second->HandlePlayerLeaveZone(plr, zoneid);
    sLog.outDebug("Player %u left outdoorpvp id %u",plr->GetGUIDLow(), itr->second->GetTypeId());
}

Battlefield * BattlefieldMgr::GetBattlefieldToZoneId(uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
    {
        // no handle for this zone, return
        return NULL;
    }
    return itr->second;
}
Battlefield * BattlefieldMgr::GetBattlefieldByBattleId(uint32 battleid)
{
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
    {
        if((*itr)->GetBattleId()==battleid)
            return (*itr);
    }
    return NULL;
}

void BattlefieldMgr::Update(uint32 diff)
{
    m_UpdateTimer += diff;
    if (m_UpdateTimer > BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
            (*itr)->Update(m_UpdateTimer);
        m_UpdateTimer = 0;
    }
}

ZoneScript * BattlefieldMgr::GetZoneScript(uint32 zoneId)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneId);
    if (itr != m_BattlefieldMap.end())
        return itr->second;
    else
        return NULL;
}
