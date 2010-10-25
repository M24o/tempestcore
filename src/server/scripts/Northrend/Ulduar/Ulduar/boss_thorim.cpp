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
SDName: Thorim
SDAuthor: PrinceCreed
SD%Complete: 90
SDComments: Lightning Charge not works.
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

// Thorim Spells
enum Spells
{
    SPELL_SHEAT_OF_LIGHTNING                    = 62276,
    SPELL_STORMHAMMER                           = 62042,
    SPELL_DEAFENING_THUNDER                     = 62470,
    SPELL_CHARGE_ORB                            = 62016,
    SPELL_SUMMON_LIGHTNING_ORB                  = 62391,
    SPELL_TOUCH_OF_DOMINION                     = 62565,
    SPELL_CHAIN_LIGHTNING_10                    = 62131,
    SPELL_CHAIN_LIGHTNING_25                    = 64390,
    SPELL_LIGHTNING_CHARGE                      = 62279,
    SPELL_LIGHTNING_RELEASE                     = 62466,
    SPELL_UNBALANCING_STRIKE                    = 62130,
    SPELL_BERSERK                               = 62560
};

enum Phases
{
    PHASE_NULL = 0,
    PHASE_1,
    PHASE_2
};

enum Events
{
    EVENT_NONE,
    EVENT_STORMHAMMER,
    EVENT_CHARGE_ORB,
    EVENT_SUMMON_ADDS,
    EVENT_BERSERK,
    EVENT_UNBALANCING_STRIKE,
    EVENT_CHAIN_LIGHTNING,
    EVENT_TRANSFER_ENERGY,
    EVENT_RELEASE_ENERGY
};

enum Yells
{
    SAY_AGGRO_1                                 = -1603270,
    SAY_AGGRO_2                                 = -1603271,
    SAY_SPECIAL_1                               = -1603272,
    SAY_SPECIAL_2                               = -1603273,
    SAY_SPECIAL_3                               = -1603274,
    SAY_JUMPDOWN                                = -1603275,
    SAY_SLAY_1                                  = -1603276,
    SAY_SLAY_2                                  = -1603277,
    SAY_BERSERK                                 = -1603278,
    SAY_WIPE                                    = -1603279,
    SAY_DEATH                                   = -1603280,
    SAY_END_NORMAL_1                            = -1603281,
    SAY_END_NORMAL_2                            = -1603282,
    SAY_END_NORMAL_3                            = -1603283,
    SAY_END_HARD_1                              = -1603284,
    SAY_END_HARD_2                              = -1603285,
    SAY_END_HARD_3                              = -1603286,
    SAY_YS_HELP                                 = -1603287
};

#define EMOTE_BARRIER      "Runic Colossus surrounds itself with a crackling Runic Barrier!"
#define EMOTE_MIGHT        "Ancient Rune Giant fortifies nearby allies with runic might!"

// Thorim Pre-Phase Adds
enum PreAdds
{
    BEHEMOTH,
    MERCENARY_CAPTAIN_A,
    MERCENARY_SOLDIER_A,
    DARK_RUNE_ACOLYTE,
    MERCENARY_CAPTAIN_H,
    MERCENARY_SOLDIER_H
};

const uint32 PRE_PHASE_ADD[]          = {32882, 32908, 32885, 33110, 32907, 32883};
#define SPELL_PRE_PRIMARY(i)            RAID_MODE(SPELL_PRE_PRIMARY_N[i],SPELL_PRE_PRIMARY_H[i])
const uint32 SPELL_PRE_PRIMARY_N[]    = {62315, 62317, 62318, 62333, 62317, 62318};
const uint32 SPELL_PRE_PRIMARY_H[]    = {62415, 62317, 62318, 62441, 62317, 62318};
#define SPELL_PRE_SECONDARY(i)          RAID_MODE(SPELL_PRE_SECONDARY_N[i],SPELL_PRE_SECONDARY_H[i])
const uint32 SPELL_PRE_SECONDARY_N[]  = {62316, 62444, 16496, 62334, 62444, 62318};
const uint32 SPELL_PRE_SECONDARY_H[]  = {62417, 62444, 16496, 62442, 62444, 62318};
#define SPELL_HOLY_SMITE                RAID_MODE(62335, 62443)

