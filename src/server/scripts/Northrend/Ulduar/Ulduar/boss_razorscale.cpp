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
SDName: Razorscale
SDAuthor: PrinceCreed
SD%Complete: 100
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

#define SAY_GREET                   -1603260
#define SAY_AGGRO_1                 "Give us a moment to prepare to build the turrets."
#define SAY_AGGRO_2                 "Be on the lookout! Mole machines will be surfacing soon with those nasty Iron dwarves aboard!"
#define SAY_AGGRO_3                 "Ready to move out, keep those dwarves off of our backs!"
#define SAY_GROUND_PHASE            -1603261
#define SAY_TURRETS                 "Fires out! Let's rebuild those turrets!"

#define GOSSIP_ITEM_1               "Activate Harpoones!"
#define EMOTE_HARPOON               "Harpoon Turret is ready for use!"
#define EMOTE_BREATH                "Razorscale takes a deep breath..."
#define EMOTE_PERMA                 "Razorscale grounded permanently!"

enum Spells
{
    SPELL_FLAMEBUFFET               = 64016,
    SPELL_FIREBALL_10               = 62796,
    SPELL_FIREBALL_25               = 63815,
    SPELL_FLAME_GROUND_10           = 64709,
    SPELL_FLAME_GROUND_25           = 64734,
    SPELL_WINGBUFFET                = 62666,
    SPELL_FLAMEBREATH_10            = 63317,
    SPELL_FLAMEBREATH_25            = 64021,
    SPELL_FUSEARMOR                 = 64771,
    SPELL_DEVOURING_FLAME           = 63236,
    SPELL_HARPOON                   = 54933,
    SPELL_FLAMED                    = 62696,
    SPELL_STUN                      = 9032,
    SPELL_BERSERK                   = 47008
};

const Position PosHarpoon[4] =
{
{594.317f, -136.953f, 391.517f, 4.544f},
{577.449f, -136.953f, 391.517f, 4.877f},
{607.726f, -146.857f, 391.517f, 4.041f},
{561.449f, -146.857f, 391.517f, 5.426f}
};

const Position PosEngSpawn = {591.951477f, -95.968292f, 391.516998f, 0};

const Position PosEngRepair[4] =
{
{590.442f, -130.550f, 391.517f, 4.789f},
{574.850f, -133.687f, 391.517f, 4.252f},
{606.567f, -143.369f, 391.517f, 4.434f},
{560.609f, -142.967f, 391.517f, 5.074f}
};

const Position PosDefSpawn[4] =
{
{600.75f, -104.850f, 391.5169f, 0},
{596.38f, -110.262f, 391.5169f, 0},
{566.47f, -103.633f, 391.5169f, 0},
{570.41f, -108.791f, 391.5169f, 0}
};

const Position PosDefCombat[4] =
{
{614.975f, -155.138f, 391.517f, 4.154f},
{609.814f, -204.968f, 391.517f, 5.385f},
{563.531f, -201.557f, 391.517f, 4.108f},
{560.231f, -153.677f, 391.517f, 5.403f}
};

const Position RazorFlight = {588.050f, -251.191f, 470.535980f, 1.605303f};
const Position RazorGround = {586.966f, -175.534f, 391.516998f, 1.691704f};

enum Mobs
{
    RAZORSCALE                      = 33186,
    NPC_DARK_RUNE_GUARDIAN          = 33388,
    NPC_DARK_RUNE_SENTINEL          = 33846,
    NPC_DARK_RUNE_WATCHER           = 33453,
    MOLE_MACHINE_TRIGGER            = 33245,
    NPC_COMMANDER                   = 33210,
    NPC_ENGINEER                    = 33287,
    NPC_DEFENDER                    = 33816,
    NPC_HARPOON                     = 33184,
    GOB_MOLE_MACHINE                = 194316
};

enum DarkRuneSpells
{
    // Dark Rune Watcher
    SPELL_CHAIN_LIGHTNING_10        = 64758,
    SPELL_CHAIN_LIGHTNING_25        = 64759,
    SPELL_LIGHTNING_BOLT_10         = 63809,
    SPELL_LIGHTNING_BOLT_25         = 64696,
    
