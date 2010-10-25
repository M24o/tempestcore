/*
 * Copyright (C) 2005 - 2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
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

#include "Player.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "BattlegroundIC.h"
#include "Language.h"
#include "WorldPacket.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Vehicle.h"
#include "Transport.h"

BattlegroundIC::BattlegroundIC()
{
    m_BgCreatures.resize(BG_IC_NPC_MAX);
    m_BgObjects.resize(BG_IC_MAX_OBJECT);
    for (int i=0;i<BG_IC_NPC_MAX;i++)
        m_BgCreatures[i]=NULL;
    for (int i=0;i<BG_IC_MAX_OBJECT;i++)
        m_BgObjects[i]=NULL;

    //Setting the start message 2 minute 1 minute 30 sec and start (missing the 15 sec)
    m_StartMessageIds[BG_STARTING_EVENT_FIRST]  = 12011;
    m_StartMessageIds[BG_STARTING_EVENT_SECOND] = 12012;
    m_StartMessageIds[BG_STARTING_EVENT_THIRD]  = 12013;
    m_StartMessageIds[BG_STARTING_EVENT_FOURTH] = 12014;

    m_OpenDoors=false;
    m_ActivMODoors=false;

    // Gunship transpot object
    m_GunshipA=NULL;
    m_GunshipH=NULL;

    //Initialization of team score
    m_Team_Scores[TEAM_ALLIANCE] = 300;
    m_Team_Scores[TEAM_HORDE]     = 300;
}

BattlegroundIC::~BattlegroundIC()
{
}

//Update method, call in BattlegroundMgr
void BattlegroundIC::Update(uint32 diff)
{
    Battleground::Update(diff);

    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        if(m_OpenDoors)
		{
            if(m_uiOpenDoorTimer<=diff)
            {
                for (int i = 0 ; i < BG_IC_MAXDOOR; ++i)
                    if(GetBGObject(m_IC_DoorData[i].object_door)) GetBGObject(m_IC_DoorData[i].object_door)->SetGoState(GO_STATE_READY); //We open door
                m_OpenDoors=false;
                m_ActivMODoors=true;
                m_uiActivMODoorsTimer=6000;
            }
			else m_uiOpenDoorTimer -= diff;
        }

        if(m_ActivMODoors)
		{
            if(m_uiActivMODoorsTimer<=diff)
            {
                for (int i = 0 ; i < BG_IC_MAXDOOR; ++i){
                    if(GetBGObject(m_IC_DoorData[i].object_door)) DelObject(m_IC_DoorData[i].object_door);
                    if(GetBGObject(m_IC_DoorData[i].object_build))
                    {
                        GameObject* go=GetBGObject(m_IC_DoorData[i].object_build);
                        go->SetGoState(GO_STATE_READY);
                        go->SetUInt32Value(GAMEOBJECT_DISPLAYID, go->GetGOInfo()->building.damagedDisplayId);
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);
                    }
                }
                m_ActivMODoors=false;
            }
			else m_uiActivMODoorsTimer -= diff;
        }

        for (uint8 i = 0; i < BG_IC_DYNAMIC_NODES_COUNT; i++)
		{
            if (m_IC_NodeData[i].current == STATE_BANNER_CONT_A || m_IC_NodeData[i].current ==STATE_BANNER_CONT_H)
            {
                if(m_IC_NodeData[i].timeleft<=diff)
                {
                    switch(m_IC_NodeData[i].current)
                    {
                        case STATE_BANNER_CONT_A:
                            SendMessage2ToAll(LANG_BG_IC_NODE_TAKEN,CHAT_MSG_BG_SYSTEM_ALLIANCE, NULL, LANG_BG_AB_ALLY, _GetNodeNameId(i));
                            m_IC_NodeData[i].previous=m_IC_NodeData[i].current;
                            m_IC_NodeData[i].current=STATE_BANNER_ALLY;
                            _DelBanner(i,0,0);
                            _CreateBanner(i,0,0,true);
                            _NodeOccupied(i,ALLIANCE);
                            _SendNodeUpdate(i);
                            break;
                        case STATE_BANNER_CONT_H:
                            SendMessage2ToAll(LANG_BG_IC_NODE_TAKEN,CHAT_MSG_BG_SYSTEM_HORDE, NULL, LANG_BG_AB_HORDE, _GetNodeNameId(i));
                            m_IC_NodeData[i].previous=m_IC_NodeData[i].current;
                            m_IC_NodeData[i].current=STATE_BANNER_HORDE;
                            _DelBanner(i,0,0);
                            _CreateBanner(i,0,0,true);
                            _NodeOccupied(i,HORDE);
                            _SendNodeUpdate(i);
                            break;
                    }
                }
                else m_IC_NodeData[i].timeleft-= diff;
             }
		}
    }
}

void BattlegroundIC::StartingEventCloseDoors()
{
}

void BattlegroundIC::StartingEventOpenDoors()
{
    for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
    {
        uint8 id=BG_IC_OBJ[i].id;
        switch(BG_IC_OBJ[i].type)
        {
        case IC_TYPE_BOMB:
            if(GetBGObject(id)) GetBGObject(id)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE); //Usable bomb
            break;
        case IC_TYPE_TOWER_DOOR:
            if(GetBGObject(id)) GetBGObject(id)->SetGoState(GO_STATE_ACTIVE); 
            break;
        case IC_TYPE_DOOR_A:
        case IC_TYPE_DOOR_H:
            if(GetBGObject(id+1)) GetBGObject(id+1)->SetGoState(GO_STATE_ACTIVE); //We open door
            break;
        case IC_TYPE_TELEPORT_H:
        case IC_TYPE_TELEPORT_A:
            if(GetBGObject(id)) GetBGObject(id)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE); //Teleporter usable
            if(GetBGObject(id+1)) GetBGObject(id+1)->SetGoState(GO_STATE_ACTIVE);    //Aura active
            break;
        }
    }
    m_OpenDoors=true;
    m_uiOpenDoorTimer=BG_IC_TIMER_OPEN_DOOR;
}

void BattlegroundIC::AddPlayer(Player *plr)
{
    Battleground::AddPlayer(plr);
    //create score and add it to map, default values are set in constructor
    BattlegroundICScore* sc = new BattlegroundICScore;

    if(sc)
	{
		sc->BasesAssaulted=0;
		sc->BasesDefended=0;
		sc->BonusHonor=0;
		sc->DamageDone=0;
		sc->HealingDone=0;
		sc->HonorableKills=0;
		sc->KillingBlows=0;
		m_PlayerScores[plr->GetGUID()] = sc;
    }
    SendTransportInit(plr);
}

void BattlegroundIC::SendTransportInit(Player *player)
{
    if(!m_GunshipA)
        return;
		
    if(!m_GunshipH)
        return;

    UpdateData transData;
    m_GunshipA->BuildCreateUpdateBlockForPlayer(&transData, player);
    m_GunshipH->BuildCreateUpdateBlockForPlayer(&transData, player);
    WorldPacket packet;
    transData.BuildPacket(&packet);
    player->GetSession()->SendPacket(&packet);
}

void BattlegroundIC::RemovePlayer(Player* plr,uint64 /*guid*/)
{
    plr->RemoveAura(OIL_REFINERY);
    plr->RemoveAura(QUARRY);
}

