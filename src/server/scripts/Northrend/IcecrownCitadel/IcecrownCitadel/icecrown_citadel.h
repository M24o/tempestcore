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

#ifndef DEF_ICECROWN_CITADEL_H
#define DEF_ICECROWN_CITADEL_H

enum eSharedSpells
{
    SPELL_BERSERK   = 26662,
    SPELL_BERSERK2  = 47008
};

enum eEnums
{
    SOUND_ENDING_7_KING                   = 17360,
    MODEL_INVISIBLE                       = 11686,
    MOVIE_ID_ARTHAS_DEATH                 = 14
};

enum eAchievements
{
    ACHIEV_MESS_10                        = 4537,
    ACHIEV_MESS_25                        = 4613,
    ACHIEVMENT_ONCE_BITTEN_TWICE_SHY_10   = 4539,
    ACHIEVMENT_ONCE_BITTEN_TWICE_SHY_25   = 4618
};

enum ePutricideActions
{
    ACTION_FESTERGUT_COMBAT     = -366260,
    ACTION_FESTERGUT_GAS        = -366261,
    ACTION_FESTERGUT_DEATH      = -366262,

    ACTION_ROTFACE_COMBAT       = -366270,
    ACTION_ROTFACE_GAS          = -366271,
    ACTION_ROTFACE_DEATH        = -366272
};

enum Data
{
    DATA_MARROWGAR_EVENT,
    DATA_DEATHWHISPER_EVENT,
    DATA_GUNSHIP_BATTLE_EVENT,
    DATA_SAURFANG_EVENT,
    DATA_FESTERGURT_EVENT,
    DATA_ROTFACE_EVENT,
    DATA_PROFESSOR_PUTRICIDE_EVENT,
    DATA_BLOOD_PRINCE_COUNCIL_EVENT,
    DATA_BLOOD_QUEEN_LANATHEL_EVENT,
    DATA_VALITHRIA_DREAMWALKER_EVENT,
    DATA_SINDRAGOSA_EVENT,
    DATA_LICH_KING_EVENT
};

enum Data64
{
    DATA_LORD_MARROWGAR,
    DATA_LADY_DEATHWHISPER,
    DATA_DEATHBRINGER_SAURFANG,
    DATA_GUNSHIP_BATTLE,
    DATA_FESTERGUT,
    DATA_ROTFACE,
    DATA_STINKY,
    DATA_PRECIOUS,
    DATA_PROFESSOR_PUTRICIDE,
    DATA_ABOMINATION,
    DATA_PRINCE_VALANAR_ICC,
    DATA_PRINCE_KELESETH_ICC,
    DATA_PRINCE_TALDARAM_ICC,
    DATA_BLOOD_QUEEN_LANATHEL,
    DATA_VALITHRIA_DREAMWALKER,
    DATA_SINDRAGOSA,
    DATA_SPINESTALKER,
    DATA_RIMEFANG,
    DATA_LICH_KING,
    DATA_SAURFANG_EVENT_NPC,

    COMMAND_FAIL_BONED
};

enum eGameobjectsTrinity
{
    GO_DOODAD_ICECROWN_ICEWALL02        = 201910,
    GO_ICEWALL                          = 201911,
    GO_LORD_MARROWGAR_S_ENTRANCE        = 201857,
    GO_ORATORY_OF_THE_DAMNED_ENTRANCE   = 201563,
    GO_LADY_DEATHWHISPER_ELEVATOR       = 202220,
    GO_SAURFANG_S_DOOR                  = 201825,
    GO_DEATHBRINGER_S_CACHE_10N         = 202239,
    GO_DEATHBRINGER_S_CACHE_25N         = 202240,
    GO_DEATHBRINGER_S_CACHE_10H         = 202238,
    GO_DEATHBRINGER_S_CACHE_25H         = 202241,
    GO_SCOURGE_TRANSPORTER_SAURFANG     = 202244,
    GO_ORANGE_PLAGUE_MONSTER_ENTRANCE   = 201371,
    GO_GREEN_PLAGUE_MONSTER_ENTRANCE    = 201370,
    GO_SCIENTIST_AIRLOCK_DOOR_COLLISION = 201612,
    GO_SCIENTIST_AIRLOCK_DOOR_ORANGE    = 201613,
    GO_SCIENTIST_AIRLOCK_DOOR_GREEN     = 201614,
    GO_DOODAD_ICECROWN_ORANGETUBES02    = 201617,
    GO_DOODAD_ICECROWN_GREENTUBES02     = 201618,
    GO_SCIENTIST_ENTRANCE               = 201372,
};

enum eCreatures
{
    NPC_LORD_MARROWGAR              = 36612,
    NPC_BONE_SPIKE                  = 36619,
    NPC_COLD_FLAME                  = 36672,

    NPC_LADY_DEATHWHISPER           = 36855,
    NPC_CULT_FANATIC                = 37890,
    NPC_DEFORMED_FANATIC            = 38135,
    NPC_REANIMATED_FANATIC          = 38009,
    NPC_CULT_ADHERENT               = 37949,
    NPC_EMPOWERED_ADHERENT          = 38136,
    NPC_REANIMATED_ADHERENT         = 38010,
    NPC_VENGEFUL_SHADE              = 38222,

    NPC_DEATHBRINGER_SAURFANG       = 37813,
    NPC_BLOOD_BEAST                 = 38508,
    NPC_SE_JAINA_PROUDMOORE         = 37188,    // SE means Saurfang Event
    NPC_SE_MURADIN_BRONZEBEARD      = 37200,
    NPC_SE_KING_VARIAN_WRYNN        = 37879,
    NPC_SE_HIGH_OVERLORD_SAURFANG   = 37187,
    NPC_SE_KOR_KRON_REAVER          = 37920,
    NPC_SE_SKYBREAKER_MARINE        = 37830,