    // Dark Rune Guardian
    SPELL_STORMSTRIKE               = 64757,
    
    // Dark Rune Sentinel
    SPELL_BATTLE_SHOUT_10           = 46763,
    SPELL_BATTLE_SHOUT_25           = 64062,
    SPELL_HEROIC_STRIKE             = 45026,
    SPELL_WHIRLWIND_10              = 63807,
    SPELL_WHIRLWIND_25              = 63808,
};

#define ACHIEVEMENT_QUICK_SHAVE     RAID_MODE(2919, 2921)

#define ACTION_EVENT_START          1
#define ACTION_GROUND_PHASE         2

enum Phases
{
    PHASE_NULL = 0,
    PHASE_PERMAGROUND,
    PHASE_GROUND,
    PHASE_FLIGHT
};

enum Events
{
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_BREATH,
    EVENT_BUFFET,
    EVENT_HARPOON,
    EVENT_FIREBALL,
    EVENT_FLIGHT,
    EVENT_DEVOURING,
    EVENT_FLAME,
    EVENT_LAND,
    EVENT_GROUND,
    EVENT_FUSE,
    EVENT_SUMMON
};

class boss_razorscale : public CreatureScript
{
public:
    boss_razorscale() : CreatureScript("boss_razorscale") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_razorscaleAI (pCreature);
    }

    struct boss_razorscaleAI : public BossAI
    {
        boss_razorscaleAI(Creature *pCreature) : BossAI(pCreature, BOSS_RAZORSCALE)
            , phase(PHASE_NULL)
        {
            // Do not let Razorscale be affected by Battle Shout buff
            me->ApplySpellImmune(0, IMMUNITY_ID, RAID_MODE(SPELL_BATTLE_SHOUT_10, SPELL_BATTLE_SHOUT_25), true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true);  // Death Grip
            pInstance = pCreature->GetInstanceScript();
            pMap = me->GetMap();
        }

        Phases phase;
        InstanceScript* pInstance;
        Map* pMap;
        
        uint32 EnrageTimer;
        uint32 FlyCount;
        
        Creature* Harpoon[4];
        Creature* MoleTrigger;
        bool PermaGround;
        bool Enraged;

        void Reset()
        {
            _Reset();
            me->SetFlying(true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            PermaGround = false;
        }

        void EnterCombat(Unit* who)
        {
            _EnterCombat();
            for (uint8 n = 0; n < RAID_MODE(2,4); ++n)
                Harpoon[n] = me->SummonCreature(NPC_HARPOON, PosHarpoon[n], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 0);
            me->SetSpeed(MOVE_FLIGHT, 3.0f, true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
            phase = PHASE_GROUND;
            events.SetPhase(PHASE_GROUND);
            FlyCount = 0;
            EnrageTimer = 15*60*1000;   // Enrage in 15 min
            Enraged = false;
            events.ScheduleEvent(EVENT_FLIGHT, 0, 0, PHASE_GROUND);
            DoZoneInCombat();
        }

        void JustDied(Unit* Killer)
        {
            _JustDied();
            
            // Achievements
            if (pInstance)
            {
                // A Quick Shave
                if (FlyCount <= 2)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_QUICK_SHAVE);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->getVictim() && !me->getVictim()->GetCharmerOrOwnerPlayerOrPlayerItself())
                me->Kill(me->getVictim());
                
            events.Update(diff);
                
            if (HealthBelowPct(50) && !PermaGround)
                EnterPermaGround();
            
            if (EnrageTimer<= diff && !Enraged)
            {
                DoCast(me, SPELL_BERSERK);
                Enraged = true;
            }
            else EnrageTimer -= diff;

            if (phase == PHASE_GROUND)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_FLIGHT:
                            phase = PHASE_FLIGHT;
                            events.SetPhase(PHASE_FLIGHT);
                            me->SetFlying(true);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            me->SetReactState(REACT_PASSIVE);
                            me->AttackStop();
                            me->RemoveAllAuras();
                            me->GetMotionMaster()->MovePoint(0,RazorFlight);
                            events.ScheduleEvent(EVENT_FIREBALL, 7000, 0, PHASE_FLIGHT);
                            events.ScheduleEvent(EVENT_DEVOURING, 10000, 0, PHASE_FLIGHT);
                            events.ScheduleEvent(EVENT_SUMMON, 5000, 0, PHASE_FLIGHT);
                            events.ScheduleEvent(EVENT_GROUND, 75000, 0, PHASE_FLIGHT);
                            ++FlyCount;
                            return;
                        case EVENT_LAND:
                            me->SetFlying(false);
                            me->NearTeleportTo(586.966f, -175.534f, 391.516998f, 1.691704f);
                            DoCast(me, SPELL_STUN, true);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (Creature *pCommander = me->GetCreature(*me, pInstance->GetData64(DATA_EXP_COMMANDER)))
                                pCommander->AI()->DoAction(ACTION_GROUND_PHASE);
                            events.ScheduleEvent(EVENT_HARPOON, 0, 0, PHASE_GROUND);
                            events.ScheduleEvent(EVENT_BREATH, 30000, 0, PHASE_GROUND);
                            events.ScheduleEvent(EVENT_BUFFET, 33000, 0, PHASE_GROUND);
                            events.ScheduleEvent(EVENT_FLIGHT, 35000, 0, PHASE_GROUND);
                            return;
                        case EVENT_HARPOON:
                            for (uint8 n = 0; n < RAID_MODE(2,4); ++n)
                                if (Harpoon[n])
                                    Harpoon[n]->CastSpell(me, SPELL_HARPOON, true);
                            events.ScheduleEvent(EVENT_HARPOON, 1500, 0, PHASE_GROUND);
                            return;
                        case EVENT_BREATH:
                            me->MonsterTextEmote(EMOTE_BREATH, 0, true);
                            DoCastAOE(RAID_MODE(SPELL_FLAMEBREATH_10, SPELL_FLAMEBREATH_25));
                            events.CancelEvent(EVENT_HARPOON);
                            events.CancelEvent(EVENT_BREATH);
                            return;
                        case EVENT_BUFFET:
                            DoCastAOE(SPELL_WINGBUFFET);
                            for (uint8 n = 0; n < RAID_MODE(2,4); ++n)
                                if (Harpoon[n])
                                    Harpoon[n]->CastSpell(Harpoon[n], SPELL_FLAMED, true);
                            events.CancelEvent(EVENT_BUFFET);
                            return;
                    }
                }
            }
            if (phase == PHASE_PERMAGROUND)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_FLAME:
                            DoCastAOE(SPELL_FLAMEBUFFET);
                            events.ScheduleEvent(EVENT_FLAME, 10000, 0, PHASE_PERMAGROUND);
                            return;
                        case EVENT_BREATH:
                            me->MonsterTextEmote(EMOTE_BREATH, 0, true);
                            DoCastVictim(RAID_MODE(SPELL_FLAMEBREATH_10, SPELL_FLAMEBREATH_25));
                            events.ScheduleEvent(EVENT_BREATH, 20000, 0, PHASE_PERMAGROUND);
                            return;
                        case EVENT_FIREBALL:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200, true))
                                DoCast(pTarget, RAID_MODE(SPELL_FIREBALL_10, SPELL_FIREBALL_25));
                            events.ScheduleEvent(EVENT_FIREBALL, 3000, 0, PHASE_PERMAGROUND);
                            return;
                        case EVENT_DEVOURING:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200, true))
                                DoCast(pTarget, SPELL_DEVOURING_FLAME);
                            events.ScheduleEvent(EVENT_DEVOURING, 10000, 0, PHASE_PERMAGROUND);
                            return;
                        case EVENT_BUFFET:
                            DoCastAOE(SPELL_WINGBUFFET);
                            events.CancelEvent(EVENT_BUFFET);
                            return;
                        case EVENT_FUSE:
                            DoCastVictim(SPELL_FUSEARMOR);
                            events.ScheduleEvent(EVENT_FUSE, 10000, 0, PHASE_PERMAGROUND);
                            return;
                    }
                }

                DoMeleeAttackIfReady();
            }
            else
            {
                if (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_GROUND:
                            phase = PHASE_GROUND;
                            events.SetPhase(PHASE_GROUND);
                            if (Harpoon[0])
                                Harpoon[0]->MonsterTextEmote(EMOTE_HARPOON, 0, true);
                            me->GetMotionMaster()->MovePoint(0,RazorGround);
                            events.ScheduleEvent(EVENT_LAND, 5500, 0, PHASE_GROUND);
                            return;
                        case EVENT_FIREBALL:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200, true))
                                DoCast(pTarget, RAID_MODE(SPELL_FIREBALL_10, SPELL_FIREBALL_25));
                            events.ScheduleEvent(EVENT_FIREBALL, 3000, 0, PHASE_FLIGHT);
                            return;
                        case EVENT_DEVOURING:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200, true))
                                DoCast(pTarget, SPELL_DEVOURING_FLAME);
                            events.ScheduleEvent(EVENT_DEVOURING, 10000, 0, PHASE_FLIGHT);
                            return;
                        case EVENT_SUMMON:
                            SummonAdds();
                            events.ScheduleEvent(EVENT_SUMMON, 45000, 0, PHASE_FLIGHT);
                            return;
                    }
                }
            }
        }
        
        void EnterPermaGround()
        {
            me->MonsterTextEmote(EMOTE_PERMA, 0, true);
            phase = PHASE_PERMAGROUND;
            events.SetPhase(PHASE_PERMAGROUND);
            me->SetFlying(false);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveAurasDueToSpell(SPELL_STUN);
            me->SetSpeed(MOVE_FLIGHT, 1.0f, true);
            PermaGround = true;
            DoCastAOE(RAID_MODE(SPELL_FLAMEBREATH_10, SPELL_FLAMEBREATH_25));
            events.ScheduleEvent(EVENT_FLAME, 15000, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_DEVOURING, 15000, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_BREATH, 20000, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_FIREBALL, 3000, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_DEVOURING, 6000, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_BUFFET, 2500, 0, PHASE_PERMAGROUND);
            events.RescheduleEvent(EVENT_FUSE, 5000, 0, PHASE_PERMAGROUND);
        }

        void SummonAdds()
        {
            // Adds will come in waves from mole machines. One mole can spawn a Dark Rune Watcher
            // with 1-2 Guardians, or a lone Sentinel. Up to 4 mole machines can spawn adds at any given time.
            uint8 random = urand(1,4);
            for (uint8 i = 0; i < random; ++i)
            {
                float x = irand(540.0f, 640.0f);    // Safe range is between 500 and 650
                float y = irand(-230.0f, -195.0f);  // Safe range is between -235 and -145
                float z = 391.5f;                   // Ground level
                MoleTrigger = me->SummonCreature(MOLE_MACHINE_TRIGGER, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
            }
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
                case ACTION_EVENT_START:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    DoZoneInCombat();
                    break;
            }
        }
    };
};
/*====================================================================================
====================================================================================*/

