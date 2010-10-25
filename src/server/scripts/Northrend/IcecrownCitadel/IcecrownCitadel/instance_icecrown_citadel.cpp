/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * Copyright (C) 2010 Bolvor <http://bitbucket.org/bolvor/icecrown-citadel/>
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

#include "ScriptPCH.h"
#include "icecrown_citadel.h"

#define MAX_ENCOUNTER      12

class instance_icecrown_citadel : public InstanceMapScript
{
    public:
        instance_icecrown_citadel() : InstanceMapScript("instance_icecrown_citadel", 631) { }

        struct instance_icecrown_citadel_InstanceMapScript : public InstanceScript
        {
            instance_icecrown_citadel_InstanceMapScript(InstanceMap* pMap) : InstanceScript(pMap)
            {
                uiDifficulty = pMap->GetDifficulty();

                uiLordMarrowgar         = 0;
                uiLadyDeathwhisper      = 0;
                uiGunship               = 0;
                uiDeathbringerSaurfang  = 0;
                uiSaurfangEventNPC      = 0;
                uiDeathbringersCache    = 0;
                uiSaurfangTeleport      = 0;
                uiFestergut             = 0;
                uiRotface               = 0;
                uiStinky                = 0;
                uiPrecious              = 0;
                uiProfessorPutricide    = 0;
                uiAbomination           = 0;
                uiPrinceValanar         = 0;
                uiPrinceKeleseth        = 0;
                uiPrinceTaldaram        = 0;
                uiBloodQueenLanathel    = 0;
                uiValithriaDreamwalker  = 0;
                uiSindragosa            = 0;
                uiRimefang              = 0;
                uiSpinestalker          = 0;
                uiLichKing              = 0;
                m_uiSaurfangCacheGUID   = 0;

                uiIceWall1              = 0;
                uiIceWall2              = 0;
                uiMarrowgarEntrance     = 0;
                uiLadyDeathwisperTransporter = 0;
                uiOratoryDoor           = 0;
                uiSaurfangDoor          = 0;
                uiOrangeMonsterDoor     = 0;
                uiGreenMonsterDoor      = 0;
                uiProfCollisionDoor     = 0;
                uiOrangePipe            = 0;
                uiGreenPipe             = 0;
                uiOozeValve             = 0;
                uiGasValve              = 0;
                uiProfDoorOrange        = 0;
                uiProfDoorGreen         = 0;
                uiRotfaceEntrance       = 0;
                uiFestergurtEntrance    = 0;
                uiProffesorDoor         = 0;
                uiBloodwingDoor         = 0;
                uiCrimsonHallDoor1      = 0;
                uiCrimsonHallDoor2      = 0;
                uiCrimsonHallDoor3      = 0;
                uiBloodQueenTransporter = 0;
                uiFrostwingDoor         = 0;
                uiDragonDoor1           = 0;
                uiDragonDoor2           = 0;
                uiDragonDoor3           = 0;
                uiRoostDoor1            = 0;
                uiRoostDoor2            = 0;
                uiRoostDoor3            = 0;
                uiRoostDoor4            = 0;
                uiValithriaTransporter  = 0;
                uiSindragossaTransporter = 0;
                uiSindragosaDoor1       = 0;
                uiSindragosaDoor2       = 0;
                uiFirstTp               = 0;
                uiMarrowgarTp           = 0;
                uiFlightWarTp           = 0;
                uiSaurfangTp            = 0;
                uiCitadelTp             = 0;
                uiSindragossaTp         = 0;
                uiLichTp                = 0;

                memset(&uiEncounter, 0, sizeof(uiEncounter));
            };

            bool IsEncounterInProgress() const
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (uiEncounter[i] == IN_PROGRESS) return true;

                return false;
            }