#define INCREASE_PREADDS_COUNT                     1
#define ACTION_CHANGE_PHASE                        2
#define MAX_HARD_MODE_TIME                         180000 // 3 Minutes

// Achievements
#define ACHIEVEMENT_SIFFED              RAID_MODE(2977, 2978)
#define ACHIEVEMENT_LOSE_ILLUSION       RAID_MODE(3176, 3183)

// Thorim Arena Phase Adds
enum ArenaAdds
{
    DARK_RUNE_CHAMPION,
    DARK_RUNE_COMMONER,
    DARK_RUNE_EVOKER,
    DARK_RUNE_WARBRINGER,
    IRON_RING_GUARD,
    IRON_HONOR_GUARD
};

const uint32 ARENA_PHASE_ADD[]          = {32876, 32904, 32878, 32877, 32874, 32875};
#define SPELL_ARENA_PRIMARY(i)            RAID_MODE(SPELL_ARENA_PRIMARY_N[i],SPELL_ARENA_PRIMARY_H[i])
const uint32 SPELL_ARENA_PRIMARY_N[]    = {35054, 62326, 62327, 62322, 64151, 42724};
const uint32 SPELL_ARENA_PRIMARY_H[]    = {35054, 62326, 62445, 62322, 64151, 42724};
#define SPELL_ARENA_SECONDARY(i)          RAID_MODE(SPELL_ARENA_SECONDARY_N[i],SPELL_ARENA_SECONDARY_H[i])
const uint32 SPELL_ARENA_SECONDARY_N[]  = {15578, 38313, 62321, 0, 62331, 62332};
const uint32 SPELL_ARENA_SECONDARY_H[]  = {15578, 38313, 62529, 0, 62418, 62420};
#define SPELL_AURA_OF_CELERITY            62320
#define SPELL_CHARGE                      32323
#define SPELL_RUNIC_MENDING               RAID_MODE(62328, 62446)

// Runic Colossus (Mini Boss) Spells
enum RunicSpells
{
    SPELL_SMASH                                 = 62339,
    SPELL_RUNIC_BARRIER                         = 62338,
    SPELL_CHARGE_10                             = 62613,
    SPELL_CHARGE_25                             = 62614
};

// Ancient Rune Giant (Mini Boss) Spells
enum AncientSpells
{
    SPELL_RUNIC_FORTIFICATION                   = 62942,
    SPELL_RUNE_DETONATION                       = 62526,
    SPELL_STOMP_10                              = 62411,
    SPELL_STOMP_25                              = 62413
};

// Sif Spells
enum SifSpells
{
    SPELL_FROSTBOLT_VOLLEY_10                   = 62580,
    SPELL_FROSTBOLT_VOLLEY_25                   = 62604,
    SPELL_FROSTNOVA_10                          = 62597,
    SPELL_FROSTNOVA_25                          = 62605,
    SPELL_BLIZZARD_10                           = 62577,
    SPELL_BLIZZARD_25                           = 62603
};

enum ThorimChests
{
    CACHE_OF_STORMS_10                          = 194312,
    CACHE_OF_STORMS_HARDMODE_10                 = 194313,
    CACHE_OF_STORMS_25                          = 194314,
    CACHE_OF_STORMS_HARDMODE_25                 = 194315
};

const Position Pos[7] =
{
{2095.53f, -279.48f, 419.84f, 0.504f},
{2092.93f, -252.96f, 419.84f, 6.024f},
{2097.86f, -240.97f, 419.84f, 5.643f},
{2113.14f, -225.94f, 419.84f, 5.259f},
{2156.87f, -226.12f, 419.84f, 4.202f},
{2172.42f, -242.70f, 419.84f, 3.583f},
{2171.92f, -284.59f, 419.84f, 2.691f}
};

