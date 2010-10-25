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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* ScriptData
SDName: Ignis the Furnace Master
SDAuthor: PrinceCreed
SD%Complete: 100
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603220,
    SAY_SLAY_1                                  = -1603221,
    SAY_SLAY_2                                  = -1603222,
    SAY_DEATH                                   = -1603223,
    SAY_SUMMON                                  = -1603224,
    SAY_SLAG_POT                                = -1603225,
    SAY_SCORCH_1                                = -1603226,
    SAY_SCORCH_2                                = -1603227,
    SAY_BERSERK                                 = -1603228,
};

enum Spells
{
    SPELL_FLAME_JETS_10                         = 62680,
    SPELL_FLAME_JETS_25                         = 63472,
    SPELL_SCORCH_10                             = 62546,
    SPELL_SCORCH_25                             = 63474,
    SPELL_SLAG_POT_10                           = 62717,
    SPELL_SLAG_POT_25                           = 63477,
    SPELL_SLAG_IMBUED_10                        = 62836,
    SPELL_SLAG_IMBUED_25                        = 63536,
    SPELL_ACTIVATE_CONSTRUCT                    = 62488,
    SPELL_STRENGHT                              = 64473,
    SPELL_GRAB                                  = 62707,
    SPELL_BERSERK                               = 47008
};

enum Events
{
    EVENT_NONE,
    EVENT_JET,
    EVENT_SCORCH,
    EVENT_SLAG_POT,
    EVENT_GRAB_POT,
    EVENT_CHANGE_POT,
    EVENT_END_POT,
    EVENT_CONSTRUCT,
    EVENT_BERSERK
};

#define EMOTE_JETS              "Ignis the Furnace Master begins to cast Flame Jets!"

enum Mobs
{
    MOB_IRON_CONSTRUCT                          = 33121,
    GROUND_SCORCH                               = 33221
};

#define ACTION_REMOVE_BUFF                      20

enum ConstructSpells
{
    SPELL_HEAT                                  = 65667,
    SPELL_MOLTEN                                = 62373,
    SPELL_BRITTLE                               = 62382,
    SPELL_SHATTER                               = 62383,
    SPELL_GROUND_10                             = 62548,
    SPELL_GROUND_25                             = 63476,
    SPELL_FROZEN_POSITION                       = 69609
};

// Achievements
#define ACHIEVEMENT_STOKIN_THE_FURNACE          RAID_MODE(2930, 2929)
#define ACHIEVEMENT_SHATTERED                   RAID_MODE(2925, 2926)
#define MAX_ENCOUNTER_TIME                      4 * 60 * 1000

// Water coords
#define WATER_1_X                               646.77f
#define WATER_2_X                               526.77f
#define WATER_Y                                 277.79f
#define WATER_Z                                 359.88f

const Position Pos[20] =
{
{630.366f, 216.772f, 360.891f, M_PI},
{630.594f, 231.846f, 360.891f, M_PI},
{630.435f, 337.246f, 360.886f, M_PI},
{630.493f, 313.349f, 360.886f, M_PI},
{630.444f, 321.406f, 360.886f, M_PI},
{630.366f, 247.307f, 360.888f, M_PI},
{630.698f, 305.311f, 360.886f, M_PI},
{630.500f, 224.559f, 360.891f, M_PI},
{630.668f, 239.840f, 360.890f, M_PI},
{630.384f, 329.585f, 360.886f, M_PI},
{543.220f, 313.451f, 360.886f, 0},
{543.356f, 329.408f, 360.886f, 0},
{543.076f, 247.458f, 360.888f, 0},
{543.117f, 232.082f, 360.891f, 0},
{543.161f, 305.956f, 360.886f, 0},
{543.277f, 321.482f, 360.886f, 0},
{543.316f, 337.468f, 360.886f, 0},
{543.280f, 239.674f, 360.890f, 0},
{543.265f, 217.147f, 360.891f, 0},
{543.256f, 224.831f, 360.891f, 0}
};