void BattlegroundIC::UpdatePlayerScore(Player* Source, uint32 type, uint32 value, bool doAddHonor)
{
    std::map<uint64, BattlegroundScore*>::iterator itr = m_PlayerScores.find(Source->GetGUID());
 
    if (itr == m_PlayerScores.end())                         // player not found...
        return;
 
    switch(type)
    {
        case SCORE_BASES_ASSAULTED:
            ((BattlegroundICScore*)itr->second)->BasesAssaulted += value;
            break;
        case SCORE_BASES_DEFENDED:
            ((BattlegroundICScore*)itr->second)->BasesDefended += value;
            break;
        default:
            Battleground::UpdatePlayerScore(Source,type,value, doAddHonor);
            break;
    }
}

void BattlegroundIC::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(BG_IC_ALLIANCE_RENFORT_SET) << uint32(1);
    data << uint32(BG_IC_HORDE_RENFORT_SET) << uint32(1);
    data << uint32(BG_IC_ALLIANCE_RENFORT) << uint32(m_Team_Scores[0]);
    data << uint32(BG_IC_HORDE_RENFORT) << uint32(m_Team_Scores[1]);
    for (uint8 i = 0 ; i < BG_IC_MAXDOOR; ++i)
    {
        if(m_IC_DoorData[i].state == BG_IC_GATE_DESTROYED)
            data<<uint32(m_IC_DoorData[i].worldstate[0])<< uint32(1);
        else
            data<<uint32(m_IC_DoorData[i].worldstate[1])<< uint32(1);
    }
    for (uint8 i = 0 ; i < BG_IC_DYNAMIC_NODES_COUNT ; i++)
        data << uint32(m_IC_NodeData[i].worldstate[m_IC_NodeData[i].current]) << uint32(1);
}

