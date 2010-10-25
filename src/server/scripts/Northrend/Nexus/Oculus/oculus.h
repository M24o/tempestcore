/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
 * Author: Bondiano (Thank you bwsrv Mangos)
 */
 
#ifndef DEF_OCULUS_H
#define DEF_OCULUS_H

enum Data
{
    DATA_DRAKOS_EVENT,
    DATA_VAROS_EVENT,
    DATA_UROM_EVENT,
    DATA_EREGOS_EVENT,
    DATA_CENTRIFUGE_CONSTRUCT_EVENT
};

enum Data64
{
    DATA_DRAKOS,
    DATA_VAROS,
    DATA_UROM,
    DATA_EREGOS
};

enum Bosses
{
    CREATURE_DRAKOS			= 27654,
    CREATURE_VAROS			= 27447,
    CREATURE_UROM			= 27655,
    CREATURE_EREGOS			= 27656, 
    CREATURE_AZURE_GUARDIAN	= 27638,
 
    NPC_VERDISA             = 27657,
    NPC_BELGARISTRASZ       = 27658,
    NPC_ETERNOS             = 27659
};

enum GameObjects
{
	GO_CACHE_OF_ERAGOS	    = 191349,
	GO_CACHE_OF_ERAGOS_H    = 193603,
	GO_DRAGON_CAGE_DOOR     = 193995
};

#endif
