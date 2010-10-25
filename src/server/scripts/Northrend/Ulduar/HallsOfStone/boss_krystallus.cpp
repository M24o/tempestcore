/* 
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2010 Lol Core <http://hg.assembla.com/LoL_Trinity/>
 *
 * Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
 * Script Author: LordVanMartin
 */
 
#include "ScriptPCH.h"
#include "halls_of_stone.h"

enum Spells
{
    SPELL_BOULDER_TOSS                             = 50843,
    H_SPELL_BOULDER_TOSS                           = 59742,
    SPELL_GROUND_SPIKE                             = 59750,
    SPELL_GROUND_SLAM                              = 50827,
    SPELL_GROUND_SLAM_TRIGGERED                    = 50833,
    SPELL_SHATTER                                  = 50810,
    H_SPELL_SHATTER                                = 61546,
    SPELL_SHATTER_EFFECT                           = 50811,
    H_SPELL_SHATTER_EFFECT                         = 61547,
    SPELL_STONED                                   = 50812,
    SPELL_STOMP                                    = 48131,
    H_SPELL_STOMP                                  = 59744
};

enum Yells
{
    SAY_AGGRO                                   = -1599007,
    SAY_KILL                                    = -1599008,
    SAY_DEATH                                   = -1599009,
    SAY_SHATTER                                 = -1599010
};

class boss_krystallus : public CreatureScript
{
public:
    boss_krystallus() : CreatureScript("boss_krystallus") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_krystallusAI (pCreature);
    }

    struct boss_krystallusAI : public ScriptedAI
    {
        boss_krystallusAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();

            //temporary to let ground slam effect not be interrupted
            SpellEntry *TempSpell;
            TempSpell = GET_SPELL(SPELL_GROUND_SLAM_TRIGGERED);
            if (TempSpell)
            { 
                TempSpell->InterruptFlags = 0;
            }
        }

        uint32 uiBoulderTossTimer;
        uint32 uiGroundSpikeTimer;
        uint32 uiGroundSlamTimer;
        uint32 uiStompTimer;

        bool bIsSlam;

        InstanceScript* pInstance;

        void Reset()
        {
            bIsSlam = false;

            uiBoulderTossTimer = 3000 + rand()%6000;
            uiGroundSpikeTimer = 6000 + rand()%5000;
            uiGroundSlamTimer = 20000 + rand()%3000;
            uiStompTimer = 15000 + rand()%5000;

            if (pInstance)
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);

            if (pInstance)
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, IN_PROGRESS);
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (bIsSlam)
            {
                if (uiGroundSlamTimer <= diff)
                {
                    uiGroundSlamTimer = 15000 + rand()%5000;
                    DoCast(me, DUNGEON_MODE(SPELL_SHATTER, H_SPELL_SHATTER));
                } 
                else uiGroundSlamTimer -= diff;
            }
            else
            {
                if (IsHeroic())
                {
                    if (uiGroundSpikeTimer <= diff)
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(pTarget, SPELL_GROUND_SPIKE);
                        uiGroundSpikeTimer = 7000 + rand()%5000;
                    } 
                    else uiGroundSpikeTimer -= diff;
                }

                if (uiBoulderTossTimer <= diff)
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(pTarget, SPELL_BOULDER_TOSS);
                    uiBoulderTossTimer = 9000 + rand()%6000;
                } 
                else uiBoulderTossTimer -= diff;

                if (uiStompTimer <= diff)
                {
                    DoCast(me, SPELL_STOMP);
                    uiStompTimer = 12000 + rand()%6000;
                } 
                else uiStompTimer -= diff;

                if (uiGroundSlamTimer <= diff)
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();

                    bIsSlam = true;
                    uiGroundSlamTimer = 10000;

                    DoCast(me, SPELL_GROUND_SLAM, true); //TODO: let cast not be interrupted
                } 
                else uiGroundSlamTimer -= diff;

                DoMeleeAttackIfReady();
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(DATA_KRYSTALLUS_EVENT, DONE);
        }

        void KilledUnit(Unit * victim)
        {
            if (victim == me)
                return;
            DoScriptText(SAY_KILL, me);
        }

        void SpellHitTarget(Unit* pTarget, const SpellEntry* pSpell)
        {
            //this part should be in the core
            if (pSpell->Id == SPELL_SHATTER || pSpell->Id == H_SPELL_SHATTER)
            {
                //this spell must have custom handling in the core, dealing damage based on distance
                pTarget->CastSpell(pTarget, DUNGEON_MODE(SPELL_SHATTER_EFFECT, H_SPELL_SHATTER_EFFECT), true);

                if (pTarget->HasAura(SPELL_STONED))
                    pTarget->RemoveAurasDueToSpell(SPELL_STONED);

                //clear this, if we are still performing
                if (bIsSlam)
                {
                    bIsSlam = false;

                    //and correct movement, if not already
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != TARGETED_MOTION_TYPE)
                    {
                        if (me->getVictim())
                            me->GetMotionMaster()->MoveChase(me->getVictim());
                    }
                }
            }
        }
    };

};


void AddSC_boss_krystallus()
{
    new boss_krystallus();
}