const Position PosOrbs[7] =
{
{2104.99f, -233.484f, 433.576f, 5.49779f},
{2092.64f, -262.594f, 433.576f, 6.26573f},
{2104.76f, -292.719f, 433.576f, 0.78539f},
{2164.97f, -293.375f, 433.576f, 2.35619f},
{2164.58f, -233.333f, 433.576f, 3.90954f},
{2145.81f, -222.196f, 433.576f, 4.45059f},
{2123.91f, -222.443f, 433.576f, 4.97419f}
};

const Position PosCharge[7] =
{
{2104.99f, -233.484f, 419.573f, 5.49779f},
{2092.64f, -262.594f, 419.573f, 6.26573f},
{2104.76f, -292.719f, 419.573f, 0.78539f},
{2164.97f, -293.375f, 419.573f, 2.35619f},
{2164.58f, -233.333f, 419.573f, 3.90954f},
{2145.81f, -222.196f, 419.573f, 4.45059f},
{2123.91f, -222.443f, 419.573f, 4.97419f}
};

#define POS_X_ARENA  2181.19f
#define POS_Y_ARENA  -299.12f

#define IN_ARENA(who) (who->GetPositionX() < POS_X_ARENA && who->GetPositionY() > POS_Y_ARENA)

class boss_thorim : public CreatureScript
{
public:
    boss_thorim() : CreatureScript("boss_thorim") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_thorimAI (pCreature);
    }

    struct boss_thorimAI : public BossAI
    {
        boss_thorimAI(Creature* pCreature) : BossAI(pCreature, BOSS_THORIM)
            , phase(PHASE_NULL)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
            FirstTime = true;
        }
        
        InstanceScript* pInstance;
        Phases phase;
        int32 PreAddsCount;
        uint8 spawnedAdds;
        uint32 EncounterTime;
        bool FirstTime;
        bool HardMode;
        Creature *EnergySource;

        void Reset()
        {
            if (!FirstTime)
                DoScriptText(SAY_WIPE, me);
                
            _Reset();
            
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE);
            FirstTime = true;
            HardMode = false;
            PreAddsCount = 0;
            spawnedAdds = 0;
            
            // Respawn Mini Bosses
            if (Creature* pRunicColossus = Unit::GetCreature(*me, pInstance->GetData64(DATA_RUNIC_COLOSSUS)))
                pRunicColossus->Respawn(true);
            if (Creature* pRuneGiant = Unit::GetCreature(*me, pInstance->GetData64(DATA_RUNE_GIANT)))
                pRuneGiant->Respawn(true);
            
            // Spawn Thorim Phase Trigger
            me->SummonCreature(32892, 2135.04f, -310.787f, 438.23f, 0, TEMPSUMMON_MANUAL_DESPAWN);
                    
            // Spawn Pre-Phase Adds
            me->SummonCreature(PRE_PHASE_ADD[0], 2134.79f, -263.03f, 419.84f, 5.377f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(PRE_PHASE_ADD[1], 2141.60f, -271.64f, 419.84f, 2.188f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(PRE_PHASE_ADD[2], 2127.24f, -251.31f, 419.84f, 5.89f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(PRE_PHASE_ADD[2], 2123.32f, -254.77f, 419.84f, 6.17f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(PRE_PHASE_ADD[2], 2120.10f, -258.99f, 419.84f, 6.25f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(PRE_PHASE_ADD[3], 2130.28f, -274.60f, 419.84f, 1.22f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
        }

        void KilledUnit(Unit * victim)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void JustDied(Unit * victim)
        {
            DoScriptText(SAY_DEATH, me);
            _JustDied();
            
            me->setFaction(35);
            
            // Achievements
            if (pInstance)
            {
                // Kill credit
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 64985);
                // Lose Your Illusion
                if (HardMode)
                {
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_LOSE_ILLUSION);
                    me->SummonGameObject(RAID_MODE(CACHE_OF_STORMS_HARDMODE_10, CACHE_OF_STORMS_HARDMODE_25), 2134.58f, -286.908f, 419.495f, 1.55988f, 0, 0, 0.7f, 0.7f, 604800);
                }
                else
                {
                    me->SummonGameObject(RAID_MODE(CACHE_OF_STORMS_10, CACHE_OF_STORMS_25), 2134.58f, -286.908f, 419.495f, 1.55988f, 0, 0, 0.7f, 0.7f, 604800);
                }
            }
        }

        void EnterCombat(Unit* pWho)
        {
            DoScriptText(RAND(SAY_AGGRO_1,SAY_AGGRO_2), me);
            _EnterCombat();
            
            // Spawn Thunder Orbs
            for(uint8 n = 0; n < 7; n++)
                me->SummonCreature(33378, PosOrbs[n], TEMPSUMMON_CORPSE_DESPAWN);
            
            FirstTime = false;
            EncounterTime = 0;
            phase = PHASE_1;
            events.SetPhase(PHASE_1);
            DoCast(me, SPELL_SHEAT_OF_LIGHTNING);
            events.ScheduleEvent(EVENT_STORMHAMMER, 40000, 0, PHASE_1);
            events.ScheduleEvent(EVENT_CHARGE_ORB, 30000, 0, PHASE_1);
            events.ScheduleEvent(EVENT_SUMMON_ADDS, 20000, 0, PHASE_1);
            events.ScheduleEvent(EVENT_BERSERK, 300000, 0, PHASE_1);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;
            
            if (phase == PHASE_2 && !IN_ARENA(me))
            {
                EnterEvadeMode();
                return;
            }
                
            events.Update(diff);
            EncounterTime += diff;

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (phase == PHASE_1)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_STORMHAMMER:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 80, true))
                                if (pTarget->isAlive() && IN_ARENA(pTarget))
                                    DoCast(pTarget, SPELL_STORMHAMMER);
                            events.ScheduleEvent(EVENT_STORMHAMMER, urand(15000, 20000), 0, PHASE_1);
                            break;
                        case EVENT_CHARGE_ORB:
                            DoCastAOE(SPELL_CHARGE_ORB);
                            events.ScheduleEvent(EVENT_CHARGE_ORB, urand(15000, 20000), 0, PHASE_1);
                            break;
                        case EVENT_SUMMON_ADDS:
                            spawnAdd();
                            events.ScheduleEvent(EVENT_SUMMON_ADDS, 10000, 0, PHASE_1);
                            break;
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK);
                            DoScriptText(SAY_BERSERK, me);
                            events.CancelEvent(EVENT_BERSERK);
                            break;
                    }
                }
            }
            else
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_UNBALANCING_STRIKE:
                            DoCastVictim(SPELL_UNBALANCING_STRIKE);
                            events.ScheduleEvent(EVENT_UNBALANCING_STRIKE, 25000, 0, PHASE_2);
                            break;
                        case EVENT_CHAIN_LIGHTNING:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                if (pTarget->isAlive())
                                    DoCast(pTarget, RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25));
                            events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, urand(15000, 20000), 0, PHASE_2);
                            break;
                        /*case EVENT_TRANSFER_ENERGY:
                            //DoScriptText(SAY_SUMMON, me);
                            me->SummonCreature(32892, PosCharge[rand()%7], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            events.ScheduleEvent(EVENT_TRANSFER_ENERGY, 20000, 0, PHASE_2);
                            break;*/
                        case EVENT_RELEASE_ENERGY:
                            DoCast(me, SPELL_LIGHTNING_CHARGE);
                            //DoCast(EnergySource, SPELL_LIGHTNING_RELEASE);
                            events.ScheduleEvent(EVENT_RELEASE_ENERGY, 20000, 0, PHASE_2);
                            break;
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK);
                            DoScriptText(SAY_BERSERK, me);
                            events.CancelEvent(EVENT_BERSERK);
                            break;
                    }
                }
            }
                        
            DoMeleeAttackIfReady();
        }
        
        void DoAction(const int32 action)
        {
            switch (action)
            {
                case INCREASE_PREADDS_COUNT:
                    ++PreAddsCount;
                    break;
                case ACTION_CHANGE_PHASE:
                    DoScriptText(SAY_JUMPDOWN, me);
                    phase = PHASE_2;
                    events.SetPhase(PHASE_2);
                    me->RemoveAurasDueToSpell(SPELL_SHEAT_OF_LIGHTNING);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                    me->GetMotionMaster()->MoveJump(2134.79f, -263.03f, 419.84f, 10.0f, 20.0f);
                    events.ScheduleEvent(EVENT_UNBALANCING_STRIKE, 15000, 0, PHASE_2);
                    events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 20000, 0, PHASE_2);
                    //events.ScheduleEvent(EVENT_TRANSFER_ENERGY, 20000, 0, PHASE_2);
                    events.ScheduleEvent(EVENT_RELEASE_ENERGY, 25000, 0, PHASE_2);
                    events.ScheduleEvent(EVENT_BERSERK, 300000, 0, PHASE_2);
                    // Hard Mode
                    if (EncounterTime <= MAX_HARD_MODE_TIME)
                    {
                        HardMode = true;
                        // Summon Sif
                        me->SummonCreature(33196, 2149.27f, -260.55f, 419.69f, 2.527f, TEMPSUMMON_CORPSE_DESPAWN);
                        // Achievement Siffed
                        if (pInstance)
                            pInstance->DoCompleteAchievement(ACHIEVEMENT_SIFFED);
                    }
                    else me->AddAura(SPELL_TOUCH_OF_DOMINION, me);
                    break;
            }
            
            if (PreAddsCount >= 6 && FirstTime)
            {
                // Event starts
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                DoZoneInCombat();
            }
        }
        
        void spawnAdd()
        {
            switch(spawnedAdds)
            {
                case 0:
                    me->SummonCreature(ARENA_PHASE_ADD[0], Pos[rand()%7], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    me->SummonCreature(ARENA_PHASE_ADD[2], Pos[rand()%7], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    me->SummonCreature(ARENA_PHASE_ADD[3], Pos[rand()%7], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    break;
                case 1:
                    for(uint8 n = 0; n < 7; n++)
                        me->SummonCreature(ARENA_PHASE_ADD[1], Pos[n], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    break;
            }

            spawnedAdds++;
            if(spawnedAdds > 1)
            {
                spawnedAdds = 0;
            }
        }
    };
};
// Pre-Phase Adds
class mob_pre_phase : public CreatureScript
{
public:
    mob_pre_phase() : CreatureScript("mob_pre_phase") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_pre_phaseAI (pCreature);
    }

    struct mob_pre_phaseAI : public ScriptedAI
    {
        mob_pre_phaseAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            id = PreAdds(0);
            for (uint8 i = 0; i < 6; ++i)
                if (me->GetEntry() == PRE_PHASE_ADD[i])
                    id = PreAdds(i);
        }

        PreAdds id;
        InstanceScript* pInstance;
        int32 PrimaryTimer;
        int32 SecondaryTimer;

        void Reset()
        {
            PrimaryTimer = urand(3000, 6000);
            SecondaryTimer = urand (12000, 15000);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (PrimaryTimer <= (int32)uiDiff)
            {
                DoCast(SPELL_PRE_PRIMARY(id));
                PrimaryTimer = urand(15000, 20000);
            }
            else PrimaryTimer -= uiDiff;
            
            if (SecondaryTimer <= (int32)uiDiff)
            {
                DoCast(SPELL_PRE_SECONDARY(id));
                SecondaryTimer = urand(4000, 8000);
            }
            else SecondaryTimer -= uiDiff;

            if (id == DARK_RUNE_ACOLYTE)
                DoSpellAttackIfReady(SPELL_HOLY_SMITE);
            else
                DoMeleeAttackIfReady();
        }
        
        void JustDied(Unit *victim)
        {
            if (Creature* pThorim = Unit::GetCreature(*me, pInstance->GetData64(DATA_THORIM)))
                if (pThorim->AI())
                    pThorim->AI()->DoAction(INCREASE_PREADDS_COUNT);
        }
    };
};
// Arena Phase Adds
class mob_arena_phase : public CreatureScript
{
public:
    mob_arena_phase() : CreatureScript("mob_arena_phase") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_arena_phaseAI (pCreature);
    }

    struct mob_arena_phaseAI : public ScriptedAI
    {
        mob_arena_phaseAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            id = ArenaAdds(0);
            for (uint8 i = 0; i < 6; ++i)
                if (me->GetEntry() == ARENA_PHASE_ADD[i])
                    id = ArenaAdds(i);
                    
            IsInArena = IN_ARENA(me);
        }

        ArenaAdds id;
        InstanceScript* pInstance;
        int32 PrimaryTimer;
        int32 SecondaryTimer;
        int32 ChargeTimer;
        bool IsInArena;
        
        bool isOnSameSide(const Unit *pWho)
        {
            return (IsInArena == IN_ARENA(pWho));
        }
        
        void DamageTaken(Unit *attacker, uint32 &damage)
        {
            if (!isOnSameSide(attacker))
                damage = 0;
        }
        
        void EnterEvadeMode()
        {
            Map* pMap = me->GetMap();
            if (pMap->IsDungeon())
            {
                Map::PlayerList const &PlayerList = pMap->GetPlayers();
                if (!PlayerList.isEmpty())
                {
                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (i->getSource() && i->getSource()->isAlive() && isOnSameSide(i->getSource()))
                        {
                            AttackStart(i->getSource());
                            return;
                        }
                    }
                }
            }

            me->StopMoving();
            Reset();
        }

        void Reset()
        {
            PrimaryTimer = urand(3000, 6000);
            SecondaryTimer = urand (7000, 9000);
            ChargeTimer = 8000;
        }
        
        void EnterCombat(Unit* pWho)
        {
            if (id == DARK_RUNE_WARBRINGER)
                DoCast(me, SPELL_AURA_OF_CELERITY);
                
            DoZoneInCombat();
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if ((!isOnSameSide(me) || me->getVictim() && !isOnSameSide(me->getVictim())))
            {
                EnterEvadeMode();
                return;
            }
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (PrimaryTimer <= (int32)uiDiff)
            {
                DoCast(SPELL_ARENA_PRIMARY(id));
                PrimaryTimer = urand(3000, 6000);
            }
            else PrimaryTimer -= uiDiff;
            
            if (SecondaryTimer <= (int32)uiDiff)
            {
                DoCast(SPELL_ARENA_SECONDARY(id));
                SecondaryTimer = urand(12000, 16000);
            }
            else SecondaryTimer -= uiDiff;
            
            if (ChargeTimer <= (int32)uiDiff)
            {
                if (id == DARK_RUNE_CHAMPION)
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 40, true))
                        DoCast(pTarget, SPELL_CHARGE);
                ChargeTimer = 12000;
            }
            else ChargeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};
    // Runic Colossus (Mini Boss)
