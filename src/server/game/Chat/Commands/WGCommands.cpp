/*
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

#include "Common.h"
#include "DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "TicketMgr.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "Player.h"
#include "BattlefieldWG.h"
#include "BattlefieldMgr.h"

bool ChatHandler::HandleWintergraspStatusCommand(const char* /*args*/)
{
    BattlefieldWG *BfWG = (BattlefieldWG*)sBattlefieldMgr.GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);

    PSendSysMessage(LANG_BG_WG_STATUS, sObjectMgr.GetTrinityStringForDBCLocale(
        BfWG->GetDefenderTeam() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE),
        secsToTimeString(BfWG->GetTimer(), true).c_str(),
        BfWG->IsWarTime() ? "Yes" : "No");
    return true;
}

bool ChatHandler::HandleWintergraspStartCommand(const char* /*args*/)
{
    BattlefieldWG *BfWG = (BattlefieldWG*)sBattlefieldMgr.GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);

    BfWG->OnBattleStart();
    PSendSysMessage(LANG_BG_WG_BATTLE_FORCE_START);
    return true;
}