class boss_ignis : public CreatureScript
{
public:
    boss_ignis() : CreatureScript("boss_ignis") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ignis_AI(pCreature);
    }

    struct boss_ignis_AI : public BossAI
    {
        boss_ignis_AI(Creature *pCreature) : BossAI(pCreature, BOSS_IGNIS), vehicle(me->GetVehicleKit())
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true);  // Death Grip
        }

        Vehicle *vehicle;
        InstanceScript *pInstance;
        std::vector<Creature *> construct_list;
        
        uint64 SlagPotGUID;
        uint64 EncounterTime;
        uint64 ConstructTimer;
        bool Shattered;

        void Reset()
        {
            _Reset();
            
            construct_list.clear();
            
            if (vehicle)
                vehicle->RemoveAllPassengers();
                
            for (uint8 n = 0; n < 20; n++)
                me->SummonCreature(MOB_IRON_CONSTRUCT, Pos[n], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
        }

        void EnterCombat(Unit *who)
        {
            _EnterCombat();
            DoScriptText(SAY_AGGRO, me);
            events.ScheduleEvent(EVENT_JET, 30000);
            events.ScheduleEvent(EVENT_SCORCH, 25000);
            events.ScheduleEvent(EVENT_SLAG_POT, 35000);
            events.ScheduleEvent(EVENT_CONSTRUCT, 15000);
            events.ScheduleEvent(EVENT_END_POT, 40000);
            events.ScheduleEvent(EVENT_BERSERK, 480000);
            SlagPotGUID = 0;
            EncounterTime = 0;
            ConstructTimer = 0;
            Shattered = false;
        }

        void JustDied(Unit *victim)
        {
            _JustDied();
            DoScriptText(SAY_DEATH, me);

            // Achievements
            if (pInstance)
            {
                // Shattered
                if (Shattered)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_SHATTERED);
                // Stokin' the Furnace
                if (EncounterTime <= MAX_ENCOUNTER_TIME)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_STOKIN_THE_FURNACE);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->GetPositionY() < 150 || me->GetPositionX() < 450 || me->getVictim()->GetTypeId() == !TYPEID_PLAYER)
            {
                me->RemoveAllAuras();
                me->DeleteThreatList();
                me->CombatStop(false);
                me->GetMotionMaster()->MoveTargetedHome();
            }

            events.Update(diff);
            EncounterTime += diff;
            ConstructTimer += diff;

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            while(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_JET:
                        me->MonsterTextEmote(EMOTE_JETS, 0, true);
                        DoCastAOE(RAID_MODE(SPELL_FLAME_JETS_10, SPELL_FLAME_JETS_25));
                        events.ScheduleEvent(EVENT_JET, urand(35000,40000));
                        break;
                    case EVENT_SLAG_POT:
                        if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                        {
                            DoScriptText(SAY_SLAG_POT, me);
                            SlagPotGUID = pTarget->GetGUID();
                            DoCast(pTarget, SPELL_GRAB);
                            events.DelayEvents(3000);
                            events.ScheduleEvent(EVENT_GRAB_POT, 500);
                        }
                        events.ScheduleEvent(EVENT_SLAG_POT, RAID_MODE(30000, 15000));
                        break;
                    case EVENT_GRAB_POT:
                        if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                        {
                            SlagPotTarget->EnterVehicle(me, 0);
                            events.CancelEvent(EVENT_GRAB_POT);
                            events.ScheduleEvent(EVENT_CHANGE_POT, 1000);
                        }
                        break;
                    case EVENT_CHANGE_POT:
                        if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                        {
                            SlagPotTarget->AddAura(RAID_MODE(SPELL_SLAG_POT_10, SPELL_SLAG_POT_25), SlagPotTarget);
                            SlagPotTarget->EnterVehicle(me, 1);
                            events.CancelEvent(EVENT_CHANGE_POT);
                            events.ScheduleEvent(EVENT_END_POT, 10000);
                        }
                        break;
                    case EVENT_END_POT:
                        if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                        {
                            SlagPotTarget->ExitVehicle();
                            SlagPotTarget->CastSpell(SlagPotTarget, RAID_MODE(SPELL_SLAG_IMBUED_10, SPELL_SLAG_IMBUED_25), true);
                            events.CancelEvent(EVENT_END_POT);
                        }
                        break;
                    case EVENT_SCORCH:
                        DoScriptText(RAND(SAY_SCORCH_1, SAY_SCORCH_2), me);
                        if (Unit *pTarget = me->getVictim())
                            me->SummonCreature(GROUND_SCORCH, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 45000);
                        DoCast(RAID_MODE(SPELL_SCORCH_10, SPELL_SCORCH_25));
                        events.ScheduleEvent(EVENT_SCORCH, 25000);
                        break;
                    case EVENT_CONSTRUCT:
                        if (!construct_list.empty())
                        {
                            std::vector<Creature*>::iterator itr = (construct_list.begin()+rand()%construct_list.size());
                            Creature* pTarget = *itr;
                            if (pTarget)
                            {
                                DoScriptText(SAY_SUMMON, me);
                                DoCast(me, SPELL_STRENGHT, true);
                                DoCast(SPELL_ACTIVATE_CONSTRUCT);
                                pTarget->setFaction(16);
                                pTarget->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                                construct_list.erase(itr);
                            }
                        }
                        events.ScheduleEvent(EVENT_CONSTRUCT, RAID_MODE(40000, 30000));
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        DoScriptText(SAY_BERSERK, me);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void KilledUnit(Unit* Victim)
        {
            if (!(rand()%5))
                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void JustSummoned(Creature *summon)
        {
            if (summon->GetEntry() == MOB_IRON_CONSTRUCT)
            {
                construct_list.push_back(summon);
            }

            summons.Summon(summon);
        }

        void DoAction(const int32 action)
        {
            switch(action)
            {
                case ACTION_REMOVE_BUFF:
                    me->RemoveAuraFromStack(SPELL_STRENGHT);
                    // Shattered Achievement
                    if (ConstructTimer >= 5000)
                        ConstructTimer = 0;
                    else Shattered = true;
                    break;
            }
        }
    };
};