class mob_runic_colossus : public CreatureScript
{
public:
    mob_runic_colossus() : CreatureScript("mob_runic_colossus") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_runic_colossusAI (pCreature);
    }

    struct mob_runic_colossusAI : public ScriptedAI
    {
        mob_runic_colossusAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList summons;
            
        int32 BarrierTimer;
        int32 SmashTimer;
        int32 ChargeTimer;

        void Reset()
        {
            BarrierTimer = urand(12000, 15000);
            SmashTimer = urand (15000, 18000);
            ChargeTimer = urand (20000, 24000);
            
            me->GetMotionMaster()->MoveTargetedHome();
            // Close Runed Door
            if (pInstance)
                pInstance->SetData(DATA_RUNIC_DOOR, GO_STATE_READY);
                
            // Spawn trashes
            summons.DespawnAll();
            me->SummonCreature(32874, 2218.38f, -297.50f, 412.18f, 1.030f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(32874, 2235.07f, -297.98f, 412.18f, 1.613f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(32874, 2235.26f, -338.34f, 412.18f, 1.589f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(32874, 2217.69f, -337.39f, 412.18f, 1.241f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(33110, 2227.58f, -308.30f, 412.18f, 1.591f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(33110, 2227.47f, -345.37f, 412.18f, 1.566f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            // I cannot find the real spell
            if (!me->IsWithinMeleeRange(me->getVictim()))
                DoCast(me, SPELL_SMASH);
        
            if (!UpdateVictim())
                return;
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (BarrierTimer <= (int32)uiDiff)
            {
                me->MonsterTextEmote(EMOTE_MIGHT, 0, true);
                DoCast(me, SPELL_RUNIC_BARRIER);
                BarrierTimer = urand(35000, 45000);
            }
            else BarrierTimer -= uiDiff;
            
            if (SmashTimer <= (int32)uiDiff)
            {
                DoCast(me, SPELL_SMASH);
                SmashTimer = urand (15000, 18000);
            }
            else SmashTimer -= uiDiff;
            
            if (ChargeTimer <= (int32)uiDiff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 30, true))
                    DoCast(pTarget, RAID_MODE(SPELL_CHARGE_10, SPELL_CHARGE_25));
                ChargeTimer = 20000;
            }
            else ChargeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
        
        void JustDied(Unit *victim)
        {
            // Open Runed Door
            if (pInstance)
                pInstance->SetData(DATA_RUNIC_DOOR, GO_STATE_ACTIVE);
        }
        
        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
        }
    };
};
// Ancient Rune Giant (Mini Boss)
class mob_rune_giant : public CreatureScript
{
public:
    mob_rune_giant() : CreatureScript("mob_rune_giant") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_rune_giantAI (pCreature);
    }

    struct mob_rune_giantAI : public ScriptedAI
    {
        mob_rune_giantAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList summons;
            
        int32 StompTimer;
        int32 DetonationTimer;

        void Reset()
        {
            StompTimer = urand(10000, 12000);
            DetonationTimer = 25000;
            
            me->GetMotionMaster()->MoveTargetedHome();
            // Close Stone Door
            if (pInstance)
                pInstance->SetData(DATA_STONE_DOOR, GO_STATE_READY);
                
            // Spawn trashes
            summons.DespawnAll();
            me->SummonCreature(32875, 2198.05f, -428.77f, 419.95f, 6.056f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(32875, 2220.31f, -436.22f, 412.26f, 1.064f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(32875, 2158.88f, -441.73f, 438.25f, 0.127f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(33110, 2198.29f, -436.92f, 419.95f, 0.261f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
            me->SummonCreature(33110, 2230.93f, -434.27f, 412.26f, 1.931f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
        }
        
        void EnterCombat(Unit* pWho)
        {
            me->MonsterTextEmote(EMOTE_MIGHT, 0, true);
            DoCast(me, SPELL_RUNIC_FORTIFICATION); // need core support
        }
        
        void UpdateAI(const uint32 uiDiff)
        {    
            if (!UpdateVictim())
                return;
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (StompTimer <= (int32)uiDiff)
            {
                DoCast(me, RAID_MODE(SPELL_STOMP_10, SPELL_STOMP_25));
                StompTimer = urand(10000, 12000);
            }
            else StompTimer -= uiDiff;
            
            if (DetonationTimer <= (int32)uiDiff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 40, true))
                    DoCast(pTarget, SPELL_RUNE_DETONATION);
                DetonationTimer = urand(10000, 12000);
            }
            else DetonationTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
        
        void JustDied(Unit *victim)
        {
            // Open Stone Door
            if (pInstance)
                pInstance->SetData(DATA_STONE_DOOR, GO_STATE_ACTIVE);
        }
        
        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
        }
    };
};
// Thorim Phase Trigger
class thorim_phase_trigger : public CreatureScript
{
public:
    thorim_phase_trigger() : CreatureScript("thorim_phase_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new thorim_phase_triggerAI (pCreature);
    }

    struct thorim_phase_triggerAI : public Scripted_NoMovementAI
    {
        thorim_phase_triggerAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        
        void MoveInLineOfSight(Unit *who)
        {
            if (Creature* pRunicColossus = Unit::GetCreature(*me, pInstance->GetData64(DATA_RUNIC_COLOSSUS)))
                if (pRunicColossus->isDead())
                    if (Creature* pRuneGiant = Unit::GetCreature(*me, pInstance->GetData64(DATA_RUNE_GIANT)))
                        if (pRuneGiant->isDead())
                            if (pInstance && pInstance->GetBossState(BOSS_THORIM) == IN_PROGRESS)
                                if (me->IsWithinDistInMap(who, 10.0f) && who->GetTypeId() == TYPEID_PLAYER)
                                {
                                    if (Creature* pThorim = Unit::GetCreature(*me, pInstance->GetData64(DATA_THORIM)))
                                    if (pThorim->AI())
                                    pThorim->AI()->DoAction(ACTION_CHANGE_PHASE);
                                    me->ForcedDespawn();
                                }
            ScriptedAI::MoveInLineOfSight(who);
        }
    };
};
// Thorim Energy Source
class thorim_energy_source : public CreatureScript
{
public:
    thorim_energy_source() : CreatureScript("thorim_energy_source") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new thorim_energy_sourceAI (pCreature);
    }

    struct thorim_energy_sourceAI : public Scripted_NoMovementAI
    {
        thorim_energy_sourceAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            pThorim = Unit::GetCreature(*me, pInstance->GetData64(DATA_THORIM));
        }

        InstanceScript* pInstance;
        Creature* pThorim;
        int32 TransferTimer;

        void Reset()
        {
            TransferTimer = 0;
            me->ForcedDespawn(5000);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
                
            if (pThorim && pThorim->isAlive())
                DoCast(pThorim, 2400, true);
                me->StopMoving();
        }
    };
};
// Sif (only in Hard-Mode)
class npc_sif : public CreatureScript
{
public:
    npc_sif() : CreatureScript("npc_sif") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_sifAI (pCreature);
    }

    struct npc_sifAI : public ScriptedAI
    {
        npc_sifAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        int32 VolleyTimer;
        int32 BlizzardTimer;
        int32 NovaTimer;

        void Reset()
        {
            VolleyTimer = 15000;
            BlizzardTimer = 30000;
            NovaTimer = urand(20000, 25000);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (VolleyTimer <= (int32)uiDiff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 40, true))
                {
                    DoResetThreat();
                    me->AddThreat(pTarget, 5000000.0f);
                    DoCast(pTarget, RAID_MODE(SPELL_FROSTBOLT_VOLLEY_10, SPELL_FROSTBOLT_VOLLEY_25));
                }
                VolleyTimer = urand(15000, 20000);
            }
            else VolleyTimer -= uiDiff;
            
            if (BlizzardTimer <= (int32)uiDiff)
            {
                DoCast(me, RAID_MODE(SPELL_BLIZZARD_10, SPELL_BLIZZARD_25));
                BlizzardTimer = 45000;
            }
            else BlizzardTimer -= uiDiff;
            
            if (NovaTimer <= (int32)uiDiff)
            {
                DoCastAOE(RAID_MODE(SPELL_FROSTNOVA_10, SPELL_FROSTNOVA_25));
                NovaTimer = urand(20000, 25000);
            }
            else NovaTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_thorim()
{
    new boss_thorim();
    new mob_pre_phase();
    new mob_arena_phase();
    new mob_runic_colossus();
    new mob_rune_giant();
    new thorim_phase_trigger();
    new thorim_energy_source();
    new npc_sif();
}