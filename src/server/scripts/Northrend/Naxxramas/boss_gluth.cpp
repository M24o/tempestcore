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

#define SPELL_MORTAL_WOUND      25646
#define SPELL_ENRAGE            RAID_MODE(28371,54427)
#define SPELL_DECIMATE          RAID_MODE(28374,54426)
#define SPELL_BERSERK           26662
#define SPELL_INFECTED_WOUND    29307

#define MOB_ZOMBIE  16360

const Position PosSummon[3] =
{
    {3267.9f, -3172.1f, 297.42f, 0.94f},
    {3253.2f, -3132.3f, 297.42f, 0},
    {3308.3f, -3185.8f, 297.42f, 1.58f},
};

enum Events
{
    EVENT_NONE,
    EVENT_WOUND,
    EVENT_ENRAGE,
    EVENT_DECIMATE,
    EVENT_BERSERK,
    EVENT_SUMMON,
};

#define EMOTE_NEARBY    " spots a nearby zombie to devour!"

class boss_gluth : public CreatureScript
{
public:
    boss_gluth() : CreatureScript("boss_gluth") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_gluthAI (pCreature);
    }

    struct boss_gluthAI : public BossAI
    {
        boss_gluthAI(Creature *c) : BossAI(c, BOSS_GLUTH)
        {
            // Do not let Gluth be affected by zombies' debuff
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_INFECTED_WOUND, true);
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (who->GetEntry() == MOB_ZOMBIE && me->IsWithinDistInMap(who, 7))
            {
                SetGazeOn(who);
                // TODO: use a script text
                me->MonsterTextEmote(EMOTE_NEARBY, 0, true);
            }
            else
                BossAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit * /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_WOUND, 10000);
            events.ScheduleEvent(EVENT_ENRAGE, 15000);
            events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000,90000));
            events.ScheduleEvent(EVENT_BERSERK, RAID_MODE(8*60000,7*60000));
            events.ScheduleEvent(EVENT_SUMMON, 15000);
        }

        void JustSummoned(Creature *summon)
        {
            if (summon->GetEntry() == MOB_ZOMBIE)
            {
                summon->AI()->AttackStart(me);
                summon->CastSpell(summon,SPELL_INFECTED_WOUND,true);
            }

            summons.Summon(summon);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictimWithGaze() || !CheckInRoom())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_WOUND:
                        DoCast(me->getVictim(), SPELL_MORTAL_WOUND);
                        events.ScheduleEvent(EVENT_WOUND, 10000);
                        break;
                    case EVENT_ENRAGE:
                        // TODO : Add missing text
                        DoCast(me, SPELL_ENRAGE);
                        events.ScheduleEvent(EVENT_ENRAGE, 15000);
                        break;
                    case EVENT_DECIMATE:
                        // TODO : Add missing text
                        DoCastAOE(SPELL_DECIMATE);
                        events.ScheduleEvent(EVENT_DECIMATE, RAID_MODE(120000,90000));

                        for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        {
                            Creature *minion = Unit::GetCreature(*me, *itr);
                            if (minion && minion->isAlive() )
                            {
                                //hack
                                int32 damage = int32(minion->GetHealth()) - int32(minion->CountPctFromMaxHealth(5));
                                if (damage > 0)
                                    me->CastCustomSpell(28375, SPELLVALUE_BASE_POINT0, damage, minion, true);

                                if(minion->AI()) //is useless
                                {
                                    minion->GetMotionMaster()->MoveChase(me);
                                    minion->AddThreat(me,9999999);
                                }
                            }
                        }
                        break;
                    case EVENT_BERSERK:
                        if(!me->HasAura(SPELL_BERSERK))
                            DoCast(me, SPELL_BERSERK);
                        events.ScheduleEvent(EVENT_BERSERK, 1*60000);
                        break;
                    case EVENT_SUMMON:
                        for (int32 i = 0; i < RAID_MODE(1, 2); ++i)
                            DoSummon(MOB_ZOMBIE, PosSummon[RAID_MODE(0,rand() % 3)]);
                        events.ScheduleEvent(EVENT_SUMMON, 10000);
                        break;
                }
            }

            if (me->getVictim() && me->getVictim()->GetEntry() == MOB_ZOMBIE)
            {
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    me->Kill(me->getVictim());
                    me->ModifyHealth(int32(me->CountPctFromMaxHealth(5)));
                }
            }
            else
                DoMeleeAttackIfReady();
        }
    };

};


void AddSC_boss_gluth()
{
    new boss_gluth();
}