bool BattlegroundIC::SetupBattleground()
{
    // Spawn all GameObjects
    for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
    {
    	//Coordinate of GameObject
        float x,y,z,o;
        x=BG_IC_OBJ[i].x;
        y=BG_IC_OBJ[i].y;
        z=BG_IC_OBJ[i].z;
        o=BG_IC_OBJ[i].o;
        //Id of GameObject (relative to this script)
        uint8 id=BG_IC_OBJ[i].id;

        switch(BG_IC_OBJ[i].type)
        {
			//If object is a flag there is 3 GameObject associate :
			// The flag (clickable)
			// The aura
			// The
			case IC_TYPE_FLAG:
            {
            	//Node id: for identify witch flag is it (for know what happen when clicking on flag)
                uint8 NodeId=BG_IC_OBJ[i].nodeid;
                uint32 BanneAura=0;
                uint32 BannerFlag=0;

                m_IC_NodeData[NodeId].current=BG_IC_OBJ[i].state;
                m_IC_NodeData[NodeId].previous=BG_IC_OBJ[i].state;
                m_IC_NodeData[NodeId].object_aura=id+2;
                m_IC_NodeData[NodeId].object_flag=id+1;
                m_IC_NodeData[NodeId].timeleft=0;

                for(int ws=0 ;ws<5 ;ws++)
                    m_IC_NodeData[NodeId].worldstate[ws]=IC_InitNodeData[NodeId].worldstate[ws];

                for(int gobid=0 ;gobid<5 ;gobid++)
                    m_IC_NodeData[NodeId].gobentry[gobid]=IC_InitNodeData[NodeId].gobentry[gobid];

                uint8 state=BG_IC_OBJ[i].state;
                switch(state)
                {
                    case STATE_NEUTRAL:      BanneAura=BG_IC_OBJECTID_AURA_C;break;
                    case STATE_BANNER_ALLY:  BanneAura=BG_IC_OBJECTID_AURA_A;break;
                    case STATE_BANNER_HORDE: BanneAura=BG_IC_OBJECTID_AURA_H;break;
                    default:
                        sLog.outError("BattlegroundIC::SetupBattleground() Object: %i, bad state: %u",i,BG_IC_OBJ[i].state);
                        return false;
                }
                
                BannerFlag=m_IC_NodeData[NodeId].gobentry[state];

                //Spawn the pillar
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Spaw the aura
                if(!AddObject(id+2,BanneAura,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
					return false;

				//Spawn the Flag
                if(!AddObject(id+1,BannerFlag,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Set flag faction
                GetBGObject(id+1)->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_OBJ[i].faction);

                //if flag is clickable or not on start (like flag in the keep):
                if(BG_IC_OBJ[i].usable)
                    GetBGObject(id+1)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                else
                	GetBGObject(id+1)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                break;
            }
            //If door type: there are two GameObject:
            // Destructible object (building)
            // Door witch can be open close (for start)
			case IC_TYPE_DOOR_H:
            {
            	// DoorId, for identify the door for event when destroy etc...
                uint8 DoorId=BG_IC_OBJ[i].nodeid;

                //Spawn destructible part
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Spawn door
                if(!AddObject(id+1,BG_IC_OBJECTID_GATE_H,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Door faction
                GetBGObject(id)->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_OBJ[i].faction);
                GetBGObject(id)->SetGoState(GO_STATE_ACTIVE);//As on retail
                //Door must not be usable
                GetBGObject(id+1)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                //Stock door data for use it in script after
                m_IC_DoorData[DoorId].object_door=id+1;
                m_IC_DoorData[DoorId].object_build=id;
                m_IC_DoorData[DoorId].state=IC_InitDoorData[DoorId].state;

                //Worldstate
                for(int ws=0 ;ws<2 ;ws++)
                    m_IC_DoorData[DoorId].worldstate[ws]=IC_InitDoorData[DoorId].worldstate[ws];

                break;
            }
            //If door type: there are two GameObject:
			// Destructible object (building)
			// Door witch can be open close (for start)
			case IC_TYPE_DOOR_A:
            {
            	// DoorId, for identify the door for event when destroy etc...
                uint8 DoorId=BG_IC_OBJ[i].nodeid;

                //Spawn destructible part
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Spawn door
                if(!AddObject(id+1,BG_IC_OBJECTID_GATE_A,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //DoorFaction
                GetBGObject(id)->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_OBJ[i].faction);
                GetBGObject(id)->SetGoState(GO_STATE_ACTIVE);//As on retail

                //Door must not be usable
                GetBGObject(id+1)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                //Stock door data for use it in script after
                m_IC_DoorData[DoorId].object_door=id+1;
                m_IC_DoorData[DoorId].object_build=id;
                m_IC_DoorData[DoorId].state=IC_InitDoorData[DoorId].state;

                //Worldstate
                for(int ws=0 ;ws<2 ;ws++)
                    m_IC_DoorData[DoorId].worldstate[ws]=IC_InitDoorData[DoorId].worldstate[ws];

                break;
            }
            //If object is teleporter: There are two GameObject
            // The teleporter
            // The aura
			case IC_TYPE_TELEPORT_H:
            {
                // Spawn teleporter
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                // Spawn Aura
                if(!AddObject(id+1,BG_IC_OBJECTID_AURA_TELEPORTER_H,x,y,z+0.2f,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Disable teleporter, must be active on battle start.
                GetBGObject(id)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                GetBGObject(id+1)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                GetBGObject(id)->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_OBJ[i].faction);

                break;
            }
            //If object is teleporter: There are two GameObject
            // The teleporter
            // The aura
			case IC_TYPE_TELEPORT_A:
            {
            	// Spawn teleporter
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                // Spawn Aura
                if(!AddObject(id+1,BG_IC_OBJECTID_AURA_TELEPORTER_A,x,y,z+0.000676f,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Disable teleporter, must be active on battle start.
                GetBGObject(id)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                GetBGObject(id+1)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                GetBGObject(id)->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_OBJ[i].faction);

                break;
            }
			// if type is bomb: only one GameObject
			case IC_TYPE_BOMB:
            {
                //Spawn object
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Disable bomb, active on start
                GetBGObject(id)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                //TODO: 10 sec respawn time ?

                break;
            }
            //Decoration like bonfire
			case IC_TYPE_DECORATION:
            {
                //Spawn GameObject
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                break;
            }
            //The door associate to keep
			case IC_TYPE_LAST_DOOR_H:	//Open when one of three door of Horde keep is destroy
			case IC_TYPE_LAST_DOOR_A:	//Open when one of three door of Alliance keep is destroy
			case IC_TYPE_TOWER_DOOR:	//Open on battleground start
            {
            	//Spawn GameObject
                if(!AddObject(id,BG_IC_OBJ[i].entry,x,y,z,o,0,0,0,0,RESPAWN_ONE_DAY))
                    return false;

                //Close door
                GetBGObject(id)->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                break;
            }
        }
        if(m_BgObjects[id] && GetBGObject(id))
            GetBGObject(id)->setActive(true);
    }

    //GameObject are create but no spawn, now we must spawn (set visible)
    for (int obj = 0 ; obj < BG_IC_MAX_OBJECT; obj++)
        SpawnBGObject(obj, RESPAWN_IMMEDIATELY);

    //Spawn all spirit guide in each GY
    for(int i=BG_IC_ALLIANCE_KEEP;i<BG_IC_ALL_NODES_COUNT;i++)
        if (!AddSpiritGuide(i, BG_IC_SpiritGuidePos[i][0], BG_IC_SpiritGuidePos[i][1], BG_IC_SpiritGuidePos[i][2], BG_IC_SpiritGuidePos[i][3], BG_IC_graveInitTeam[i]))
        {
            sLog.outError("Failed to spawn spirit guide! point: %u, team: %u,", i, BG_IC_graveInitTeam[i]);
            return false;    
        }
    
    //Npc spawning
    for (int i = 0 ; i < MAX_BG_IC_NPC; ++i)
    {
        float x,y,z,o;
        x=BG_IC_NPC[i].x;
        y=BG_IC_NPC[i].y;
        z=BG_IC_NPC[i].z;
        o=BG_IC_NPC[i].o;
        uint8 id=BG_IC_NPC[i].id;
        switch(BG_IC_NPC[i].type)
        {
        case IC_TYPE_NONE:
        case IC_TYPE_KEEP_GUN:
            if(!AddCreature(BG_IC_NPC[i].entry,id,BG_IC_NPC[i].faction,x,y,z,o,BG_IC_NPC[i].respawn))
                return false;
            GetBGCreature(id)->setFaction(BG_IC_NPC[i].faction==FACTION_ALLIANCE?FACTION_NPC_ALLIANCE:FACTION_NPC_HORDE);
            break;
        }
    }

    //Spawning Gunship... in general system, there are spawn on server start and not on map loading... so for have
    // one transport for each battleground it's difficult without manual spawn
    m_GunshipA = MakeTransport(195121,120000,"IC - horde gunship");
    m_GunshipH = MakeTransport(195276,120000,"IC - alliance gunship");

    //Send transport init packet to all player in map
    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end();itr++)
        {
            if (Player* p = sObjectMgr.GetPlayer(itr->first))
            {
                SendTransportInit(p);
            }
        }
    return true;
}

//Called when a player kill a Creature, used for know if one of two boss is killed
void BattlegroundIC::HandleKillUnit(Creature *pUnit, Player * /*killer*/)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
       return;

    uint32 entry = pUnit->GetEntry();
    if (entry == BG_IC_NPCID_HIGH_COMMANDER_HALFORD_WYRMBANE)
    {
        RewardHonorToTeam(500,HORDE);
        EndBattleground(HORDE);
    }
    else if (entry == BG_IC_NPCID_OVERLORD_AGMAR)
    {
        RewardHonorToTeam(500,ALLIANCE);
        EndBattleground(ALLIANCE);
    }
}

void BattlegroundIC::EndBattleground(uint32 winner)
{
    Battleground::EndBattleground(winner);
}

//This method is used for spawn all npc of the same type, like vehicle in node.
void BattlegroundIC::SpawnNpcType(uint32 type)
{
    for (int i = 0 ; i < MAX_BG_IC_NPC; ++i)
    {
        float x,y,z,o;
        x=BG_IC_NPC[i].x;
        y=BG_IC_NPC[i].y;
        z=BG_IC_NPC[i].z;
        o=BG_IC_NPC[i].o;
        uint8 id=BG_IC_NPC[i].id;
        if(type==BG_IC_NPC[i].type)
        {
            if(GetBGCreature(id)){
                GetBGCreature(id)->SetVisibility(VISIBILITY_ON);
                GetBGCreature(id)->SetRespawnTime(30);
                GetBGCreature(id)->Respawn(true);
            }
            else{
                if(!AddCreature(BG_IC_NPC[i].entry,id,BG_IC_NPC[i].faction,x,y,z,o,BG_IC_NPC[i].respawn))
                    return;
                GetBGCreature(id)->setFaction(BG_IC_NPC[i].faction==FACTION_ALLIANCE?FACTION_NPC_ALLIANCE:FACTION_NPC_HORDE);
            }
        }
    }
}

void BattlegroundIC::DeSpawnNpcType(uint32 type)
{
    for (int i = 0 ; i < MAX_BG_IC_NPC; ++i)
    {
        uint8 id=BG_IC_NPC[i].id;
        if(type==BG_IC_NPC[i].type)
        {
            if(m_BgCreatures[id] && GetBGCreature(id)){
                GetBGCreature(id)->SetRespawnTime(RESPAWN_ONE_DAY);
                if(GetBGCreature(id)->GetVehicleKit())
                {
                    if(!GetBGCreature(id)->GetVehicleKit()->IsVehicleInUse())
                    {
                        GetBGCreature(id)->SetVisibility(VISIBILITY_OFF);
                        GetBGCreature(id)->DisappearAndDie();
                    }
                }
                else
                {
                    GetBGCreature(id)->SetVisibility(VISIBILITY_OFF);
                    GetBGCreature(id)->DisappearAndDie();
                }
            }
        }
    }
}

Transport* BattlegroundIC::MakeTransport(uint32 gobentry,uint32 period,std::string nametransport)
{
    Transport *t = new Transport(period,0);

        uint32 entry = gobentry;
        std::string name = nametransport;

        const GameObjectInfo *goinfo = sObjectMgr.GetGameObjectInfo(entry);

        if (!goinfo)
        {
            sLog.outErrorDb("Transport ID:%u, Name: %s, will not be loaded, gameobject_template missing", entry, name.c_str());
            delete t;
            return NULL;
        }
        std::set<uint32> mapsUsed;

        if (!t->GenerateWaypoints(goinfo->moTransport.taxiPathId, mapsUsed))
            // skip transports with empty waypoints list
        {
            sLog.outErrorDb("Transport (path id %u) path size = 0. Transport ignored, check DBC files or transport GO data0 field.",goinfo->moTransport.taxiPathId);
            delete t;
            return NULL;
        }

        float x, y, z, o;
        uint32 mapid;
        x = t->m_WayPoints[0].x; y = t->m_WayPoints[0].y; z = t->m_WayPoints[0].z; mapid = t->m_WayPoints[0].mapid; o = 1;

         // creates the Gameobject
        if (!t->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT),entry, mapid, x, y, z, o, 100, 0))
        {
            delete t;
            return NULL;
        }

        //If we someday decide to use the grid to track transports, here:
        t->SetMap(GetBgMap());

        // On spawn les npc li? au transport
        QueryResult npc_transport = WorldDatabase.PQuery("SELECT guid, npc_entry, transport_entry, TransOffsetX, TransOffsetY, TransOffsetZ, TransOffsetO, emote FROM creature_transport");
        if(npc_transport)
        {
            do
            {
                Field *fields = npc_transport->Fetch();
                t->AddNPCPassenger(fields[0].GetUInt32(), fields[1].GetFloat(), fields[2].GetFloat(), fields[3].GetFloat(), fields[4].GetFloat(),fields[5].GetUInt32(),fields[6].GetUInt32());
            } while( npc_transport->NextRow() );
        }
		
        return t;
}

void BattlegroundIC::_NodeOccupied(uint8 node,Team team)
{
    if (node >= BG_IC_DYNAMIC_NODES_COUNT)
        return;

    if(m_IC_NodeData[node].current==STATE_BANNER_ALLY)
        team=ALLIANCE;
    else if(m_IC_NodeData[node].current==STATE_BANNER_HORDE)
        team=HORDE;
    else //Changing to neutral
    {
        _NodeDeOccupied(node);
        return;
    }

    if(node != BG_IC_NODE_QUARRY && node != BG_IC_NODE_REFINERY)
        if (!AddSpiritGuide(node, BG_IC_SpiritGuidePos[node][0], BG_IC_SpiritGuidePos[node][1], BG_IC_SpiritGuidePos[node][2], BG_IC_SpiritGuidePos[node][3], team))
            sLog.outError("Failed to spawn spirit guide! point: %u, team: %u,", node, team);

    if (node == BG_IC_NODE_QUARRY)
    {
        uint32 otherTeam = GetOtherTeam(team);
        for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        {
            if (itr->second.OfflineRemoveTime)
                continue;
            Player *plr = sObjectMgr.GetPlayer(itr->first);

            if (!plr)
            {
                sLog.outError("Battleground:CastSpellOnTeam: Player (GUID: %u) not found!", GUID_LOPART(itr->first));
                continue;
            }

            uint32 teamID = itr->second.Team;
            if (!teamID)
                teamID = plr->GetTeam();

            if (teamID == otherTeam)
                plr->RemoveAura(QUARRY);
        }
        CastSpellOnTeam(QUARRY, team);
    }
    if (node == BG_IC_NODE_REFINERY)
    {
        uint32 otherTeam = GetOtherTeam(team);
        for (BattlegroundPlayerMap::const_iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        {
            if (itr->second.OfflineRemoveTime)
                continue;
            Player *plr = sObjectMgr.GetPlayer(itr->first);

            if (!plr)
            {
                sLog.outError("Battleground:CastSpellOnTeam: Player (GUID: %u) not found!", GUID_LOPART(itr->first));
                continue;
            }

            uint32 teamID = itr->second.Team;
            if (!teamID)
                teamID = plr->GetTeam();

            if (teamID == otherTeam)
                plr->RemoveAura(OIL_REFINERY);
        }
        CastSpellOnTeam(OIL_REFINERY, team);
    }

    switch(node)
    {
    case BG_IC_NODE_WORKSHOP:
        //Pop de 4 v?hicule (d?molisseur) devant
        //Pop d'un engin de siege mais en r?paration (event 1 minute plus ou moins)
        if(m_IC_NodeData[node].current==STATE_BANNER_ALLY)
        {
            SpawnNpcType(IC_TYPE_DEMOLISSER_A);
            SpawnNpcType(IC_TYPE_SIEGE_A);
        }
        else
        {
            SpawnNpcType(IC_TYPE_DEMOLISSER_H);
            SpawnNpcType(IC_TYPE_SIEGE_H);
        }
        break ;
    case BG_IC_NODE_DOCK:
        //Spawn associate vehicle
        if(m_IC_NodeData[node].current==STATE_BANNER_ALLY)
            SpawnNpcType(IC_TYPE_DOCKVEHICLE_A);
        else
            SpawnNpcType(IC_TYPE_DOCKVEHICLE_H);
        break ;
    case BG_IC_NODE_HANGAR:
    	//Activate transport
        if (m_GunshipA)
            m_GunshipA->BuildStartMovePacket(GetBgMap());
        if (m_GunshipH)    
            m_GunshipH->BuildStartMovePacket(GetBgMap());

        for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
        {
            if(BG_IC_OBJ[i].type == IC_TYPE_GUNSHIPTELEPORTER)
            {
                float x,y,z,o;
                x=BG_IC_OBJ[i].x;
                y=BG_IC_OBJ[i].y;
                z=BG_IC_OBJ[i].z;
                o=BG_IC_OBJ[i].o;
                uint8 id=BG_IC_OBJ[i].id;
                //TODO: AURA Des teleporteur
                if(!AddObject(id,team==ALLIANCE?BG_IC_ALLIANCE_GUNSHIP_PORTAL:BG_IC_HORDE_GUNSHIP_PORTAL,x,y,z,o,0,0,0,RESPAWN_ONE_DAY))
                    return;
                GetBGObject(id)->SetUInt32Value(GAMEOBJECT_FACTION, team==ALLIANCE?FACTION_GOB_ALLIANCE:FACTION_GOB_HORDE);
                SpawnBGObject(id, RESPAWN_IMMEDIATELY);
            }
        }        
        break ;
    }
}

void BattlegroundIC::_NodeDeOccupied(uint8 node)
{
    if(!m_BgCreatures[node] || !GetBGCreature(node))
        return;

    std::vector<uint64> ghost_list = m_ReviveQueue[m_BgCreatures[node]];
    if (!ghost_list.empty())
    {
        WorldSafeLocsEntry const *ClosestGrave = NULL;
        for (std::vector<uint64>::const_iterator itr = ghost_list.begin(); itr != ghost_list.end(); ++itr)
        {
            Player* plr = sObjectMgr.GetPlayer(*itr);
            if (!plr)
                continue;

            if (!ClosestGrave)                              // cache
                ClosestGrave = GetClosestGraveYard(plr);

            if (ClosestGrave)
                plr->TeleportTo(GetMapId(), ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, plr->GetOrientation());
        }
    }
    //Remove spiritguide
    DelCreature(node);

    switch(node)
    {
    case BG_IC_NODE_WORKSHOP:
        DeSpawnNpcType(IC_TYPE_DEMOLISSER_H);
        DeSpawnNpcType(IC_TYPE_SIEGE_H);
        DeSpawnNpcType(IC_TYPE_DEMOLISSER_A);
        DeSpawnNpcType(IC_TYPE_SIEGE_A);
        break ;
    case BG_IC_NODE_DOCK:
        //pop de catapulte et lanceur de glaive
        DeSpawnNpcType(IC_TYPE_DOCKVEHICLE_A);
        DeSpawnNpcType(IC_TYPE_DOCKVEHICLE_H);
        break ;
    case BG_IC_NODE_HANGAR:
        for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
        {
            if(BG_IC_OBJ[i].type == IC_TYPE_GUNSHIPTELEPORTER)
                DelObject(BG_IC_OBJ[i].id);
        }        
        break ;
    }
}

void BattlegroundIC::_SendNodeUpdate(uint8 node)
{
    uint32 cur=m_IC_NodeData[node].current;
    uint32 prev=m_IC_NodeData[node].previous;
    UpdateWorldState(m_IC_NodeData[node].worldstate[prev], 0);
    UpdateWorldState(m_IC_NodeData[node].worldstate[cur], 1);
}

void BattlegroundIC::_DelBanner(uint8 node,uint8 type,uint8 teamIndex)
{
    DelObject(m_IC_NodeData[node].object_flag);
    DelObject(m_IC_NodeData[node].object_aura);
}

void BattlegroundIC::_CreateBanner(uint8 node,uint8 type,uint8 teamind    ,bool delay)
{
    uint32 faction=35;
    uint32 BanneAura=0;
    switch(m_IC_NodeData[node].current)
    {
        case STATE_BANNER_CONT_H:BanneAura=BG_IC_OBJECTID_AURA_C;faction=FACTION_GOB_ALLIANCE;break;
        case STATE_BANNER_CONT_A:BanneAura=BG_IC_OBJECTID_AURA_C;faction=FACTION_GOB_HORDE;break;
        case STATE_NEUTRAL:         BanneAura=BG_IC_OBJECTID_AURA_C;break;
        case STATE_BANNER_ALLY:  BanneAura=BG_IC_OBJECTID_AURA_A;faction=FACTION_GOB_HORDE;break;
        case STATE_BANNER_HORDE: BanneAura=BG_IC_OBJECTID_AURA_H;faction=FACTION_GOB_ALLIANCE;break;
    }
    AddObject(m_IC_NodeData[node].object_flag,m_IC_NodeData[node].gobentry[m_IC_NodeData[node].current],
        BG_IC_OBJ[node].x,BG_IC_OBJ[node].y,BG_IC_OBJ[node].z,BG_IC_OBJ[node].o,
        0,0,0,0,RESPAWN_ONE_DAY);
    AddObject(m_IC_NodeData[node].object_aura,BanneAura,
        BG_IC_OBJ[node].x,BG_IC_OBJ[node].y,BG_IC_OBJ[node].z,BG_IC_OBJ[node].o,
        0,0,0,0,RESPAWN_ONE_DAY);
    if(GetBGObject(m_IC_NodeData[node].object_flag))
        GetBGObject(m_IC_NodeData[node].object_flag)->SetUInt32Value(GAMEOBJECT_FACTION, faction);
    SpawnBGObject(m_IC_NodeData[node].object_flag, RESPAWN_IMMEDIATELY);
    SpawnBGObject(m_IC_NodeData[node].object_aura, RESPAWN_IMMEDIATELY);
}

/* Invoked if a player used a banner as a gameobject */
void BattlegroundIC::EventPlayerClickedOnFlag(Player *source, GameObject* target_obj)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
    if(!target_obj)
        return;
    int selectednode=-1;
    uint32 gobid=target_obj->GetEntry();
    uint32 teamIndex=source->GetTeamId();
    for(int node=0;node<BG_IC_DYNAMIC_NODES_COUNT;node++)
        if(m_IC_NodeData[node].gobentry[m_IC_NodeData[node].current]==gobid){
            selectednode=node;
            break;
       }
    if(selectednode<0)
        return;
    
    uint8 currentstate=m_IC_NodeData[selectednode].current;
    uint8 previousstate=m_IC_NodeData[selectednode].previous;
    if(currentstate==previousstate)
    {
        m_IC_NodeData[selectednode].current=(source->GetTeamId()==TEAM_ALLIANCE?STATE_BANNER_CONT_A:STATE_BANNER_CONT_H);
    }else if(currentstate==STATE_BANNER_CONT_A || currentstate==STATE_BANNER_CONT_H)
    {
        m_IC_NodeData[selectednode].previous=currentstate;
        if(previousstate==STATE_BANNER_CONT_A || previousstate==STATE_BANNER_CONT_H || previousstate==STATE_NEUTRAL)
            m_IC_NodeData[selectednode].current=(source->GetTeamId()==TEAM_ALLIANCE?STATE_BANNER_CONT_A:STATE_BANNER_CONT_H);
        else 
            m_IC_NodeData[selectednode].current=previousstate;
    }
	else
    {
        m_IC_NodeData[selectednode].previous=currentstate;
        m_IC_NodeData[selectednode].current=(source->GetTeamId()==TEAM_ALLIANCE?STATE_BANNER_CONT_A:STATE_BANNER_CONT_H);
    }
    m_IC_NodeData[selectednode].timeleft=BG_IC_FLAG_CAPTURING_TIME;
    uint32 sound = 0;
    if(currentstate >= STATE_BANNER_ALLY){
        UpdatePlayerScore(source, SCORE_BASES_ASSAULTED, 1);
        if (teamIndex == BG_TEAM_ALLIANCE)
            SendMessage2ToAll(LANG_BG_IC_NODE_DEFENDED,CHAT_MSG_BG_SYSTEM_ALLIANCE, source, _GetNodeNameId(selectednode));
        else
            SendMessage2ToAll(LANG_BG_IC_NODE_DEFENDED,CHAT_MSG_BG_SYSTEM_HORDE, source, _GetNodeNameId(selectednode));

    }
    else
	{
        
        if(previousstate==STATE_NEUTRAL){
            UpdatePlayerScore(source, SCORE_BASES_ASSAULTED, 1);
            sound = BG_IC_SOUND_NODE_CLAIMED;
            if (teamIndex == 0)
                SendMessage2ToAll(LANG_BG_IC_NODE_CLAIMED,CHAT_MSG_BG_SYSTEM_ALLIANCE, source, _GetNodeNameId(selectednode), LANG_BG_AB_ALLY);
            else
                SendMessage2ToAll(LANG_BG_IC_NODE_CLAIMED,CHAT_MSG_BG_SYSTEM_HORDE, source, _GetNodeNameId(selectednode), LANG_BG_AB_HORDE);
        }
        else
        {
            UpdatePlayerScore(source, SCORE_BASES_DEFENDED, 1);
            if (teamIndex == BG_TEAM_ALLIANCE)
                SendMessage2ToAll(LANG_BG_IC_NODE_ASSAULTED,CHAT_MSG_BG_SYSTEM_ALLIANCE, source, _GetNodeNameId(selectednode));
            else
                SendMessage2ToAll(LANG_BG_IC_NODE_ASSAULTED,CHAT_MSG_BG_SYSTEM_HORDE, source, _GetNodeNameId(selectednode));
        }
    }
    _DelBanner(selectednode,0,0);
    _CreateBanner(selectednode,0,0,true);
    _NodeOccupied(selectednode,(teamIndex == TEAM_ALLIANCE) ?ALLIANCE:HORDE);
    _SendNodeUpdate(selectednode);
    
    PlaySoundToAll(sound);
}

void BattlegroundIC::EventPlayerCapturedFlag(Player* plr)
{
    plr->AddAura(66656,plr);
    plr->AddAura(12438,plr);
    
    if(plr->GetTeamId()==TEAM_ALLIANCE)
    {
        if(m_GunshipA){
        plr->SetTransport(m_GunshipA);
        plr->m_movementInfo.t_pos.m_positionX=7.305609f;
        plr->m_movementInfo.t_pos.m_positionY=-0.095246f;
        plr->m_movementInfo.t_pos.m_positionZ=34.51022;
        plr->m_movementInfo.t_guid=m_GunshipA->GetGUID();
        plr->TeleportTo(GetMapId(),661,-1244,288,0,TELE_TO_NOT_LEAVE_TRANSPORT);
        }       
    }
    else
    {
        if(m_GunshipH)
        {
        plr->SetTransport(m_GunshipH);
        plr->m_movementInfo.t_pos.m_positionX=7.305609f;
        plr->m_movementInfo.t_pos.m_positionY=-0.095246f;
        plr->m_movementInfo.t_pos.m_positionZ=34.51022;
        plr->m_movementInfo.t_guid=m_GunshipH->GetGUID();
        plr->TeleportTo(GetMapId(),661,-1244,288,0,TELE_TO_NOT_LEAVE_TRANSPORT);
        }
    }
}

void BattlegroundIC::Reset()
{
    //call parent's class reset
    Battleground::Reset();

    m_TeamScores[BG_TEAM_ALLIANCE]          = 0;
    m_TeamScores[BG_TEAM_HORDE]             = 0;
    bool isBGWeekend = sBattlegroundMgr.IsBGWeekend(GetTypeID());
}

WorldSafeLocsEntry const* BattlegroundIC::GetClosestGraveYard(Player* player)
{
    uint8 teamIndex = player->GetTeamId();

    // Is there any occupied node for this team?
    std::vector<uint8> nodes;
    for (uint8 i = 0; i < BG_IC_DYNAMIC_NODES_COUNT; i++)
        if (m_IC_NodeData[i].current == teamIndex + 3) //Alliance : teamIndex=0 et STATE_BANNER_ALLY=3 Horde:teamIndex=1 et STATE_BANNER_HORDE=4
            nodes.push_back(i);

    WorldSafeLocsEntry const* good_entry = NULL;
    // If so, select the closest node to place ghost on
    if (!nodes.empty())
    {
        float plr_x = player->GetPositionX();
        float plr_y = player->GetPositionY();

        float mindist = 999999.0f;
        for (uint8 i = 0; i < nodes.size(); ++i)
        {
            if(i == BG_IC_NODE_QUARRY || i == BG_IC_NODE_REFINERY)
                continue;
            WorldSafeLocsEntry const*entry = sWorldSafeLocsStore.LookupEntry(BG_IC_GraveyardIds[nodes[i]]);
            if (!entry)
                continue;
            float dist = (entry->x - plr_x)*(entry->x - plr_x)+(entry->y - plr_y)*(entry->y - plr_y);
            if (mindist > dist)
            {
                mindist = dist;
                good_entry = entry;
            }
        }
        nodes.clear();
    }
    // If not, place ghost on starting location
    if (!good_entry)
        good_entry = sWorldSafeLocsStore.LookupEntry(BG_IC_GraveyardIds[teamIndex+BG_IC_DYNAMIC_NODES_COUNT]);
    //BG_IC_DYNAMIC_NODES_COUNT=7 Alliance : teamIndex=0 et BG_IC_LAST_RESORT_GV_ALLIANCE=7 Horde:teamIndex=1 et BG_IC_LAST_RESORT_GV_HORDE=8

    return good_entry; 
}

uint32 BattlegroundIC::GetGateIDFromDestroyEventID(uint32 id)
{
    uint32 i = 0;
    switch(id)
    {
    case 22079:i=BG_IC_H_FRONT ;break;
    case 22083:i=BG_IC_H_WEST ;break;
    case 22081:i=BG_IC_H_EAST ;break;
    case 22078:i=BG_IC_A_FRONT ;break;
    case 22082:i=BG_IC_A_WEST ;break;
    case 22080:i=BG_IC_A_EAST ;break;
    }
    return i;
}

void BattlegroundIC::DestroyGate(Player* pl, GameObject* /*go*/, uint32 destroyedEvent)
{
    uint16 gateID=GetGateIDFromDestroyEventID(destroyedEvent);

    if(m_IC_DoorData[gateID].state==BG_IC_GATE_DESTROYED)
        return;

    uint16 ObjectId=m_IC_DoorData[gateID].object_build;
    if (!GetBGObject(ObjectId))
        return;

    if (GetBGObject(ObjectId)->GetGOValue()->building.health == 0)
    {
        UpdateWorldState(m_IC_DoorData[gateID].worldstate[0], 0);
        UpdateWorldState(m_IC_DoorData[gateID].worldstate[1], 1);
        switch(gateID)
        {
        case BG_IC_H_FRONT:
        case BG_IC_H_WEST:
        case BG_IC_H_EAST:
            {
                for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
                {
                    uint8 id=BG_IC_OBJ[i].id;
                    switch(BG_IC_OBJ[i].type)
                    {
                    case IC_TYPE_LAST_DOOR_H:
                        if(GetBGObject(id)) GetBGObject(id)->SetGoState(GO_STATE_ACTIVE);         
                    }
                }
                if (GetBGObject(m_IC_NodeData[BG_IC_ALLIANCE_KEEP].object_flag))
                    GetBGObject(m_IC_NodeData[BG_IC_ALLIANCE_KEEP].object_flag)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

            }
            break;
        case BG_IC_A_FRONT:
        case BG_IC_A_WEST:
        case BG_IC_A_EAST:
            {
                for (int i = 0 ; i < MAX_BG_IC_OBJ; ++i)
                {
                    uint8 id=BG_IC_OBJ[i].id;
                    switch(BG_IC_OBJ[i].type)
                    {
                    case IC_TYPE_LAST_DOOR_A:
                        if(GetBGObject(id)) GetBGObject(id)->SetGoState(GO_STATE_ACTIVE);         
                    }
                }
                if (GetBGObject(m_IC_NodeData[BG_IC_HORDE_KEEP].object_flag))
                    GetBGObject(m_IC_NodeData[BG_IC_HORDE_KEEP].object_flag)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
            }
            break;
        }
    }
}

int32 BattlegroundIC::_GetNodeNameId(uint8 node)
{
    switch (node)
    {
        case BG_IC_NODE_DOCK:                    return 12018;
        case BG_IC_NODE_HANGAR:                 return 12015;
        case BG_IC_NODE_QUARRY:                   return 12016;
        case BG_IC_NODE_REFINERY:                return 12017;
        case BG_IC_NODE_WORKSHOP:                  return 12019;
        case BG_IC_ALLIANCE_KEEP:                return 12039;
        case BG_IC_HORDE_KEEP:                  return 12038;
        case BG_IC_LAST_RESORT_GV_ALLIANCE:        return 0;
        case BG_IC_LAST_RESORT_GV_HORDE:         return 0;
        default:
            ASSERT(0);
    }
    return 0;
}

void BattlegroundIC::UpdateScore(uint16 team, int16 points)
{ //note: to remove reinforcementpoints points must be negative, for adding reinforcements points must be positive
    assert(team == ALLIANCE || team == HORDE);
    uint8 teamindex = GetTeamIndexByTeamId(team); //0=ally 1=horde
    m_Team_Scores[teamindex] += points;

    UpdateWorldState(((teamindex == BG_TEAM_HORDE)?BG_IC_HORDE_RENFORT:BG_IC_ALLIANCE_RENFORT), m_Team_Scores[teamindex]);
    if (points < 0)
    {
        if (m_Team_Scores[teamindex] < 1)
        {
            m_Team_Scores[teamindex]=0;
            EndBattleground(((teamindex == BG_TEAM_HORDE)?ALLIANCE:HORDE));
        }
    }
}

void BattlegroundIC::HandleKillPlayer(Player *player, Player *killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleKillPlayer(player, killer);
    UpdateScore(player->GetTeam(),-1);
}