    NPC_FESTERGUT                   = 36626,
    NPC_GAS_DUMMY                   = 36659,

    CREATURE_SHADE                   = 38222,
    CREATURE_GUNSHIP                 = 30343,
    CREATURE_PUDDLE_STALKER          = 37013,
    CREATURE_ORANGE_GAS_STALKER      = 36659,
    CREATURE_VILE_GAS_STALKER        = 38548,
    CREATURE_ROTFACE                 = 36627,
    CREATURE_OOZE_SPRAY_STALKER      = 37986,
    CREATURE_GREEN_GAS_STALKER       = 37824,
    CREATURE_LITTLE_OOZE             = 36897,
    CREATURE_BIG_OOZE                = 36899,
    CREATURE_STINKY                  = 37025,
    CREATURE_PRECIOUS                = 37217,
    CREATURE_PROFESSOR_PUTRICIDE     = 36678,
    CREATURE_VOLATILE_OOZE           = 37697,
    CREATURE_GAS_CLOUD               = 37562,
    CREATURE_GROWING_OZZE_STALKER    = 38234,
    CREATURE_TEAR_GAS_STALKER        = 38317,
    CREATURE_PRINCE_VALANAR_ICC      = 37970,
    CREATURE_PRINCE_KELESETH_ICC     = 37972,
    CREATURE_PRINCE_TALDARAM_ICC     = 37973,
    CREATURE_BLOOD_QUEEN_LANATHEL    = 37955,
    CREATURE_SWARMING_SHADOWS        = 38163,
    CREATURE_VALITHRIA_DREAMWALKER   = 36789,
    CREATURE_WORM                    = 37907,
    CREATURE_PORTAL                  = 37945,
    CREATURE_CLOUD                   = 37985,
    CREATURE_VOID                    = 38068,
    CREATURE_ABOMINATION             = 37886,
    CREATURE_SKELETON                = 36791,
    CREATURE_ARCHMAGE                = 37868,
    CREATURE_SUPPRESSER              = 37863,
    CREATURE_ZOMBIE                  = 37934,
    CREATURE_COMBAT_TRIGGER          = 38752,
    CREATURE_SINDRAGOSA              = 36853,
    CREATURE_ICE_TOMB                = 36980,
    CREATURE_RIMEFANG                = 37533,
    CREATURE_SPINESTALKER            = 37534,
    CREATURE_LICH_KING               = 36597,
    CREATURE_TIRION_ICC              = 38995,
    CREAUTRE_MENETHIL                = 38579,
    CREATURE_FROSTMOURNE_TRIGGER     = 38584,
    CREATURE_ICE_SPHERE              = 36633,
    CREATURE_VALKYR                  = 36609,
    CREATURE_DEFILE                  = 38757,
    CREATURE_RAGING_SPIRIT           = 36701,
    CREATURE_TRIGGER                 = 30494
};

enum eGameobjects
{
    LORD_ICE_WALL_1                = 201910,
    LORD_ICE_WALL_2                = 201911,
    LORD_ENTRANCE                  = 201857,
    ORATORY_ENTRANCE               = 201563,
    LADY_ELEVATOR                  = 202220,
    SAURFANG_DOOR                  = 201825,
    BLOODWING_DOOR                 = 201920,
    FROSTWING_DOOR                 = 201919,
    CRIMSONHALL_DOOR               = 201376,
    CRIMSONHALL_DOOR_1             = 201377,
    CRIMSONHALL_DOOR_2             = 201378,
    BLOODQUEEN_ELEVATOR            = 201755,
    DRAGON_DOOR_1                  = 201375,
    DRAGON_DOOR_2                  = 201374,
    DRAGON_DOOR_3                  = 201379,
    DREAMWALKER_DOOR_1             = 201380,
    DREAMWALKER_DOOR_2             = 201381,
    DREAMWALKER_DOOR_3             = 201382,
    DREAMWALKER_DOOR_4             = 201383,
    VALITHRIA_ELEVATOR             = 202234,
    SINDRAGOSSA_ELEVATOR           = 196840,
    SINDRAGOSSA_DOOR_1             = 201373,
    SINDRAGOSSA_DOOR_2             = 201369,
    PROF_COLLISION_DOOR            = 201612,
    GREEN_PIPE                     = 201618,
    ORANGE_PIPE                    = 201617,
    OOZE_VALVE                     = 201615,
    GAS_VALVE                      = 201616,
    PROF_DOOR_GREEN                = 201614,
    PROF_DOOR_ORANGE               = 201613,
    ROTFACE_DOOR                   = 201370,
    FESTERGUT_DOOR                 = 201371,
    PROFESSOR_DOOR                 = 201372,
    SAURFANG_CACHE_10_N            = 202238,
    SAURFANG_CACHE_25_N            = 202239,
    SAURFANG_CACHE_10_H            = 202240,
    SAURFANG_CACHE_25_H            = 202241,
    DREAMWALKER_CACHE_10_N         = 201959,
    DREAMWALKER_CACHE_25_N         = 202338,
    DREAMWALKER_CACHE_10_H         = 202339,
    DREAMWALKER_CACHE_25_H         = 202340,
    FIRST_TELEPORT                 = 202242,
    LORD_TELEPORT                  = 202243,
    GUNSHIP_TELEPORT               = 202244,
    SAURFANG_TELEPORT              = 202245,
    CITADEL_TELEPORT               = 202235,
    SINDRAGOSSA_TELEPORT           = 202246,
    LICH_TELEPORT                  = 202223
};

#endif