            void OnCreatureCreate(Creature* pCreature, bool /*add*/)
            {
                Map::PlayerList const &players = instance->GetPlayers();
                uint32 TeamInInstance = 0;

                if (!players.isEmpty())
                {
                    if (Player* pPlayer = players.begin()->getSource())
                        TeamInInstance = pPlayer->GetTeam();
                }
                switch(pCreature->GetEntry())
                {
                    case NPC_LORD_MARROWGAR:
                        uiLordMarrowgar = pCreature->GetGUID();
                        break;
                    case NPC_LADY_DEATHWHISPER:
                        uiLadyDeathwhisper = pCreature->GetGUID();
                        break;
                    case CREATURE_GUNSHIP:
                        uiGunship = pCreature->GetGUID();
                        break;
                    case NPC_DEATHBRINGER_SAURFANG:
                        uiDeathbringerSaurfang = pCreature->GetGUID();
                        break;
                    case NPC_SE_HIGH_OVERLORD_SAURFANG:
                        if (TeamInInstance == ALLIANCE)
                            pCreature->UpdateEntry(NPC_SE_MURADIN_BRONZEBEARD, ALLIANCE);
                    case NPC_SE_MURADIN_BRONZEBEARD:
                        uiSaurfangEventNPC = pCreature->GetGUID();
                        pCreature->LastUsedScriptID = pCreature->GetScriptId();
                        break;
                    case NPC_SE_KOR_KRON_REAVER:
                        if (TeamInInstance == ALLIANCE)
                            pCreature->UpdateEntry(NPC_SE_SKYBREAKER_MARINE, ALLIANCE);
                        break;
                    case NPC_FESTERGUT:
                        uiFestergut = pCreature->GetGUID();
                        break;
                    case CREATURE_ROTFACE:
                        uiRotface = pCreature->GetGUID();
                        break;
                    case CREATURE_STINKY:
                        uiStinky = pCreature->GetGUID();
                        break;
                    case CREATURE_PRECIOUS:
                        uiPrecious = pCreature->GetGUID();
                        break;
                    case CREATURE_PROFESSOR_PUTRICIDE:
                        uiProfessorPutricide = pCreature->GetGUID();
                        break;
                    case CREATURE_PRINCE_VALANAR_ICC:
                        uiPrinceValanar = pCreature->GetGUID();
                        break;
                    case CREATURE_PRINCE_KELESETH_ICC:
                        uiPrinceKeleseth = pCreature->GetGUID();
                        break;
                    case CREATURE_PRINCE_TALDARAM_ICC:
                        uiPrinceTaldaram = pCreature->GetGUID();
                        break;
                    case CREATURE_BLOOD_QUEEN_LANATHEL:
                        uiBloodQueenLanathel = pCreature->GetGUID();
                        break;
                    case CREATURE_VALITHRIA_DREAMWALKER:
                        uiValithriaDreamwalker = pCreature->GetGUID();
                        break;
                    case CREATURE_SINDRAGOSA:
                        uiSindragosa = pCreature->GetGUID();
                        break;
                    case CREATURE_RIMEFANG:
                        uiRimefang = pCreature->GetGUID();
                        break;
                    case CREATURE_SPINESTALKER:
                        uiSpinestalker = pCreature->GetGUID();
                        break;
                    case CREATURE_LICH_KING:
                        uiLichKing = pCreature->GetGUID();
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* pGo, bool add)
            {
                switch (pGo->GetEntry())
                {
                    case LORD_ICE_WALL_1:
                        uiIceWall1 = pGo->GetGUID();
                        if (uiEncounter[0] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case LORD_ICE_WALL_2:
                        uiIceWall2 = pGo->GetGUID();
                        if (uiEncounter[0] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case LORD_ENTRANCE:
                        uiMarrowgarEntrance = pGo->GetGUID();
                        if (uiEncounter[0] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case ORATORY_ENTRANCE:
                        uiOratoryDoor = pGo->GetGUID();
                        if (uiEncounter[1] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case SAURFANG_DOOR:
                        uiSaurfangDoor = pGo->GetGUID();
                        if (uiEncounter[3] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case GO_DEATHBRINGER_S_CACHE_10N:
                    case GO_DEATHBRINGER_S_CACHE_25N:
                    case GO_DEATHBRINGER_S_CACHE_10H:
                    case GO_DEATHBRINGER_S_CACHE_25H:
                        uiDeathbringersCache = pGo->GetGUID();
                        break;
                    case GO_SCOURGE_TRANSPORTER_SAURFANG:
                        uiSaurfangTeleport = pGo->GetGUID();
                        break;
                    case BLOODWING_DOOR:
                        uiBloodwingDoor = pGo->GetGUID();
                        if (uiEncounter[3] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case FROSTWING_DOOR:
                        uiFrostwingDoor = pGo->GetGUID();
                        if (uiEncounter[3] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case CRIMSONHALL_DOOR:
                        uiCrimsonHallDoor1 = pGo->GetGUID();
                        if (uiEncounter[7] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case CRIMSONHALL_DOOR_1:
                        uiCrimsonHallDoor2 = pGo->GetGUID();
                        if (uiEncounter[7] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case CRIMSONHALL_DOOR_2:
                        uiCrimsonHallDoor3 = pGo->GetGUID();
                        if (uiEncounter[7] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DRAGON_DOOR_1:
                        uiDragonDoor1 = pGo->GetGUID();
                        if (uiEncounter[9] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case DRAGON_DOOR_2:
                        uiDragonDoor2 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DRAGON_DOOR_3:
                        uiDragonDoor3 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DREAMWALKER_DOOR_1:
                        uiRoostDoor1 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DREAMWALKER_DOOR_2:
                        uiRoostDoor2 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DREAMWALKER_DOOR_3:
                        uiRoostDoor3 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case DREAMWALKER_DOOR_4:
                        uiRoostDoor4 = pGo->GetGUID();
                        if (uiEncounter[9] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case SINDRAGOSSA_DOOR_1:
                        uiSindragosaDoor1 = pGo->GetGUID();
                        if (uiEncounter[10] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case SINDRAGOSSA_DOOR_2:
                        uiSindragosaDoor2 = pGo->GetGUID();
                        if (uiEncounter[10] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case PROF_COLLISION_DOOR:
                        uiProfCollisionDoor = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case GREEN_PIPE:
                        uiGreenPipe = pGo->GetGUID();
                        if (uiEncounter[5] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case OOZE_VALVE:
                        uiOozeValve = pGo->GetGUID();
                        if (uiEncounter[5] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case PROF_DOOR_GREEN:
                        uiProfDoorGreen = pGo->GetGUID();
                        if (uiEncounter[5] == NOT_STARTED)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case ORANGE_PIPE:
                        uiOrangePipe = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case GAS_VALVE:
                        uiGasValve = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case PROF_DOOR_ORANGE:
                        uiProfDoorOrange = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case ROTFACE_DOOR:
                        uiGreenMonsterDoor = pGo->GetGUID();
                        if (uiEncounter[5] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case FESTERGUT_DOOR:
                        uiOrangeMonsterDoor = pGo->GetGUID();
                        if (uiEncounter[4] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case PROFESSOR_DOOR:
                        uiProffesorDoor = pGo->GetGUID();
                        if (uiEncounter[6] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case DREAMWALKER_CACHE_10_N:
                    case DREAMWALKER_CACHE_25_N:
                    case DREAMWALKER_CACHE_10_H:
                    case DREAMWALKER_CACHE_25_H:
                        m_uiDreamwalkerCacheGUID = pGo->GetGUID();
                        break;
                    case LADY_ELEVATOR:
                        uiLadyDeathwisperTransporter = pGo->GetGUID();
                        break;
                    case BLOODQUEEN_ELEVATOR:
                        uiBloodQueenTransporter = pGo->GetGUID();
                        break;
                    case VALITHRIA_ELEVATOR:
                        uiValithriaTransporter = pGo->GetGUID();
                        break;
                    case SINDRAGOSSA_ELEVATOR:
                        uiSindragossaTransporter = pGo->GetGUID();
                        break;
                    case FIRST_TELEPORT:
                        uiFirstTp = pGo->GetGUID();
                        if (uiEncounter[0] == DONE)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case LORD_TELEPORT:
                        uiMarrowgarTp = pGo->GetGUID();
                        if (uiEncounter[0] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case SAURFANG_TELEPORT:
                        uiSaurfangTp = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case CITADEL_TELEPORT:
                        uiCitadelTp = pGo->GetGUID();
                        if (uiEncounter[4] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                    case SINDRAGOSSA_TELEPORT:
                        uiSindragossaTp = pGo->GetGUID();
                        if(uiEncounter[10] == NOT_STARTED)
                            HandleGameObject(NULL, true, pGo);
                        break;
                    case LICH_TELEPORT:
                        uiLichTp = pGo->GetGUID();
                        if(uiEncounter[10] == NOT_STARTED)
                            HandleGameObject(NULL, false, pGo);
                        break;
                }
            }

            uint64 GetData64(uint32 identifier)
            {
                switch(identifier)
                {
                    case DATA_LORD_MARROWGAR:         return uiLordMarrowgar;
                    case DATA_LADY_DEATHWHISPER:      return uiLadyDeathwhisper;
                    case DATA_GUNSHIP_BATTLE:         return uiGunship;
                    case DATA_DEATHBRINGER_SAURFANG : return uiDeathbringerSaurfang;
                    case DATA_SAURFANG_EVENT_NPC:     return uiSaurfangEventNPC;
                    case SAURFANG_DOOR:               return uiSaurfangDoor;
                    case GO_SCOURGE_TRANSPORTER_SAURFANG: return uiSaurfangTeleport;
                    case DATA_FESTERGUT:              return uiFestergut;
                    case DATA_ROTFACE:                return uiRotface;
                    case DATA_STINKY:                 return uiStinky;
                    case DATA_PRECIOUS:               return uiPrecious;
                    case DATA_PROFESSOR_PUTRICIDE:    return uiProfessorPutricide;
                    case DATA_ABOMINATION:            return uiAbomination;
                    case DATA_PRINCE_VALANAR_ICC:     return uiPrinceValanar;
                    case DATA_PRINCE_KELESETH_ICC:    return uiPrinceKeleseth;
                    case DATA_PRINCE_TALDARAM_ICC:    return uiPrinceTaldaram;
                    case DATA_BLOOD_QUEEN_LANATHEL:   return uiBloodQueenLanathel;
                    case DATA_VALITHRIA_DREAMWALKER:  return uiValithriaDreamwalker;
                    case DATA_SINDRAGOSA:             return uiSindragosa;
                    case DATA_RIMEFANG:               return uiRimefang;
                    case DATA_SPINESTALKER:           return uiSpinestalker;
                    case DATA_LICH_KING:              return uiLichKing;
                }
                return 0;
            }

            void SetData(uint32 type, uint32 data)
            {
                switch(type)
                {
                    case DATA_MARROWGAR_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiIceWall1, true);
                                HandleGameObject(uiIceWall2, true);
                                HandleGameObject(uiMarrowgarEntrance, true);
                                if (GameObject* FirstTp = instance->GetGameObject(uiFirstTp))
                                {
                                    FirstTp->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                    FirstTp->SetGoState(GOState(0));
                                }
                                if (GameObject* MarrowgarTp = instance->GetGameObject(uiMarrowgarTp))
                                {
                                    MarrowgarTp->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                    MarrowgarTp->SetGoState(GOState(0));
                                }
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiIceWall1, false);
                                HandleGameObject(uiIceWall2, false);
                                HandleGameObject(uiMarrowgarEntrance, true);
                                if (GameObject* FirstTp = instance->GetGameObject(uiFirstTp))
                                    FirstTp->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                if (GameObject* MarrowgarTp = instance->GetGameObject(uiMarrowgarTp))
                                    MarrowgarTp->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiMarrowgarEntrance, false);
                                break;
                        }
                        uiEncounter[0] = data;
                        break;
                    case DATA_DEATHWHISPER_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiOratoryDoor, true);
                                if (GameObject* pGO = instance->GetGameObject(uiLadyDeathwisperTransporter))
                                {
                                    pGO->SetUInt32Value(GAMEOBJECT_LEVEL, 0);
                                    pGO->SetGoState(GO_STATE_READY);
                                }
                                if (GameObject* FlightWarTp = instance->GetGameObject(uiFlightWarTp))
                                {
                                    FlightWarTp->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                    FlightWarTp->SetGoState(GOState(0));
                                }
                                if (GameObject* SaurfangTp = instance->GetGameObject(uiSaurfangTp))
                                {
                                    SaurfangTp->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                    SaurfangTp->SetGoState(GOState(0));
                                }
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiOratoryDoor, false);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiOratoryDoor, true);
                                if (GameObject* FlightWarTp = instance->GetGameObject(uiFlightWarTp))
                                    FlightWarTp->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                if (GameObject* SaurfangTp = instance->GetGameObject(uiSaurfangTp))
                                    SaurfangTp->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                break;
                        }
                        uiEncounter[1] = data;
                        break;

                    /*case DATA_GUNSHIP_BATTLE_EVENT:
                        switch(data)
                        {
                            case DONE:
                                break;
                            case NOT_STARTED:
                                break;
                        }
                        uiEncounter[2] = data;
                        break;*/
                    case DATA_DEATHBRINGER_SAURFANG:
                        switch (data)
                        {
                            case DONE:
                                HandleGameObject(uiSaurfangDoor, true);
                                DoRespawnGameObject(uiDeathbringersCache, 7*DAY);
                                break;
                            case NOT_STARTED:
                                if (GameObject* teleporter = instance->GetGameObject(uiSaurfangTeleport))
                                {
                                    HandleGameObject(uiSaurfangTeleport, true, teleporter);
                                    teleporter->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                                }
                                break;
                            case IN_PROGRESS:
                                break;
                        }
                        uiEncounter[3] = data;
                        break;
                    case DATA_FESTERGURT_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiOrangeMonsterDoor, true);
                                HandleGameObject(uiOrangePipe, true);
                                HandleGameObject(uiGasValve, true);
                                HandleGameObject(uiProfDoorOrange, true);
                                if (uiEncounter[5] == DONE)
                                    HandleGameObject(uiProfCollisionDoor, true);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiOrangeMonsterDoor, true);
                                HandleGameObject(uiOrangePipe, false);
                                HandleGameObject(uiGasValve, false);
                                HandleGameObject(uiProfDoorOrange, false);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiOrangeMonsterDoor, false);
                                HandleGameObject(uiOrangePipe, false);
                                HandleGameObject(uiGasValve, false);
                                HandleGameObject(uiProfDoorOrange, false);
                                break;
                        }
                        uiEncounter[4] = data;
                        break;
                    case DATA_ROTFACE_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiGreenMonsterDoor, true);
                                HandleGameObject(uiGreenPipe, true);
                                HandleGameObject(uiOozeValve, true);
                                HandleGameObject(uiProfDoorGreen, true);
                                if (uiEncounter[4] == DONE)
                                    HandleGameObject(uiProfCollisionDoor, true);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiGreenMonsterDoor, true);
                                HandleGameObject(uiGreenPipe, false);
                                HandleGameObject(uiOozeValve, false);
                                HandleGameObject(uiProfDoorGreen, false);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiGreenMonsterDoor, false);
                                HandleGameObject(uiGreenPipe, false);
                                HandleGameObject(uiOozeValve, false);
                                HandleGameObject(uiProfDoorGreen, false);
                                break;
                        }
                        uiEncounter[5] = data;
                        break;
                    case DATA_PROFESSOR_PUTRICIDE_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiProffesorDoor, true);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiProffesorDoor, true);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiProffesorDoor, false);
                                break;
                        }
                        uiEncounter[6] = data;
                        break;
                    case DATA_BLOOD_PRINCE_COUNCIL_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiCrimsonHallDoor1, true);
                                HandleGameObject(uiCrimsonHallDoor2, true);
                                HandleGameObject(uiCrimsonHallDoor3, true);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiCrimsonHallDoor1, true);
                                HandleGameObject(uiCrimsonHallDoor2, false);
                                HandleGameObject(uiCrimsonHallDoor3, false);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiCrimsonHallDoor1, false);
                                break;
                        }
                        uiEncounter[7] = data;
                        break;
                    case DATA_BLOOD_QUEEN_LANATHEL_EVENT:
                        switch(data)
                        {
                            case DONE:
                                if (GameObject* pGO = instance->GetGameObject(uiBloodQueenTransporter))
                                {
                                    pGO->SetUInt32Value(GAMEOBJECT_LEVEL, 0);
                                    pGO->SetGoState(GO_STATE_READY);
                                }
                                break;
                            case NOT_STARTED:
                                break;
                            case IN_PROGRESS:
                                break;
                        }
                        uiEncounter[8] = data;
                        break;
                    case DATA_VALITHRIA_DREAMWALKER_EVENT:
                        switch(data)
                        {
                            case DONE:
                                if (GameObject* pChest = instance->GetGameObject(m_uiDreamwalkerCacheGUID))
                                {
                                        pChest->SetRespawnTime(pChest->GetRespawnDelay());
                                }
                                if (GameObject* SindragossaTp = instance->GetGameObject(uiSindragossaTp))
                                {
                                    SindragossaTp->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                    SindragossaTp->SetGoState(GOState(0));
                                }
                                if (GameObject* pGO = instance->GetGameObject(uiValithriaTransporter))
                                {
                                    pGO->SetUInt32Value(GAMEOBJECT_LEVEL, 0);
                                    pGO->SetGoState(GO_STATE_READY);
                                }
                                if (GameObject* pGO = instance->GetGameObject(uiSindragossaTransporter))
                                {
                                    pGO->SetUInt32Value(GAMEOBJECT_LEVEL, 0);
                                    pGO->SetGoState(GO_STATE_READY);
                                }
                                HandleGameObject(uiDragonDoor1, true);
                                HandleGameObject(uiDragonDoor2, true);
                                HandleGameObject(uiDragonDoor3, true);
                                HandleGameObject(uiRoostDoor1, false);
                                HandleGameObject(uiRoostDoor2, false);
                                HandleGameObject(uiRoostDoor3, false);
                                HandleGameObject(uiRoostDoor4, false);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiDragonDoor1, true);
                                HandleGameObject(uiDragonDoor2, false);
                                HandleGameObject(uiDragonDoor3, false);
                                HandleGameObject(uiRoostDoor1, false);
                                HandleGameObject(uiRoostDoor2, false);
                                HandleGameObject(uiRoostDoor3, false);
                                HandleGameObject(uiRoostDoor4, false);
                                if (GameObject* SindragossaTp = instance->GetGameObject(uiSindragossaTp))
                                    SindragossaTp->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
                                break;
                            case IN_PROGRESS:
                                if (uiDifficulty == RAID_DIFFICULTY_10MAN_NORMAL || uiDifficulty == RAID_DIFFICULTY_10MAN_HEROIC)
                                {
                                    HandleGameObject(uiDragonDoor1, false);
                                    HandleGameObject(uiDragonDoor2, false);
                                    HandleGameObject(uiRoostDoor3, true);
                                    HandleGameObject(uiRoostDoor2, true);
                                    HandleGameObject(uiRoostDoor1, false);
                                    HandleGameObject(uiRoostDoor4, false);
                                }
                                else
                                {
                                    HandleGameObject(uiDragonDoor1, false);
                                    HandleGameObject(uiDragonDoor2, false);
                                    HandleGameObject(uiRoostDoor1, true);
                                    HandleGameObject(uiRoostDoor2, true);
                                    HandleGameObject(uiRoostDoor3, true);
                                    HandleGameObject(uiRoostDoor4, true);
                                }
                                break;
                            }
                            uiEncounter[9] = data;
                            break;
                    case DATA_SINDRAGOSA_EVENT:
                        switch(data)
                        {
                            case DONE:
                                HandleGameObject(uiSindragosaDoor1, true);
                                HandleGameObject(uiSindragosaDoor2, true);
                                break;
                            case NOT_STARTED:
                                HandleGameObject(uiSindragosaDoor1, true);
                                HandleGameObject(uiSindragosaDoor2, true);
                                break;
                            case IN_PROGRESS:
                                HandleGameObject(uiSindragosaDoor1, false);
                                HandleGameObject(uiSindragosaDoor2, false);
                                break;
                        }
                        uiEncounter[10] = data;
                        break;
                }

                if (data == DONE)
                {
                    SaveToDB();
                }
            }

            uint32 GetData(uint32 type)
            {
                switch(type)
                {
                    case DATA_MARROWGAR_EVENT:             return uiEncounter[0];
                    case DATA_DEATHWHISPER_EVENT:          return uiEncounter[1];
                    case DATA_GUNSHIP_BATTLE_EVENT:        return uiEncounter[2];
                    case DATA_SAURFANG_EVENT:              return uiEncounter[3];
                    case DATA_FESTERGURT_EVENT:            return uiEncounter[4];
                    case DATA_ROTFACE_EVENT:               return uiEncounter[5];
                    case DATA_PROFESSOR_PUTRICIDE_EVENT:   return uiEncounter[6];
                    case DATA_BLOOD_PRINCE_COUNCIL_EVENT:  return uiEncounter[7];
                    case DATA_BLOOD_QUEEN_LANATHEL_EVENT:  return uiEncounter[8];
                    case DATA_VALITHRIA_DREAMWALKER_EVENT: return uiEncounter[9];
                    case DATA_SINDRAGOSA_EVENT:            return uiEncounter[10];
                    case DATA_LICH_KING_EVENT:             return uiEncounter[11];
                }
                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "I C" << uiEncounter[0] << " " << uiEncounter[1] << " " << uiEncounter[2] << " " << uiEncounter[3]
                << " " << uiEncounter[4] << " " << uiEncounter[5] << " " << uiEncounter[6] << " " << uiEncounter[7] << " " << uiEncounter[8]
                << " " << uiEncounter[9] << " " << uiEncounter[10] << " " << uiEncounter[11];

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(in);

                char dataHead1, dataHead2;
                uint16 data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11;

                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4 >> data5 >> data6 >> data7 >> data8 >> data9 >> data10 >> data11;

                if (dataHead1 == 'I' && dataHead2 == 'C')
                {
                    uiEncounter[0] = data0;
                    uiEncounter[1] = data1;
                    uiEncounter[2] = data2;
                    uiEncounter[3] = data3;
                    uiEncounter[4] = data4;
                    uiEncounter[5] = data5;
                    uiEncounter[6] = data6;
                    uiEncounter[7] = data7;
                    uiEncounter[8] = data8;
                    uiEncounter[9] = data9;
                    uiEncounter[10] = data10;
                    uiEncounter[11] = data11;

                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                        if (uiEncounter[i] == IN_PROGRESS)
                            uiEncounter[i] = NOT_STARTED;

                } else OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

        private:
            uint64 uiLordMarrowgar;
            uint64 uiLadyDeathwhisper;
            uint64 uiGunship;
            uint64 uiDeathbringerSaurfang;
            uint64 uiSaurfangEventNPC;  // Muradin Bronzebeard or High Overlord Saurfang
            uint64 uiDeathbringersCache;
            uint64 uiFestergut;
            uint64 uiRotface;
            uint64 uiStinky;
            uint64 uiPrecious;
            uint64 uiProfessorPutricide;
            uint64 uiAbomination;
            uint64 uiPrinceValanar;
            uint64 uiPrinceKeleseth;
            uint64 uiPrinceTaldaram;
            uint64 uiBloodQueenLanathel;
            uint64 uiValithriaDreamwalker;
            uint64 uiSindragosa;
            uint64 uiRimefang;
            uint64 uiSpinestalker;
            uint64 uiLichKing;
            uint64 uiIceWall1;
            uint64 uiIceWall2;
            uint64 uiMarrowgarEntrance;
            uint64 uiFrozenThrone;
            uint64 m_uiSaurfangCacheGUID;
            uint64 uiSaurfangTeleport;
            uint64 uiLadyDeathwisperTransporter;
            uint64 uiOratoryDoor;
            uint64 uiSaurfangDoor;
            uint64 uiOrangeMonsterDoor;
            uint64 uiGreenMonsterDoor;
            uint64 uiProfCollisionDoor;
            uint64 uiOrangePipe;
            uint64 uiGreenPipe;
            uint64 uiOozeValve;
            uint64 uiGasValve;
            uint64 uiProfDoorOrange;
            uint64 uiProfDoorGreen;
            uint64 uiRotfaceEntrance;
            uint64 uiFestergurtEntrance;
            uint64 uiProffesorDoor;
            uint64 uiBloodwingDoor;
            uint64 uiCrimsonHallDoor1;
            uint64 uiCrimsonHallDoor2;
            uint64 uiCrimsonHallDoor3;
            uint64 uiBloodQueenTransporter;
            uint64 uiFrostwingDoor;
            uint64 uiDragonDoor1;
            uint64 uiDragonDoor2;
            uint64 uiDragonDoor3;
            uint64 uiRoostDoor1;
            uint64 uiRoostDoor2;
            uint64 uiRoostDoor3;
            uint64 uiRoostDoor4;
            uint64 uiValithriaTransporter;
            uint64 uiSindragossaTransporter;
            uint64 m_uiDreamwalkerCacheGUID;
            uint64 uiSindragosaDoor1;
            uint64 uiSindragosaDoor2;
            uint64 uiFirstTp;
            uint64 uiMarrowgarTp;
            uint64 uiFlightWarTp;
            uint64 uiSaurfangTp;
            uint64 uiCitadelTp;
            uint64 uiSindragossaTp;
            uint64 uiLichTp;
            uint8 uiDifficulty;
            uint32 uiEncounter[MAX_ENCOUNTER];
        };

        InstanceScript* GetInstanceScript(InstanceMap* pMap) const
        {
            return new instance_icecrown_citadel_InstanceMapScript(pMap);
        }
};

void AddSC_instance_icecrown_citadel()
{
    new instance_icecrown_citadel();
}
