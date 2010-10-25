/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * Copyright (C) 2010 BloodyCore <http://code.google.com/p/bloodycore/>
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

/* ScriptData
SDName: Instance_Ulduar
SD%Complete:
SDComment:
SDCategory: Ulduar
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

//Flame leviathan coordinates to summon - its vehicle
#define LEVIATHAN_X  458.518f
#define LEVIATHAN_Y  -11.585f
#define LEVIATHAN_Z  409.803f
#define LEVIATHAN_O  3.136f

const DoorData doorData[] =
{
    {194416,    BOSS_LEVIATHAN, DOOR_TYPE_ROOM,     0},
    {194905,    BOSS_LEVIATHAN, DOOR_TYPE_PASSAGE,  0},
    {194631,    BOSS_XT002,     DOOR_TYPE_ROOM,     0},
    {194554,    BOSS_ASSEMBLY,  DOOR_TYPE_ROOM,     0},
    {194556,    BOSS_ASSEMBLY,  DOOR_TYPE_PASSAGE,  0},
    {194553,    BOSS_KOLOGARN,  DOOR_TYPE_ROOM,     0},
    {194441,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194634,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194442,    BOSS_HODIR,     DOOR_TYPE_ROOM,     0},
    {194559,    BOSS_THORIM,    DOOR_TYPE_ROOM,     0},
    {194774,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194775,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194776,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194750,    BOSS_VEZAX,     DOOR_TYPE_PASSAGE,  0},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

enum eGameObjects
{
    GO_Leviathan_DOOR       = 194630,
    GO_Kologarn_BRIDGE      = 194232,
    GO_Hodir_Rare_CHEST     = 194200,
    GO_Runic_DOOR           = 194557,
    GO_Stone_DOOR           = 194558,
    GO_Thorim_LEVER         = 194265,
    GO_Mimiron_TRAM         = 194675,
    GO_Mimiron_ELEVATOR     = 194749,
    GO_Keepers_DOOR         = 194255
};

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            Initialize();
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadDoorData(doorData);
        }

        uint64 uiLeviathan;
        uint64 uiNorgannon;
        uint64 uiIgnis;
        uint64 uiRazorscale;
        uint64 uiExpCommander;
        uint64 uiXT002;
        uint64 uiSteelbreaker;
        uint64 uiMolgeim;
        uint64 uiBrundir;
        uint64 uiKologarn;
        uint64 uiKologarnBridge;
        uint64 uiAuriaya;
        uint64 uiBrightleaf;
        uint64 uiIronbranch;
        uint64 uiStonebark;
        uint64 uiFreya;
        uint64 uiThorim;
        uint64 uiRunicColossus;
        uint64 uiRuneGiant;
        uint64 uiMimiron;
        uint64 uiLeviathanMKII;
        uint64 uiVX001;
        uint64 uiAerialUnit;
        uint64 uiMagneticCore;
        uint64 KeepersGateGUID;
        uint64 uiVezax;
        uint64 uiFreyaImage;
        uint64 uiThorimImage;
        uint64 uiMimironImage;
        uint64 uiHodirImage;
        uint64 uiFreyaYS;
        uint64 uiThorimYS;
        uint64 uiMimironYS;
        uint64 uiHodirYS;
            
        GameObject* pLeviathanDoor, *HodirRareChest, *pRunicDoor, *pStoneDoor, *pThorimLever, *MimironTram, *MimironElevator;

        void OnGameObjectCreate(GameObject* pGo, bool add)
        {
            AddDoor(pGo, add);
            switch(pGo->GetEntry())
            {
                case GO_Leviathan_DOOR: pLeviathanDoor = add ? pGo : NULL; break;
                case GO_Kologarn_BRIDGE: uiKologarnBridge = pGo->GetGUID(); HandleGameObject(NULL, true, pGo); break;
                case GO_Hodir_Rare_CHEST: HodirRareChest = add ? pGo : NULL; break;
                case GO_Runic_DOOR: pRunicDoor = add ? pGo : NULL; break;
                case GO_Stone_DOOR: pStoneDoor = add ? pGo : NULL; break;
                case GO_Thorim_LEVER: pThorimLever = add ? pGo : NULL; break;
                case GO_Mimiron_TRAM: MimironTram = add ? pGo : NULL; break;
                case GO_Mimiron_ELEVATOR: MimironElevator = add ? pGo : NULL; break;
                case GO_Keepers_DOOR: KeepersGateGUID = pGo->GetGUID();
                {
                    pGo->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                        if (GetBossState(i) != DONE)
                            pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    break;
                }
            }
        }

        void OnCreatureCreate(Creature* pCreature, bool add)
        {
            Map::PlayerList const &players = instance->GetPlayers();
            uint32 TeamInInstance = 0;

            if (!players.isEmpty())
                if (Player* pPlayer = players.begin()->getSource())
                    TeamInInstance = pPlayer->GetTeam();
            
            switch(pCreature->GetEntry())
            {
                case 33113: uiLeviathan = pCreature->GetGUID(); return;
                case 33686: uiNorgannon = pCreature->GetGUID(); return;
                case 33118: uiIgnis = pCreature->GetGUID(); return;
                case 33186: uiRazorscale = pCreature->GetGUID(); return;
                case 33210: uiExpCommander = pCreature->GetGUID(); return;
                case 33293: uiXT002 = pCreature->GetGUID(); return;
                case 32867: uiSteelbreaker = pCreature->GetGUID(); return;
                case 32927: uiMolgeim = pCreature->GetGUID(); return;
                case 32857: uiBrundir = pCreature->GetGUID(); return;
                case 32930: uiKologarn = pCreature->GetGUID(); return;
                case 33515: uiAuriaya = pCreature->GetGUID(); return;
                case 32915: uiBrightleaf = pCreature->GetGUID(); return;
                case 32913: uiIronbranch = pCreature->GetGUID(); return;
                case 32914: uiStonebark = pCreature->GetGUID(); return;
                case 32906: uiFreya = pCreature->GetGUID(); return;
                case 32865: uiThorim = pCreature->GetGUID(); return;
                case 32872: uiRunicColossus = pCreature->GetGUID(); return;
                case 32873: uiRuneGiant = pCreature->GetGUID(); return;
                case 33350: uiMimiron = pCreature->GetGUID(); return;
                case 33432: uiLeviathanMKII = pCreature->GetGUID(); return;
                case 33651: uiVX001 = pCreature->GetGUID(); return;
                case 33670: uiAerialUnit = pCreature->GetGUID(); return;
                case 34068: uiMagneticCore = pCreature->GetGUID(); return;
                case 33271: uiVezax = pCreature->GetGUID(); return;
                case 33410: uiFreyaYS = pCreature->GetGUID(); return;
                case 33413: uiThorimYS = pCreature->GetGUID(); return;
                case 33412: uiMimironYS = pCreature->GetGUID(); return;
                case 33411: uiHodirYS = pCreature->GetGUID(); return;
                
                // Keeper's Images
                case 33241: uiFreyaImage = pCreature->GetGUID();
                {
                    pCreature->SetVisibility(VISIBILITY_OFF);
                    if (GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisibility(VISIBILITY_ON);
                }
                return;
                case 33242: uiThorimImage = pCreature->GetGUID();
                {
                    pCreature->SetVisibility(VISIBILITY_OFF);
                    if (GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisibility(VISIBILITY_ON);
                }
                return;
                case 33244: uiMimironImage = pCreature->GetGUID();
                {
                    pCreature->SetVisibility(VISIBILITY_OFF);
                    if (GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisibility(VISIBILITY_ON);
                }            
                return;
                case 33213: uiHodirImage = pCreature->GetGUID();
                {
                    pCreature->SetVisibility(VISIBILITY_OFF);
                    if (GetBossState(BOSS_VEZAX) == DONE)
                        pCreature->SetVisibility(VISIBILITY_ON);
                }
                return;
            }

            // Hodir: Alliance npcs are spawned by default
            if (TeamInInstance == HORDE)
                switch(pCreature->GetEntry())
                {
                    case 33325: pCreature->UpdateEntry(32941, HORDE); return;
                    case 32901: pCreature->UpdateEntry(33333, HORDE); return;
                    case 33328: pCreature->UpdateEntry(33332, HORDE); return;
                    case 32900: pCreature->UpdateEntry(32950, HORDE); return;
                    case 32893: pCreature->UpdateEntry(33331, HORDE); return;
                    case 33327: pCreature->UpdateEntry(32946, HORDE); return;
                    case 32897: pCreature->UpdateEntry(32948, HORDE); return;
                    case 33326: pCreature->UpdateEntry(33330, HORDE); return;
                    case 32908: pCreature->UpdateEntry(32907, HORDE); return;
                    case 32885: pCreature->UpdateEntry(32883, HORDE); return;
                }
        }

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
                case DATA_LEVIATHAN:
                    return uiLeviathan;
                case DATA_NORGANNON:
                    return uiNorgannon;
                case DATA_IGNIS:
                    return uiIgnis;
                case DATA_RAZORSCALE:
                    return uiRazorscale;
                case DATA_EXP_COMMANDER:
                    return uiExpCommander;
                case DATA_XT002:
                    return uiXT002;
                case DATA_STEELBREAKER:
                    return uiSteelbreaker;
                case DATA_MOLGEIM:
                    return uiMolgeim;
                case DATA_BRUNDIR:
                    return uiBrundir;
                case DATA_KOLOGARN:
                    return uiKologarn;
                case DATA_AURIAYA:
                    return uiAuriaya;
                case DATA_BRIGHTLEAF:
                    return uiBrightleaf;
                case DATA_IRONBRANCH:
                    return uiIronbranch;
                case DATA_STONEBARK:
                    return uiStonebark;
                case DATA_FREYA:
                    return uiFreya;
                case DATA_THORIM:
                    return uiThorim;
                case DATA_RUNIC_COLOSSUS:
                    return uiRunicColossus;
                case DATA_RUNE_GIANT:
                    return uiRuneGiant;
                case DATA_MIMIRON:
                    return uiMimiron;
                case DATA_LEVIATHAN_MK_II:
                    return uiLeviathanMKII;
                case DATA_VX_001:
                    return uiVX001;
                case DATA_AERIAL_UNIT:
                    return uiAerialUnit;
                case DATA_MAGNETIC_CORE:
                    return uiMagneticCore;
                case DATA_VEZAX:
                    return uiVezax;
                case DATA_YS_FREYA:
                    return uiFreyaYS;
                case DATA_YS_THORIM:
                    return uiThorimYS;
                case DATA_YS_MIMIRON:
                    return uiMimironYS;
                case DATA_YS_HODIR:
                    return uiHodirYS;
            }
            return 0;
        }
        
        void SetData(uint32 id, uint32 value)
        {
            switch(id)
            {
                case DATA_LEVIATHAN_DOOR:
                    if (pLeviathanDoor)
                        pLeviathanDoor->SetGoState(GOState(value));
                    break;
                case DATA_RUNIC_DOOR:
                    if (pRunicDoor)
                        pRunicDoor->SetGoState(GOState(value));
                    break;
                case DATA_STONE_DOOR:
                    if (pStoneDoor)
                        pStoneDoor->SetGoState(GOState(value));
                    break;
                case DATA_CALL_TRAM:
                    if (MimironTram && instance)
                    {
                        // Load Mimiron Tram (unfortunally only server side)
                        instance->LoadGrid(2307, 284.632f);
                    
                        if (value == 0)
                            MimironTram->SetGoState(GO_STATE_READY);
                        if (value == 1)
                            MimironTram->SetGoState(GO_STATE_ACTIVE);
                        
                        // Send movement update to players
                        if (Map* pMap = MimironTram->GetMap())
                            if (pMap->IsDungeon())
                            {
                                Map::PlayerList const &PlayerList = pMap->GetPlayers();

                                if (!PlayerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                        if (i->getSource())
                                        {
                                            UpdateData data;
                                            WorldPacket pkt;
                                            MimironTram->BuildValuesUpdateBlockForPlayer(&data, i->getSource());
                                            data.BuildPacket(&pkt);
                                            i->getSource()->GetSession()->SendPacket(&pkt);
                                        }
                            }
                    }
                    break;
                case DATA_MIMIRON_ELEVATOR:
                    if (MimironElevator)
                        MimironElevator->SetGoState(GOState(value));
                    break;
                case DATA_HODIR_RARE_CHEST:
                    if (HodirRareChest && value == GO_STATE_READY)
                        HodirRareChest->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_UNK1);
                    break;
            }
        }

        bool SetBossState(uint32 id, EncounterState state)
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;
                
            switch (id)
            {
                case BOSS_KOLOGARN:
                    if (state == DONE)
                        HandleGameObject(uiKologarnBridge, false);
                    break;
                case BOSS_HODIR:
                    CheckKeepersState();
                    break;
                case BOSS_THORIM:
                    if (state == IN_PROGRESS)
                        pThorimLever->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_UNK1);
                    CheckKeepersState();
                    break;
                case BOSS_MIMIRON:
                    CheckKeepersState();
                    break;
                case BOSS_FREYA:
                    CheckKeepersState();
                    break;
                case BOSS_VEZAX:
                    if (state == DONE)
                    {
                        // Keeper's Images
                        if (Creature* pFreya = instance->GetCreature(uiFreyaImage))
                            pFreya->SetVisibility(VISIBILITY_ON);
                        if (Creature* pThorim = instance->GetCreature(uiThorimImage))
                            pThorim->SetVisibility(VISIBILITY_ON);
                        if (Creature* pMimiron = instance->GetCreature(uiMimironImage))
                            pMimiron->SetVisibility(VISIBILITY_ON);
                        if (Creature* pHodir = instance->GetCreature(uiHodirImage))
                            pHodir->SetVisibility(VISIBILITY_ON);
                    }
                    break;
            }
            
            return true;
        }
        
        void CheckKeepersState()
        {
            if (GameObject* pGo = instance->GetGameObject(KeepersGateGUID))
            {
                pGo->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                    if (GetBossState(i) != DONE)
                        pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
            }
        }
    };
};


void AddSC_instance_ulduar()
{
    new instance_ulduar();
}
