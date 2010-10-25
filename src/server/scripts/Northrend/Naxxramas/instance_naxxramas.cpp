/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2010 Lol Core <http://hg.assembla.com/LoL_Trinity/>
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
#include "naxxramas.h"

const DoorData doorData[] =
{
    {181126,    BOSS_ANUBREKHAN,DOOR_TYPE_ROOM,     BOUNDARY_S},
    {181195,    BOSS_ANUBREKHAN,DOOR_TYPE_PASSAGE,  0},
    {194022,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181209,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181209,    BOSS_MAEXXNA,   DOOR_TYPE_ROOM,     BOUNDARY_SW},
    {181200,    BOSS_NOTH,      DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181201,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181202,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  0},
    {181202,    BOSS_HEIGAN,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181203,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181241,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  0},
    {181241,    BOSS_LOATHEB,   DOOR_TYPE_ROOM,     BOUNDARY_W},
    {181123,    BOSS_PATCHWERK, DOOR_TYPE_PASSAGE,  0},
    {181123,    BOSS_GROBBULUS, DOOR_TYPE_ROOM,     0},
    {181120,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  BOUNDARY_NW},
    {181121,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  0},
    {181121,    BOSS_THADDIUS,  DOOR_TYPE_ROOM,     0},
    {181124,    BOSS_RAZUVIOUS, DOOR_TYPE_PASSAGE,  0},
    {181124,    BOSS_GOTHIK,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181125,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  BOUNDARY_S},
    {181119,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  0},
    {181119,    BOSS_HORSEMEN,  DOOR_TYPE_ROOM,     BOUNDARY_NE},
    {181225,    BOSS_SAPPHIRON, DOOR_TYPE_PASSAGE,  BOUNDARY_W},
    {181228,    BOSS_KELTHUZAD, DOOR_TYPE_ROOM,     BOUNDARY_S},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

const MinionData minionData[] =
{
    //{16573,     BOSS_ANUBREKHAN},     there is no spawn point in db, so we do not add them here
    {16506,     BOSS_FAERLINA},
    {16505,     BOSS_FAERLINA},
    {16803,     BOSS_RAZUVIOUS},
    {16063,     BOSS_HORSEMEN},
    {16064,     BOSS_HORSEMEN},
    {16065,     BOSS_HORSEMEN},
    {30549,     BOSS_HORSEMEN},
    {0,         0,}
};

enum eEnums
{
    GO_HORSEMEN_CHEST_HERO  = 193426,
    GO_HORSEMEN_CHEST       = 181366,                   //four horsemen event, DoRespawnGameObject() when event == DONE
    GO_GOTHIK_GATE          = 181170,
    GO_KELTHUZAD_PORTAL01   = 181402,
    GO_KELTHUZAD_PORTAL02   = 181403,
    GO_KELTHUZAD_PORTAL03   = 181404,
    GO_KELTHUZAD_PORTAL04   = 181405,
    GO_KELTHUZAD_TRIGGER    = 181444,

    GO_ROOM_ANUBREKHAN      = 181126,
    GO_PASSAGE_ANUBREKHAN   = 181195,
    GO_PASSAGE_FAERLINA     = 194022,
    GO_ROOM_MAEXXNA         = 181209,
    GO_ROOM_NOTH            = 181200,
    GO_PASSAGE_NOTH         = 181201,
    GO_ROOM_HEIGAN          = 181202,
    GO_PASSAGE_HEIGAN       = 181203,
    GO_ROOM_LOATHEB         = 181241,
    GO_ROOM_GROBBULUS       = 181123,
    GO_PASSAGE_GLUTH        = 181120,
    GO_ROOM_THADDIUS        = 181121,
    GO_ROOM_GOTHIK          = 181124,
    GO_PASSAGE_GOTHIK       = 181125,
    GO_ROOM_HORSEMEN        = 181119,
    GO_PASSAGE_SAPPHIRON    = 181225,
    GO_ROOM_KELTHUZAD       = 181228,

    SPELL_ERUPTION          = 29371,
    SPELL_SLIME             = 28801
};

enum eDoors
{
    DOOR_ROOM_ANUBREKHAN      = 0,
    DOOR_PASSAGE_ANUBREKHAN,
    DOOR_PASSAGE_FAERLINA,
    DOOR_ROOM_MAEXXNA,
    DOOR_ROOM_NOTH,
    DOOR_PASSAGE_NOTH,
    DOOR_ROOM_HEIGAN,
    DOOR_PASSAGE_HEIGAN,
    DOOR_ROOM_LOATHEB,
    DOOR_ROOM_GROBBULUS,
    DOOR_PASSAGE_GLUTH,
    DOOR_ROOM_THADDIUS,
    DOOR_ROOM_GOTHIK,
    DOOR_PASSAGE_GOTHIK,
    DOOR_ROOM_HORSEMEN,
    DOOR_PASSAGE_SAPPHIRON,
    DOOR_ROOM_KELTHUZAD,
    MAX_DOOR_NAXX
};

const float HeiganPos[2] = {2796, -3707};
const float HeiganEruptionSlope[3] =
{
    (-3685 - HeiganPos[1]) /(2724 - HeiganPos[0]),
    (-3647 - HeiganPos[1]) /(2749 - HeiganPos[0]),
    (-3637 - HeiganPos[1]) /(2771 - HeiganPos[0]),
};

// 0  H      x
//  1        ^
//   2       |
//    3  y<--o
inline uint32 GetEruptionSection(float x, float y)
{
    y -= HeiganPos[1];
    if (y < 1.0f)
        return 0;

    x -= HeiganPos[0];
    if (x > -1.0f)
        return 3;

    float slope = y/x;
    for (uint32 i = 0; i < 3; ++i)
        if (slope > HeiganEruptionSlope[i])
            return i;
    return 3;
}

class instance_naxxramas : public InstanceMapScript
{
public:
    instance_naxxramas() : InstanceMapScript("instance_naxxramas", 533) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_naxxramas_InstanceMapScript(pMap);
    }

    struct instance_naxxramas_InstanceMapScript : public InstanceScript
    {
        instance_naxxramas_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            //SetBossNumber(MAX_BOSS_NUMBER);
            //LoadDoorData(doorData);
            //LoadMinionData(minionData);

            Initialize();
        }

        std::set<uint64> HeiganEruptionGUID[4];

        std::set<uint64> FaerlinaMinion;
        std::set<uint64> RazuviousMinion;
        std::set<uint64> Horsemen;

        uint32 m_auiEncounter[MAX_BOSS_NUMBER];

        uint32 SlimeCheckTimer;

        uint64 GothikGateGUID;
        uint64 HorsemenChestGUID;
        uint64 SapphironGUID;
        uint64 uiFaerlina;
        uint64 uiThane;
        uint64 uiLady;
        uint64 uiBaron;
        uint64 uiSir;

        uint64 uiThaddius;
        uint64 uiFeugen;
        uint64 uiStalagg;

        uint64 uiKelthuzad;
        uint64 uiKelthuzadTrigger;
        uint64 uiPortals[4];
        uint64 uiNaxxDoors[MAX_DOOR_NAXX];

        GOState gothikDoorState;

        time_t minHorsemenDiedTime;
        time_t maxHorsemenDiedTime;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            gothikDoorState = GO_STATE_READY;
            SlimeCheckTimer = 1000;
        }

        void OnCreatureCreate(Creature* pCreature, bool add)
        {
            switch(pCreature->GetEntry())
            {
                case 15989: SapphironGUID = add ? pCreature->GetGUID() : 0; return;
                case 15953: uiFaerlina = pCreature->GetGUID(); return;
                case 16064: uiThane = pCreature->GetGUID(); return;
                case 16065: uiLady = pCreature->GetGUID(); return;
                case 30549: uiBaron = pCreature->GetGUID(); return;
                case 16063: uiSir = pCreature->GetGUID(); return;
                case 15928: uiThaddius = pCreature->GetGUID(); return;
                case 15930: uiFeugen = pCreature->GetGUID(); return;
                case 15929: uiStalagg = pCreature->GetGUID(); return;
                case 15990: uiKelthuzad = pCreature->GetGUID(); return;
            }
            switch(pCreature->GetEntry())
            {
                case 16506:
                case 16505:
                    FaerlinaMinion.insert(pCreature->GetGUID());
                    break;
                case 16803:
                    RazuviousMinion.insert(pCreature->GetGUID());
                    break;
                case 16063:
                case 16064:
                case 16065:
                case 30549:
                    Horsemen.insert(pCreature->GetGUID());
                    break;
            }

            //AddMinion(pCreature, add);
        }

        void OnGameObjectCreate(GameObject* pGo, bool add)
        {
            if (pGo->GetGOInfo()->displayId == 6785 || pGo->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(pGo->GetPositionX(), pGo->GetPositionY());
                if (add)
                    HeiganEruptionGUID[section].insert(pGo->GetGUID());
                else
                    HeiganEruptionGUID[section].erase(pGo->GetGUID());
                return;
            }

            switch(pGo->GetEntry())
            {
                case GO_BIRTH:
                if (!add && SapphironGUID)
                {
                    if (Creature *pSapphiron = instance->GetCreature(SapphironGUID))
                        pSapphiron->AI()->DoAction(DATA_SAPPHIRON_BIRTH);
                    return;
                }
                case GO_GOTHIK_GATE:
                    GothikGateGUID = add ? pGo->GetGUID() : 0;
                    pGo->SetGoState(gothikDoorState);
                    break;
                case GO_HORSEMEN_CHEST: HorsemenChestGUID = add ? pGo->GetGUID() : 0; break;
                case GO_HORSEMEN_CHEST_HERO: HorsemenChestGUID = add ? pGo->GetGUID() : 0; break;
                case GO_KELTHUZAD_PORTAL01: uiPortals[0] = pGo->GetGUID(); break;
                case GO_KELTHUZAD_PORTAL02: uiPortals[1] = pGo->GetGUID(); break;
                case GO_KELTHUZAD_PORTAL03: uiPortals[2] = pGo->GetGUID(); break;
                case GO_KELTHUZAD_PORTAL04: uiPortals[3] = pGo->GetGUID(); break;
                case GO_KELTHUZAD_TRIGGER: uiKelthuzadTrigger = pGo->GetGUID(); break;

                case GO_ROOM_ANUBREKHAN:
                    uiNaxxDoors[DOOR_ROOM_ANUBREKHAN] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_ANUBREKHAN] != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_ANUBREKHAN:
                    uiNaxxDoors[DOOR_PASSAGE_ANUBREKHAN] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_ANUBREKHAN] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_FAERLINA:
                    uiNaxxDoors[DOOR_PASSAGE_FAERLINA] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_FAERLINA] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_MAEXXNA:
                    uiNaxxDoors[DOOR_ROOM_MAEXXNA] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_FAERLINA] == DONE && m_auiEncounter[BOSS_MAEXXNA] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_NOTH:
                    uiNaxxDoors[DOOR_ROOM_NOTH] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_FAERLINA] != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_NOTH:
                    uiNaxxDoors[DOOR_PASSAGE_NOTH] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_NOTH] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_HEIGAN:
                    uiNaxxDoors[DOOR_ROOM_HEIGAN] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_HEIGAN] != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_HEIGAN:
                    uiNaxxDoors[DOOR_PASSAGE_HEIGAN] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_HEIGAN] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_LOATHEB:
                    uiNaxxDoors[DOOR_ROOM_LOATHEB] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_HEIGAN] == DONE && m_auiEncounter[BOSS_LOATHEB] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_GROBBULUS:
                    uiNaxxDoors[DOOR_ROOM_GROBBULUS] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_PATCHWERK] == DONE && m_auiEncounter[BOSS_GROBBULUS] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_GLUTH:
                    uiNaxxDoors[DOOR_PASSAGE_GLUTH] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_GLUTH] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_THADDIUS:
                    uiNaxxDoors[DOOR_ROOM_THADDIUS] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_GLUTH] == DONE && m_auiEncounter[BOSS_THADDIUS] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_GOTHIK:
                    uiNaxxDoors[DOOR_ROOM_GOTHIK] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_RAZUVIOUS] == DONE && m_auiEncounter[BOSS_GOTHIK] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_GOTHIK:
                    uiNaxxDoors[DOOR_PASSAGE_GOTHIK] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_GOTHIK] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_HORSEMEN:
                    uiNaxxDoors[DOOR_ROOM_HORSEMEN] = pGo->GetGUID();
                    pGo->SetGoState((m_auiEncounter[BOSS_GOTHIK] == DONE && m_auiEncounter[BOSS_HORSEMEN] != IN_PROGRESS) ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_PASSAGE_SAPPHIRON:
                    uiNaxxDoors[DOOR_PASSAGE_SAPPHIRON] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_SAPPHIRON] == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ROOM_KELTHUZAD:
                    uiNaxxDoors[DOOR_ROOM_KELTHUZAD] = pGo->GetGUID();
                    pGo->SetGoState(m_auiEncounter[BOSS_KELTHUZAD] != IN_PROGRESS ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;

            }

            //AddDoor(pGo, add);
        }

        void SetData(uint32 id, uint32 value)
        {
            switch(id)
            {
                case DATA_HEIGAN_ERUPT:
                    HeiganErupt(value);
                    break;
                case DATA_GOTHIK_GATE:
                    if (GameObject *pGothikGate = instance->GetGameObject(GothikGateGUID))
                        pGothikGate->SetGoState(GOState(value));
                    gothikDoorState = GOState(value);
                    break;

                case DATA_HORSEMEN0:
                case DATA_HORSEMEN1:
                case DATA_HORSEMEN2:
                case DATA_HORSEMEN3:
                    if (value == NOT_STARTED)
                    {
                        minHorsemenDiedTime = 0;
                        maxHorsemenDiedTime = 0;
                    }
                    else if (value == DONE)
                    {
                        time_t now = time(NULL);

                        if (minHorsemenDiedTime == 0)
                            minHorsemenDiedTime = now;

                        maxHorsemenDiedTime = now;
                    }
                    break;
            }
        }

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
            case DATA_FAERLINA:
                return uiFaerlina;
            case DATA_THANE:
                return uiThane;
            case DATA_LADY:
                return uiLady;
            case DATA_BARON:
                return uiBaron;
            case DATA_SIR:
                return uiSir;
            case DATA_THADDIUS:
                return uiThaddius;
            case DATA_FEUGEN:
                return uiFeugen;
            case DATA_STALAGG:
                return uiStalagg;
            case DATA_KELTHUZAD:
                return uiKelthuzad;
            case DATA_KELTHUZAD_PORTAL01:
                return uiPortals[0];
            case DATA_KELTHUZAD_PORTAL02:
                return uiPortals[1];
            case DATA_KELTHUZAD_PORTAL03:
                return uiPortals[2];
            case DATA_KELTHUZAD_PORTAL04:
                return uiPortals[3];
            case DATA_KELTHUZAD_TRIGGER:
                return uiKelthuzadTrigger;
            }
            return 0;
        }

        uint32 GetData(uint32 id)
        {
            return GetNaxxBossState(id);
        }

        bool SetBossState(uint32 id, EncounterState state)
        {
            //if (!InstanceScript::SetBossState(id, state))
            //    return false;

            if(m_auiEncounter[id] != state)
            {
                UpdateNaxxMinionState(id,state);
                UpdateNaxxDoorState(id,state);
            }

            if(m_auiEncounter[id] != DONE)
                m_auiEncounter[id] = state;

            if (id == BOSS_HORSEMEN && state == DONE)
            {
                if (GameObject *pHorsemenChest = instance->GetGameObject(HorsemenChestGUID))
                    pHorsemenChest->SetRespawnTime(pHorsemenChest->GetRespawnDelay());
            }

            return true;
        }

        EncounterState GetNaxxBossState(uint32 id)
        {
            if(id < MAX_BOSS_NUMBER)
                return ((EncounterState)m_auiEncounter[id]);
            else return NOT_STARTED;
        }

        void UpdateNaxxDoorState(uint32 id, EncounterState state)
        {
            switch(id)
            {
            case BOSS_ANUBREKHAN:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_ANUBREKHAN], state != IN_PROGRESS);
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_ANUBREKHAN], state == DONE);
                break;
            case BOSS_FAERLINA:
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_FAERLINA],state == DONE);
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_MAEXXNA],state == DONE);
                break;
            case BOSS_MAEXXNA:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_MAEXXNA],state != IN_PROGRESS);
                break;
            case BOSS_NOTH:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_NOTH],state != IN_PROGRESS);
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_NOTH],state == DONE);
                break;
            case BOSS_HEIGAN:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_HEIGAN], state != IN_PROGRESS);
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_HEIGAN], state == DONE);
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_LOATHEB], state == DONE);
                break;
            case BOSS_LOATHEB:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_LOATHEB], state != IN_PROGRESS);
                break;
            case BOSS_PATCHWERK:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_GROBBULUS], state == DONE);
                break;
            case BOSS_GROBBULUS:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_GROBBULUS], state != IN_PROGRESS);
                break;
            case BOSS_GLUTH:
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_GLUTH], state == DONE);
                HandleGameObject(uiNaxxDoors[BOSS_THADDIUS], state == DONE);
                break;
            case BOSS_THADDIUS:
                HandleGameObject(uiNaxxDoors[BOSS_THADDIUS], state != IN_PROGRESS);
                break;
            case BOSS_RAZUVIOUS:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_GOTHIK], state == DONE);
                break;
            case BOSS_GOTHIK:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_GOTHIK], state != IN_PROGRESS);
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_GOTHIK], state == DONE);
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_HORSEMEN], state == DONE);
                break;
            case BOSS_HORSEMEN:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_HORSEMEN], state != IN_PROGRESS);
                break;
            case BOSS_SAPPHIRON:
                HandleGameObject(uiNaxxDoors[DOOR_PASSAGE_SAPPHIRON],state == DONE);
                break;
            case BOSS_KELTHUZAD:
                HandleGameObject(uiNaxxDoors[DOOR_ROOM_KELTHUZAD],state != IN_PROGRESS);
                break;
            }
        }

        void UpdateNaxxMinionState(uint32 id, EncounterState state)
        {
            switch(id)
            {
            case BOSS_FAERLINA:
                for (std::set<uint64>::const_iterator i =  FaerlinaMinion.begin(); i != FaerlinaMinion.end(); ++i)
                    if(Creature* minion = instance->GetCreature((*i)))
                        UpdateMinionState(minion,state);
                break;
            case BOSS_RAZUVIOUS:
                for (std::set<uint64>::const_iterator i =  RazuviousMinion.begin(); i != RazuviousMinion.end(); ++i)
                    if(Creature* minion = instance->GetCreature((*i)))
                        UpdateMinionState(minion,state);
                break;
            case BOSS_HORSEMEN:
                for (std::set<uint64>::const_iterator i =  Horsemen.begin(); i != Horsemen.end(); ++i)
                    if(Creature* minion = instance->GetCreature((*i)))
                        UpdateMinionState(minion,state);
                break;
            }
        }

        void HeiganErupt(uint32 section)
        {
            for (uint32 i = 0; i < 4; ++i)
            {
                if (i == section)
                    continue;

                for (std::set<uint64>::const_iterator itr = HeiganEruptionGUID[i].begin(); itr != HeiganEruptionGUID[i].end(); ++itr)
                {
                    if (GameObject *pHeiganEruption = instance->GetGameObject(*itr))
                    {
                        pHeiganEruption->SendCustomAnim();
                        pHeiganEruption->CastSpell(NULL, SPELL_ERUPTION);
                    }
                }
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target = NULL*/, uint32 /*miscvalue1 = 0*/)
        {
            switch(criteria_id)
            {
                case 7600:  // Criteria for achievement 2176: And They Would All Go Down Together 15sec of each other 10-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
                case 7601:  // Criteria for achievement 2177: And They Would All Go Down Together 15sec of each other 25-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
                case 13233: // Criteria for achievement 2186: The Immortal (25-man)
                    // TODO.
                    break;
                case 13237: // Criteria for achievement 2187: The Undying (10-man)
                    // TODO.
                    break;
            }
            return false;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << "N X ";
            for(int i = 0; i < MAX_BOSS_NUMBER; ++i)
                saveStream << m_auiEncounter[i] << " ";

            saveStream << gothikDoorState;
            return saveStream.str();
        }

        void Load(const char * data)
        {
            std::istringstream loadStream(data);
            char dataHead1, dataHead2;
            loadStream >> dataHead1 >> dataHead2;
            std::string newdata = loadStream.str();

            uint32 buff;
            if(dataHead1 == 'N' && dataHead2 == 'X')
            {
                for(int i = 0; i < MAX_BOSS_NUMBER; ++i)
                {
                    loadStream >> buff;
                    m_auiEncounter[i]= buff;
                }
                //std::istringstream loadStream(LoadBossState(data));



                loadStream >> buff;
                gothikDoorState = GOState(buff);
            }
        }

        void Update (uint32 diff)
        {
            //Water checks
            if (SlimeCheckTimer <= diff)
            {
                Map::PlayerList const &PlayerList = instance->GetPlayers();
                if (PlayerList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    if (Player* pPlayer = i->getSource())
                    {
                        if (pPlayer->isAlive() && /*i->getSource()->GetPositionZ() <= -21.434931f*/pPlayer->IsInWater())
                        {
                            if (!pPlayer->HasAura(SPELL_SLIME))
                            {
                                pPlayer->CastSpell(pPlayer, SPELL_SLIME,true);
                            }
                        }
                        if (!pPlayer->IsInWater())
                            pPlayer->RemoveAurasDueToSpell(SPELL_SLIME);
                    }
                }
                SlimeCheckTimer = 1000;//remove stress from core
            } else SlimeCheckTimer -= diff;
        }
    };

};

class AreaTrigger_at_naxxramas_frostwyrm_wing : public AreaTriggerScript
{
    public:

        AreaTrigger_at_naxxramas_frostwyrm_wing()
            : AreaTriggerScript("at_naxxramas_frostwyrm_wing")
        {
        }

        bool OnTrigger(Player* player, AreaTriggerEntry const* trigger)
        {
            if (player->isGameMaster())
                return false;

            InstanceScript *data = player->GetInstanceScript();
            if (data)
                for (uint32 i = BOSS_ANUBREKHAN; i < BOSS_SAPPHIRON; ++i)
                    if (data->GetBossState(i) != DONE)
                        return true;

            return false;
        }
};

void AddSC_instance_naxxramas()
{
    new instance_naxxramas();
    new AreaTrigger_at_naxxramas_frostwyrm_wing();
}
