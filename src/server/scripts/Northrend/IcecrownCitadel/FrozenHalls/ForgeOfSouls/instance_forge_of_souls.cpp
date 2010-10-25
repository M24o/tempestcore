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
 */

#include "ScriptPCH.h"
#include "forge_of_souls.h"

#define MAX_ENCOUNTER 2

/* Forge of Souls encounters:
0- Bronjahm, The Godfather of Souls
1- The Devourer of Souls
*/

class instance_forge_of_souls : public InstanceMapScript
{
public:
    instance_forge_of_souls() : InstanceMapScript("instance_forge_of_souls", 632) { }

    struct instance_forge_of_souls_InstanceScript : public InstanceScript
    {
        instance_forge_of_souls_InstanceScript(Map* pMap) : InstanceScript(pMap) {};

        uint64 uiBronjahm;
        uint64 uiDevourer;

        uint32 uiEncounter[MAX_ENCOUNTER];
        uint32 uiTeamInInstance;

        void Initialize()
        {
            uiBronjahm = 0;
            uiDevourer = 0;

            uiTeamInInstance = 0;

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                uiEncounter[i] = NOT_STARTED;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (uiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnCreatureCreate(Creature* pCreature, bool /*add*/)
        {
            Map::PlayerList const &players = instance->GetPlayers();

            if (!players.isEmpty())
                if (Player* pPlayer = players.begin()->getSource())
                    uiTeamInInstance = pPlayer->GetTeamId();

            switch(pCreature->GetEntry())
            {
                case CREATURE_BRONJAHM:
                    uiBronjahm = pCreature->GetGUID();
                    break;
                case CREATURE_DEVOURER:
                    uiDevourer = pCreature->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_BRONJAHM_EVENT:
                    uiEncounter[0] = data;
                    break;
                case DATA_DEVOURER_EVENT:
                    uiEncounter[1] = data;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
                case DATA_BRONJAHM_EVENT:    return uiEncounter[0];
                case DATA_DEVOURER_EVENT:    return uiEncounter[1];
                case DATA_TEAM_IN_INSTANCE:  return uiTeamInInstance;
            }

            return 0;
        }

        uint64 GetData64(uint32 identifier)
        {
            switch(identifier)
            {
                case DATA_BRONJAHM:         return uiBronjahm;
                case DATA_DEVOURER:         return uiBronjahm;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "F S " << uiEncounter[0] << " " << uiEncounter[1];

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
            uint16 data0, data1;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1;

            if (dataHead1 == 'F' && dataHead2 == 'S')
            {
                uiEncounter[0] = data0;
                uiEncounter[1] = data1;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (uiEncounter[i] == IN_PROGRESS)
                        uiEncounter[i] = NOT_STARTED;

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap *map) const
    {
        return new instance_forge_of_souls_InstanceScript(map);
    }
};

void AddSC_instance_forge_of_souls()
{
    new instance_forge_of_souls();
}