class npc_expedition_commander : public CreatureScript
{
public:
    npc_expedition_commander() : CreatureScript("npc_expedition_commander") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_expedition_commanderAI (pCreature);
    }

    struct npc_expedition_commanderAI : public ScriptedAI
    {
        npc_expedition_commanderAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
            greet = false;
        }
        
        InstanceScript* pInstance;
        SummonList summons;

        bool greet;
        uint32 uiTimer;
        uint8  uiPhase;
        Creature* engineer[4];
        Creature* defender[4];

        void Reset()
        {
            uiTimer = 0;
            uiPhase = 0;
            greet = false;
        }
        
        void MoveInLineOfSight(Unit *who)
        {
            if (!greet && me->IsWithinDistInMap(who, 10.0f) && who->GetTypeId() == TYPEID_PLAYER)
            {
                DoScriptText(SAY_GREET, me);
                greet = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
        }
       
        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
                case ACTION_GROUND_PHASE:
                    DoScriptText(SAY_GROUND_PHASE, me);
                    break;
            }
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            ScriptedAI::UpdateAI(uiDiff);
            if (uiTimer <= uiDiff)
            {
                switch(uiPhase)
                {
                    case 1:
                        pInstance->SetBossState(BOSS_RAZORSCALE, IN_PROGRESS);
                        summons.DespawnAll();
                        uiTimer = 1000;
                        uiPhase = 2;
                        break;
                    case 2:
                        for (uint8 n = 0; n < RAID_MODE(2,4); ++n)
                        {
                            engineer[n] = me->SummonCreature(NPC_ENGINEER, PosEngSpawn, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            engineer[n]->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            engineer[n]->SetSpeed(MOVE_RUN, 0.5f);
                            engineer[n]->SetHomePosition(PosEngRepair[n]);
                            engineer[n]->GetMotionMaster()->MoveTargetedHome();
                        }
                        engineer[0]->MonsterYell(SAY_AGGRO_3, LANG_UNIVERSAL, 0);
                        uiPhase = 3;
                        uiTimer = 14000;
                        break;
                    case 3:
                        for (uint8 n = 0; n < 4; ++n)
                        {
                            defender[n] = me->SummonCreature(NPC_DEFENDER, PosDefSpawn[n], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            defender[n] ->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            defender[n] ->SetHomePosition(PosDefCombat[n]);
                            defender[n] ->GetMotionMaster()->MoveTargetedHome();
                        }
                        uiPhase = 4;
                        break;
                    case 4:
                        for (uint8 n = 0; n < RAID_MODE(2,4); ++n)
                            engineer[n]->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USESTANDING);
                        for (uint8 n = 0; n < 4; ++n)
                            defender[n]->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                        me->MonsterYell(SAY_AGGRO_2, LANG_UNIVERSAL, 0);
                        uiTimer = 16000;
                        uiPhase = 5;
                        break;
                    case 5:
                        if (Creature *pRazorscale = me->GetCreature(*me, pInstance->GetData64(DATA_RAZORSCALE)))
                            if (pRazorscale->AI())
                                pRazorscale->AI()->DoAction(ACTION_EVENT_START);
                        engineer[0]->MonsterYell(SAY_AGGRO_1, LANG_UNIVERSAL, 0);
                        uiPhase = 6;
                        break;
                }
                if (!UpdateVictim())
                    return;
                    
                DoMeleeAttackIfReady();
            }
            else uiTimer -= uiDiff;
        }
    };


    bool Expedition_commander_ulduar(Player* pPlayer, Creature* pCreature)
    {
        InstanceScript *pInstance = (InstanceScript *) pCreature->GetInstanceScript();
        
        if (pInstance && pPlayer && pInstance->GetBossState(BOSS_RAZORSCALE) == NOT_STARTED)
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_ITEM_1,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
            pPlayer->SEND_GOSSIP_MENU(13853, pCreature->GetGUID());
        }else
            pPlayer->SEND_GOSSIP_MENU(13910, pCreature->GetGUID());
        return true;
    }

    bool GossipSelect_commander_ulduar(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
    {
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                if (pPlayer)
                    pPlayer->CLOSE_GOSSIP_MENU();
                CAST_AI(npc_expedition_commanderAI, (pCreature->AI()))->uiPhase = 1;
                break;
        }
        return true;
    }
};
class mob_devouring_flame : public CreatureScript
{
public:
    mob_devouring_flame() : CreatureScript("mob_devouring_flame") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_devouring_flameAI (pCreature);
    }

    struct mob_devouring_flameAI : public ScriptedAI
    {
        mob_devouring_flameAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
        }

        void Reset()
        {
            DoCast(me, RAID_MODE(SPELL_FLAME_GROUND_10, SPELL_FLAME_GROUND_25));
        }
    };
};
class mob_darkrune_watcher : public CreatureScript
{
public:
    mob_darkrune_watcher() : CreatureScript("mob_darkrune_watcher") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_darkrune_watcherAI (pCreature);
    }