class mob_iron_construct : public CreatureScript
{
public:
    mob_iron_construct() : CreatureScript("mob_iron_construct") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_iron_constructAI(pCreature);
    }

    struct mob_iron_constructAI : public ScriptedAI
    {
        mob_iron_constructAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->AddAura(SPELL_FROZEN_POSITION, me);
        }

        InstanceScript* pInstance;

        bool Brittled;

        void Reset()
        {
            Brittled = false;
        }

        void DamageTaken(Unit *attacker, uint32 &damage)
        {
            if (me->HasAura(SPELL_BRITTLE) && damage >= 5000)
            {
                DoCastAOE(SPELL_SHATTER, true);
                if (Creature *pIgnis = me->GetCreature(*me, pInstance->GetData64(DATA_IGNIS)))
                    if (pIgnis->AI())
                        pIgnis->AI()->DoAction(ACTION_REMOVE_BUFF);
                        
                me->ForcedDespawn(1000);
            }
        }
        
        void SpellHit(Unit* caster, const SpellEntry *spell)
        {
            if (spell->Id == SPELL_ACTIVATE_CONSTRUCT && me->HasReactState(REACT_PASSIVE))
            {
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                me->RemoveAurasDueToSpell(SPELL_FROZEN_POSITION);
                me->AI()->AttackStart(caster->getVictim());
                me->AI()->DoZoneInCombat();
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            Map *cMap = me->GetMap();

            if (me->HasAura(SPELL_MOLTEN) && me->HasAura(SPELL_HEAT))
                me->RemoveAura(SPELL_HEAT);

            if (Aura * aur = me->GetAura((SPELL_HEAT), GetGUID()))
            {
                if (aur->GetStackAmount() >= 10)
                {
                    me->RemoveAura(SPELL_HEAT);
                    DoCast(me, SPELL_MOLTEN, true);
                    Brittled = false;
                }
            }

            // Water pools
            if(cMap->GetId() == 603 && !Brittled && me->HasAura(SPELL_MOLTEN))
                if (me->GetDistance(WATER_1_X, WATER_Y, WATER_Z) <= 18 || me->GetDistance(WATER_2_X, WATER_Y, WATER_Z) <= 18)
                {
                    me->AddAura(SPELL_BRITTLE, me);
                    me->RemoveAura(SPELL_MOLTEN);
                    Brittled = true;
                }

            DoMeleeAttackIfReady();
        }
    };
};

class mob_scorch_ground : public CreatureScript
{
public:
    mob_scorch_ground() : CreatureScript("mob_scorch_ground") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_scorch_groundAI(pCreature);
    }

    struct mob_scorch_groundAI : public ScriptedAI
    {
        mob_scorch_groundAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
        }

        void Reset()
        {
            DoCast(me, RAID_MODE(SPELL_GROUND_10, SPELL_GROUND_25));
        }
    };

};

void AddSC_boss_ignis()
{
    new boss_ignis();
    new mob_iron_construct();
    new mob_scorch_ground();
};
