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
SDName: General Vezax
Author: PrinceCreed - Tasslehoff
SD%Complete: 100%
SDComment:
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603290,
    SAY_SLAY_1                                  = -1603291,
    SAY_SLAY_2                                  = -1603292,
    SAY_KITE                                    = -1603293,
    SAY_DEATH                                   = -1603294,
    SAY_BERSERK                                 = -1603295,
    SAY_HARDMODE_ON                             = -1603296
};

#define EMOTE_VAPORS      "A cloud of saronite vapors coalesces nearby!"
#define EMOTE_ANIMUS      "The saronite vapors mass and swirl violently, merging into a monstrous form!"
#define EMOTE_BARRIER     "A saronite barrier appears around General Vezax!"
#define EMOTE_DARKNESS    "General Vezax roars and surges with dark might!"

enum VezaxSpells
{
    AURA_OF_DESPAIR                             = 62692,
    SPELL_MARK_OF_THE_FACELESS                  = 63276,
    SPELL_SARONITE_BARRIER                      = 63364,
    SPELL_SEARING_FLAMES                        = 62661,
    SPELL_SHADOW_CRASH                          = 62660,
    SPELL_SURGE_OF_DARKNESS                     = 62662,
    SPELL_SARONITE_VAPOR                        = 63323,
    SPELL_PROFOUND_OF_DARKNESS                  = 63420,
    SPELL_CORRUPTED_RAGE                        = 68415,
    SPELL_SHAMANTIC_RAGE                        = 30823,
    SPELL_SUMMON_SARONITE_ANIMUS                = 63145,
    SPELL_VISUAL_SARONITE_ANIMUS                = 63319,
    SPELL_PROFOUND_DARKNESS                     = 63420,
    SPELL_BERSERK                               = 26662,
};

enum Events
{
    EVENT_NONE,
    EVENT_SHADOW_CRASH,
    EVENT_SEARING_FLAMES,
    EVENT_DARKNESS,
    EVENT_MARK,
    EVENT_SARONITE_VAPORS,
    EVENT_BERSERK
};

enum Actions
{
    ACTION_VAPOR_DEAD                           = 0,
    ACTION_ANIMUS_DEAD
};

// Saronite Vapors
enum VezaxNpcs
{
    MOB_SARONITE_VAPORS                         = 33488,
    BOSS_SARONITE_ANIMUS                        = 33524
};
 
#define ACHIEVEMENT_SMELL_SARONITE              RAID_MODE(3181, 3188)
#define ACHIEVEMENT_SHADOWDODGER                RAID_MODE(2996, 2997)

#define VAPORZCOORD 342.378f
// Saronite Vapor Spawn locations
const Position VaporPos[6] =
{
{1883.89f, 125.43f, VAPORZCOORD, 0},
{1845.32f, 122.84f, VAPORZCOORD, 0},
{1788.78f, 121.50f, VAPORZCOORD, 0},
{1814.68f, 125.11f, VAPORZCOORD, 0},
{1843.22f, 155.22f, VAPORZCOORD, 0},
{1817.15f, 95.380f, VAPORZCOORD, 0}
};

