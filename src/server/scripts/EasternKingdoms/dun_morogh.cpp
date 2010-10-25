/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Dun_Morogh
SD%Complete: 50
SDComment: Quest support: 1783
SDCategory: Dun Morogh
EndScriptData */

/* ContentData
npc_narm_faulk
EndContentData */

#include "ScriptPCH.h"

/*######
## npc_narm_faulk
######*/

// signed for 6172
enum eNarmFaulkData
{
    SAY_HEAL = -1000187,
};

class npc_narm_faulk : public CreatureScript
{
public:
    npc_narm_faulk() : CreatureScript("npc_narm_faulk") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_narm_faulkAI (pCreature);
    }

    struct npc_narm_faulkAI : public ScriptedAI
    {
        uint32 lifeTimer;
        bool spellHit;

        npc_narm_faulkAI(Creature *c) : ScriptedAI(c) {}

        void Reset()
        {
            lifeTimer = 120000;
            me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            me->SetStandState(UNIT_STAND_STATE_DEAD);
            spellHit = false;
        }

        void EnterCombat(Unit * /*who*/)
        {
        }

        void MoveInLineOfSight(Unit * /*who*/)
        {
            return;
        }

        void UpdateAI(const uint32 diff)
        {
           if (me->IsStandState())
            {
                if (lifeTimer <= diff)
                {
                    EnterEvadeMode();
                    return;
                }
                else
                    lifeTimer -= diff;
            }
        }

        void SpellHit(Unit * /*Hitter*/, const SpellEntry *Spellkind)
        {
            if (Spellkind->Id == 8593 && !spellHit)
            {
                DoCast(me, 32343);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
                //me->RemoveAllAuras();
                DoScriptText(SAY_HEAL, me);
                spellHit = true;
            }
        }

    };

};

void AddSC_dun_morogh()
{
    new npc_narm_faulk();
}
