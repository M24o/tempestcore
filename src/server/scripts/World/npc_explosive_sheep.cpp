/*
 * Copyright (C) 2010 TempestCore <http://github.com/M24o/tempestcore/>
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

/*
 * Author: Vaenyr <vaenyr@gmail.com>
 *
 * SQL: UPDATE creature_template SET ScriptName="npc_explosive_sheep" WHERE entry=2675;
 */

#include "ScriptPCH.h"

class explosive_sheep : public CreatureScript
{
public:
    explosive_sheep() : CreatureScript("npc_explosive_sheep") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_explosive_sheep(creature);
    }

    struct npc_explosive_sheep : public ScriptedAI
    {
        npc_explosive_sheep(Creature* creature) : ScriptedAI(creature)
        {
            target_selected = false;
            timer = 0;
            target = 0;
        }

        bool target_selected;
        uint64 target;
        uint32 timer;

        void UpdateAI(const uint32 diff)
        {
            timer += diff;
            if (timer >= 60000) //3 minutes
                me->ForcedDespawn();
            else if(target_selected)
            {
                if (Unit* ptarget = me->GetUnit((*me), target))
                {
                    if (me->GetDistance2d(ptarget) <= 1.0f)
                        DoCast(4050, ptarget);
                    else
                        me->GetMotionMaster()->MoveChase(ptarget);
                }
                else
                    me->ForcedDespawn();
            }
            else
            {
                if (Unit* owner = me->GetOwner())
                {
                    if (owner->getVictim())
                    {
                        target = owner->getVictim()->GetGUID();
                        target_selected = true;
                    }
                    else
                        me->GetMotionMaster()->MoveFollow(owner, 2.0f, me->GetAngle(owner));
                }
                else
                    me->ForcedDespawn();
            }
        }
    };
};