class boss_general_vezax : public CreatureScript
{
public:
    boss_general_vezax() : CreatureScript("boss_general_vezax") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_general_vezaxAI(pCreature);
    }

    struct boss_general_vezaxAI : public BossAI
    {
        boss_general_vezaxAI(Creature *pCreature) : BossAI(pCreature, BOSS_VEZAX)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
        }
     
        InstanceScript *pInstance;
        
        int32 VaporsCount;
        bool HardMode, Dodged;

        void Reset()
        {
            _Reset();
            DespawnCreatures(MOB_SARONITE_VAPORS, 100);
            DespawnCreatures(BOSS_SARONITE_ANIMUS, 100);
            me->ResetLootMode();
            VaporsCount = 0;
            HardMode = true;
            Dodged = true;
        }
        
        void KilledUnit(Unit* Victim)
        {
            if (!(rand()%5))
                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }
        
        void SpellHitTarget(Unit * pTarget, const SpellEntry * pSpell)
        {
            if (pSpell->Id == SPELL_SHADOW_CRASH && pTarget->GetTypeId() == TYPEID_PLAYER)
                Dodged = false;
        }

        void EnterCombat(Unit *who)
        {
            _EnterCombat();
            DoScriptText(SAY_AGGRO, me);
            DoCast(me, AURA_OF_DESPAIR);
            events.ScheduleEvent(EVENT_SHADOW_CRASH, 4000);
            events.ScheduleEvent(EVENT_SEARING_FLAMES, 10000);
            events.ScheduleEvent(EVENT_MARK, urand(35000, 40000));
            events.ScheduleEvent(EVENT_SARONITE_VAPORS, 30000);
            events.ScheduleEvent(EVENT_DARKNESS, 60000);
            events.ScheduleEvent(EVENT_BERSERK, 600000);
            
            // This ability affects Shaman with the Shamanistic Rage talent
            std::list<HostileReference*> ThreatList = me->getThreatManager().getThreatList();
            for (std::list<HostileReference*>::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); ++itr)
            {
                Unit *pTarget = Unit::GetUnit(*me, (*itr)->getUnitGuid());
                
                if (pTarget->HasSpell(SPELL_SHAMANTIC_RAGE))
                    DoCast(pTarget, SPELL_CORRUPTED_RAGE);
            }
        }
        
        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_DEATH, me);
            _JustDied();
            
            // Achievements
            if (HardMode)
                pInstance->DoCompleteAchievement(ACHIEVEMENT_SMELL_SARONITE);
            if (Dodged)
                pInstance->DoCompleteAchievement(ACHIEVEMENT_SHADOWDODGER);
        }
        
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            while(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_SHADOW_CRASH:
                        if (Unit *pTarget = SelectUnit(SELECT_TARGET_FARTHEST, 0))
                            if (!pTarget->IsWithinDist(me, 15))
                                DoCast(pTarget, SPELL_SHADOW_CRASH);
                        events.ScheduleEvent(EVENT_SHADOW_CRASH, urand(6000, 10000));
                        break;
                    case EVENT_SEARING_FLAMES:
                        DoCastAOE(SPELL_SEARING_FLAMES);
                        events.ScheduleEvent(EVENT_SEARING_FLAMES, urand(10000,20000));
                        break;
                    case EVENT_DARKNESS:
                        me->MonsterTextEmote(EMOTE_DARKNESS, 0, true);
                        DoScriptText(SAY_KITE, me);
                        DoCast(me, SPELL_SURGE_OF_DARKNESS);
                        events.ScheduleEvent(EVENT_DARKNESS, urand(60000, 70000));
                        break;
                    case EVENT_MARK:
                        if (Unit *pTarget = SelectUnit(SELECT_TARGET_FARTHEST, 0))
                            DoCast(pTarget, SPELL_MARK_OF_THE_FACELESS);
                        events.ScheduleEvent(EVENT_MARK, urand(35000, 40000));
                        break;
                    case EVENT_SARONITE_VAPORS:
                        me->MonsterTextEmote(EMOTE_VAPORS, 0, true);
                        DoSummon(MOB_SARONITE_VAPORS, VaporPos[rand()%6], 3000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                        events.ScheduleEvent(EVENT_SARONITE_VAPORS, 30000);
                        VaporsCount++;
                        if (VaporsCount == 6 && HardMode)
                        {
                            me->MonsterTextEmote(EMOTE_ANIMUS, 0, true);
                            DoScriptText(SAY_HARDMODE_ON, me);
                            me->MonsterTextEmote(EMOTE_BARRIER, 0, true);
                            DoCast(SPELL_SARONITE_BARRIER);
                            DoCast(SPELL_SUMMON_SARONITE_ANIMUS);
                            me->AddLootMode(LOOT_MODE_HARD_MODE_1);
                            DespawnCreatures(MOB_SARONITE_VAPORS, 100);
                            events.CancelEvent(EVENT_SARONITE_VAPORS);
                            events.CancelEvent(EVENT_SEARING_FLAMES);
                        }
                        if (VaporsCount == 8)
                            events.CancelEvent(EVENT_SARONITE_VAPORS);
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        DoScriptText(SAY_BERSERK, me);
                        events.CancelEvent(EVENT_BERSERK);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
        
        void DoAction(const int32 action)
        {
            switch (action)
            {
                case ACTION_VAPOR_DEAD:
                    HardMode = false;
                    break;
                case ACTION_ANIMUS_DEAD:
                    events.ScheduleEvent(EVENT_SEARING_FLAMES, 10000);
            }
        }
        
        void DespawnCreatures(uint32 entry, float distance, bool discs = false)
        {
            std::list<Creature*> m_pCreatures;
            GetCreatureListWithEntryInGrid(m_pCreatures, me, entry, distance);
     
            if (m_pCreatures.empty())
                return;
     
            for(std::list<Creature*>::iterator iter = m_pCreatures.begin(); iter != m_pCreatures.end(); ++iter)
                (*iter)->ForcedDespawn();
        }
    };
};

class mob_saronite_vapors : public CreatureScript
{
public:
    mob_saronite_vapors() : CreatureScript("mob_saronite_vapors") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_saronite_vaporsAI(pCreature);
    }

    struct mob_saronite_vaporsAI : public ScriptedAI
    {
        mob_saronite_vaporsAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->MoveRandom(30.0f);
        }
        
        InstanceScript *pInstance;
     
        void DamageTaken(Unit *who, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                me->RemoveAllAuras();
                me->SetHealth(me->GetMaxHealth());
                me->ForcedDespawn(30000);
                me->GetMotionMaster()->Initialize();
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                DoCast(me, SPELL_SARONITE_VAPOR);
                if (Creature* Vezax = me->GetCreature(*me, pInstance->GetData64(DATA_VEZAX)))
                    Vezax->AI()->DoAction(ACTION_VAPOR_DEAD);
            }
        }
    };
};

class mob_saronite_animus : public CreatureScript
{
public:
    mob_saronite_animus() : CreatureScript("mob_saronite_animus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_saronite_animusAI(pCreature);
    }

    struct mob_saronite_animusAI : public ScriptedAI
    {
        mob_saronite_animusAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
        }
        
        InstanceScript* pInstance;

        uint32 ProfoundDarknessTimer;
        
        void JustDied(Unit * killer)
        {
            if (Creature* Vezax = me->GetCreature(*me, pInstance->GetData64(DATA_VEZAX)))
            {
                Vezax->RemoveAurasDueToSpell(SPELL_SARONITE_BARRIER);
                Vezax->AI()->DoAction(ACTION_ANIMUS_DEAD);
            }
        }

        void EnterCombat(Unit* pWho){}

        void Reset()
        {
            DoCast(SPELL_VISUAL_SARONITE_ANIMUS);
            ProfoundDarknessTimer = 5000;
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;
            
            if (ProfoundDarknessTimer <= diff)
            {
                DoCastAOE(SPELL_PROFOUND_DARKNESS);
                ProfoundDarknessTimer=5000;
            }
            else ProfoundDarknessTimer -= diff;
            
            DoMeleeAttackIfReady();
        }
    };
};
    
void AddSC_boss_general_vezax()
{
    new boss_general_vezax();
    new mob_saronite_vapors();
    new mob_saronite_animus();
}