struct mob_darkrune_watcherAI : public ScriptedAI
{
    mob_darkrune_watcherAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    int32 ChainTimer;
    int32 LightTimer;

    void Reset()
    {
        ChainTimer = urand(10000, 15000);
        LightTimer = urand(1000, 3000);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (ChainTimer <= (int32)uiDiff)
        {
            DoCastVictim(RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25));
            ChainTimer = urand(10000, 15000);
        } else ChainTimer -= uiDiff;
        
        if (LightTimer <= (int32)uiDiff)
        {
            DoCastVictim(RAID_MODE(SPELL_LIGHTNING_BOLT_10, SPELL_LIGHTNING_BOLT_25));
            LightTimer = urand(5000, 7000);
        } else LightTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

};
class mob_darkrune_guardian : public CreatureScript
{
public:
    mob_darkrune_guardian() : CreatureScript("mob_darkrune_guardian") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_darkrune_guardianAI (pCreature);
    }

    struct mob_darkrune_guardianAI : public ScriptedAI
    {
        mob_darkrune_guardianAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 StormTimer;

        void Reset()
        {
            StormTimer = urand(3000, 6000);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (StormTimer <= (int32)uiDiff)
            {
                DoCastVictim(SPELL_STORMSTRIKE);
                StormTimer = urand(4000, 8000);
            } else StormTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};
class mob_darkrune_sentinel : public CreatureScript
{
public:
    mob_darkrune_sentinel() : CreatureScript("mob_darkrune_sentinel") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_darkrune_sentinelAI (pCreature);
    }

    struct mob_darkrune_sentinelAI : public ScriptedAI
    {
        mob_darkrune_sentinelAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 HeroicTimer;
        int32 WhirlTimer;
        int32 ShoutTimer;

        void Reset()
        {
            HeroicTimer = urand(4000, 8000);
            WhirlTimer = urand(20000, 30000);
            ShoutTimer = urand(30000, 40000);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (HeroicTimer <= (int32)uiDiff)
            {
                DoCastVictim(SPELL_HEROIC_STRIKE);
                HeroicTimer = urand(4000, 6000);
            } else HeroicTimer -= uiDiff;
            
            if (WhirlTimer <= (int32)uiDiff)
            {
                DoCastVictim(RAID_MODE(SPELL_WHIRLWIND_10, SPELL_WHIRLWIND_25));
                WhirlTimer = urand(20000, 30000);
            } else WhirlTimer -= uiDiff;
            
            if (ShoutTimer <= (int32)uiDiff)
            {
                DoCast(me, RAID_MODE(SPELL_BATTLE_SHOUT_10, SPELL_BATTLE_SHOUT_25));
                ShoutTimer = urand(30000, 40000);
            } else ShoutTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};
class mole_machine_trigger : public CreatureScript
{
public:
    mole_machine_trigger() : CreatureScript("mole_machine_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mole_machine_triggerAI (pCreature);
    }

    struct mole_machine_triggerAI : public ScriptedAI
    {
        mole_machine_triggerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_PACIFIED);
            me->SetVisibility(VISIBILITY_OFF);
        }

        InstanceScript* m_pInstance;
        GameObject* MoleMachine;
        int32 SummomTimer;

        void Reset()
        {
            MoleMachine = me->SummonGameObject(GOB_MOLE_MACHINE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), urand(0,6), 0, 0, 0, 0, 300);
            if (MoleMachine)
                MoleMachine->SetGoState(GO_STATE_ACTIVE);
            SummomTimer = 6000;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (SummomTimer <= (int32)uiDiff)
            {
                float x = me->GetPositionX();
                float y = me->GetPositionY();
                float z = me->GetPositionZ();
                
                // One mole can spawn a Dark Rune Watcher with 1-2 Guardians, or a lone Sentinel
                if (!(rand()%2))
                {
                    me->SummonCreature(NPC_DARK_RUNE_WATCHER, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
                    uint8 random = urand(1,2);
                    for (uint8 i = 0; i < random; ++i)
                        me->SummonCreature(NPC_DARK_RUNE_GUARDIAN, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
                }
                else
                    me->SummonCreature(NPC_DARK_RUNE_SENTINEL, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
                    
                SummomTimer = 15000;
            }
            else SummomTimer -= uiDiff;
        }
        
        void JustSummoned(Creature *summon)
        {
            summon->AI()->DoAction(0);
            summon->AI()->DoZoneInCombat();
        }
    };
};

void AddSC_boss_razorscale()
{
    new boss_razorscale();
    new npc_expedition_commander();
    new mob_devouring_flame();
    new mob_darkrune_watcher();
    new mob_darkrune_guardian();
    new mob_darkrune_sentinel();
    new mole_machine_trigger();
}