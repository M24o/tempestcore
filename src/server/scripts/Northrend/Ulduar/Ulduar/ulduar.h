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

#ifndef DEF_ULDUAR_H
#define DEF_ULDUAR_H

enum eTypes
{
    MAX_ENCOUNTER               = 15,

    TYPE_LEVIATHAN              = 0,
    TYPE_IGNIS                  = 1,
    TYPE_RAZORSCALE             = 2,
    TYPE_XT002                  = 3,
    TYPE_ASSEMBLY               = 4,
    TYPE_KOLOGARN               = 5,
    TYPE_AURIAYA                = 6,
    TYPE_MIMIRON                = 7,
    TYPE_HODIR                  = 8,
    TYPE_THORIM                 = 9,
    TYPE_FREYA                  = 10,
    TYPE_VEZAX                  = 11,
    TYPE_YOGGSARON              = 12,
    TYPE_ALGALON                = 13,
    TYPE_COLOSSUS               = 14,

    DATA_LEVIATHAN              = 15,
    DATA_IGNIS                  = 16,
    DATA_RAZORSCALE             = 17,
    DATA_XT002                  = 18,
    DATA_KOLOGARN               = 19,
    DATA_AURIAYA                = 20,
    DATA_STEELBREAKER           = 21,
    DATA_MOLGEIM                = 22,
    DATA_BRUNDIR                = 23,
    DATA_MIMIRON                = 24,
    DATA_HODIR                  = 25,
    DATA_THORIM                 = 26,
    DATA_FREYA                  = 27,
    DATA_VEZAX                  = 28,
    DATA_YOGGSARON              = 29,
    DATA_ALGALON                = 30,
    DATA_RIGHT_ARM              = 31,
    DATA_LEFT_ARM               = 32,
    DATA_SENTRY_1               = 33,
    DATA_SENTRY_2               = 34,
    DATA_SENTRY_3               = 35,
    DATA_SENTRY_4               = 36,
    DATA_FERAL_DEFENDER         = 37,
	DATA_PRELEVIATHAN           = 38,

    NPC_LEVIATHAN               = 33113,
    NPC_IGNIS                   = 33118,
    NPC_RAZORSCALE              = 33186,
    NPC_XT002                   = 33293,
    NPC_STEELBREAKER            = 32867,
    NPC_MOLGEIM                 = 32927,
    NPC_BRUNDIR                 = 32857,
    NPC_KOLOGARN                = 32930,
    NPC_RIGHT_ARM               = 32934,
    NPC_LEFT_ARM                = 32933,
    NPC_AURIAYA                 = 33515,
    NPC_SANCTUM_SENTRY          = 34014,
    NPC_FERAL_DEFENDER          = 34035,
    NPC_MIMIRON                 = 33350,
    NPC_HODIR                   = 32845,
    NPC_THORIM                  = 32865,
    NPC_FREYA                   = 32906,
    NPC_VEZAX                   = 33271,
    NPC_YOGGSARON               = 33288,
    NPC_ALGALON                 = 32871,

    GO_KOLOGARN_BRIDGE          = 194232,
    GO_KOLOGARN_LOOT            = 195046,
    GO_KOLOGARN_LOOT_H          = 195047,
    GO_LEVIATHAN_GATE           = 194630,

    EVENT_TOWER_OF_STORM_DESTROYED     = 21031,
    EVENT_TOWER_OF_FROST_DESTROYED     = 21032,
    EVENT_TOWER_OF_FLAMES_DESTROYED    = 21033,
    EVENT_TOWER_OF_LIFE_DESTROYED      = 21030
};

enum Data64
{
	DATA_BRIGHTLEAF,
    DATA_NORGANNON,
    DATA_IRONBRANCH,
    DATA_STONEBARK,
	DATA_LEVIATHAN_MK_II,
    DATA_VX_001,
    DATA_AERIAL_UNIT,
	DATA_RUNIC_COLOSSUS,
    DATA_RUNE_GIANT,
    DATA_YS_FREYA,
    DATA_YS_THORIM,
    DATA_YS_MIMIRON,
    DATA_YS_HODIR,
    DATA_MAGNETIC_CORE,
	DATA_EXP_COMMANDER,
};

enum Data
{
    DATA_LEVIATHAN_DOOR,
    DATA_RUNIC_DOOR,
    DATA_STONE_DOOR,
    DATA_CALL_TRAM,
    DATA_MIMIRON_ELEVATOR,
    DATA_HODIR_RARE_CHEST
};

enum Encounter
{
	BOSS_LEVIATHAN,
	BOSS_AURIAYA,
	BOSS_VEZAX,
	BOSS_RAZORSCALE,
	BOSS_ASSEMBLY,

    BOSS_IGNIS,
    BOSS_XT002,
    
    BOSS_KOLOGARN,

    BOSS_MIMIRON,
    BOSS_HODIR,
    BOSS_THORIM,
   
	BOSS_FREYA,
    BOSS_YOGGSARON,
    BOSS_ALGALON,
    MAX_BOSS_NUMBER
};
#endif
