/*
 * Copyright (C) 2008 - 2009 Trinity <http://www.trinitycore.org/>
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
SDName: Mimiron
SDAuthor: PrinceCreed
SD%Complete: 95
SDComments: P3Wx2 Laser Barrage not works in phase 4.
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603240,
    SAY_HARDMODE_ON                             = -1603241,
    SAY_MKII_ACTIVATE                           = -1603242,
    SAY_MKII_SLAY_1                             = -1603243,
    SAY_MKII_SLAY_2                             = -1603244,
    SAY_MKII_DEATH                              = -1603245,
    SAY_VX001_ACTIVATE                          = -1603246,
    SAY_VX001_SLAY_1                            = -1603247,
    SAY_VX001_SLAY_2                            = -1603248,
    SAY_VX001_DEATH                             = -1603249,
    SAY_AERIAL_ACTIVATE                         = -1603250,
    SAY_AERIAL_SLAY_1                           = -1603251,
    SAY_AERIAL_SLAY_2                           = -1603252,
    SAY_AERIAL_DEATH                            = -1603253,
    SAY_V07TRON_ACTIVATE                        = -1603254,
    SAY_V07TRON_SLAY_1                          = -1603255,
    SAY_V07TRON_SLAY_2                          = -1603256,
    SAY_V07TRON_DEATH                           = -1603257,
    SAY_BERSERK                                 = -1603258,
    SAY_YS_HELP                                 = -1603259,
};

#define EMOTE_LEVIATHAN      "Leviathan MK II begins to cast Plasma Blast!"

enum eSpells
{
    // Leviathan MK II
    SPELL_MINES_SPAWN                           = 65347,
    SPELL_PROXIMITY_MINES                       = 63027,
    SPELL_NAPALM_SHELL_10                       = 63666,
    SPELL_NAPALM_SHELL_25                       = 65026,
    SPELL_PLASMA_BLAST_10                       = 62997,
    SPELL_PLASMA_BLAST_25                       = 64529,
    SPELL_SHOCK_BLAST                           = 63631,
    SPELL_EXPLOSION_10                          = 66351,
    SPELL_EXPLOSION_25                          = 63009,
    
    // VX-001
    SPELL_RAPID_BURST                           = 63382,
    SPELL_ROCKET_STRIKE                         = 63036,
    SPELL_ROCKET_STRIKE_AURA                    = 64064,
    SPELL_LASER_BARRAGE                         = 63274,
    SPELL_SPINNING_UP                           = 63414,
    SPELL_HEAT_WAVE_10                          = 63677,
    SPELL_HEAT_WAVE_25                          = 64533,
    SPELL_HAND_PULSE_10                         = 64348,
    SPELL_HAND_PULSE_25                         = 64536,
    
    // Aerial Command Unit
    SPELL_PLASMA_BALL_10                        = 63689,
    SPELL_PLASMA_BALL_25                        = 64535,
    SPELL_MAGNETIC_CORE                         = 64436,
    SPELL_MAGNETIC_CORE_VISUAL                  = 64438,
    SPELL_BOOM_BOT                              = 63801,
    SPELL_MAGNETIC_FIELD                        = 64668,
    SPELL_HOVER                                 = 57764, // Set Hover position
    SPELL_BERSERK                               = 47008,
    
    // Hard Mode
    SPELL_EMERGENCY_MODE                        = 64582,
    SPELL_FLAME_SUPPRESSANT_1                   = 64570,
    SPELL_FLAME_SUPPRESSANT_2                   = 65192,
    SPELL_FLAME                                 = 64561,
    SPELL_FROST_BOMB                            = 64624,
    SPELL_WATER_SPRAY                           = 64619,
    SPELL_SIREN                                 = 64616
};

enum eEvents
{
    // Leviathan MK II
    EVENT_NONE,
    EVENT_PROXIMITY_MINE,
    EVENT_NAPALM_SHELL,
    EVENT_PLASMA_BLAST,
    EVENT_SHOCK_BLAST,
    EVENT_FLAME_SUPPRESSANT,
    
    // VX-001
    EVENT_RAPID_BURST,
    EVENT_PRE_LASER_BARRAGE,
    EVENT_LASER_BARRAGE,
    EVENT_ROCKET_STRIKE,
    EVENT_HEAT_WAVE,
    EVENT_HAND_PULSE,
    EVENT_FROST_BOMB,
    
    // Aerial Command Unit
    EVENT_PLASMA_BALL,
    EVENT_REACTIVATE_AERIAL,
    EVENT_SUMMON_BOTS
};

enum Phases
{
    PHASE_NULL,
    PHASE_INTRO,
    PHASE_COMBAT,
    PHASE_LEVIATHAN_SOLO,
    PHASE_LEVIATHAN_ASSEMBLED,
    PHASE_VX001_ACTIVATION,
    PHASE_VX001_SOLO,
    PHASE_VX001_ASSEMBLED,
    PHASE_AERIAL_ACTIVATION,
    PHASE_AERIAL_SOLO,
    PHASE_AERIAL_ASSEMBLED,
    PHASE_V0L7R0N_ACTIVATION,
};

enum eActions
{
    DO_START_ENCOUNTER      = 1,
    DO_ACTIVATE_VX001       = 2,
    DO_START_VX001          = 3,
    DO_ACTIVATE_AERIAL      = 4,
    DO_START_AERIAL         = 5,
    DO_DISABLE_AERIAL       = 6,
    DO_ACTIVATE_V0L7R0N     = 7,
    DO_LEVIATHAN_ASSEMBLED  = 8,
    DO_VX001_ASSEMBLED      = 9,
    DO_AERIAL_ASSEMBLED     = 10,
    DO_ACTIVATE_DEATH_TIMER = 11,
    DO_ENTER_ENRAGE         = 12,
    DO_ACTIVATE_HARD_MODE   = 13
};

enum Npcs
{
    NPC_BURST_TARGET        = 34211,
    NPC_JUNK_BOT            = 33855,
    NPC_ASSAULT_BOT         = 34057,
    NPC_BOOM_BOT            = 33836,
    NPC_EMERGENCY_BOT       = 34147,
    NPC_FLAME               = 34363,
    NPC_FROST_BOMB          = 34149
};

bool MimironHardMode;

// Achievements
#define ACHIEVEMENT_FIREFIGHTER                 RAID_MODE(3180, 3189)
#define ACHIEVEMENT_NOT_SO_FRIENDLY_FIRE        RAID_MODE(3138, 2995)
#define ACHIEVEMENT_SET_UP_US_THE_BOMB          RAID_MODE(2989, 3237) // TODO

enum MimironChests
{
    CACHE_OF_INNOVATION_10                      = 194789,
    CACHE_OF_INNOVATION_HARDMODE_10             = 194790,
    CACHE_OF_INNOVATION_25                      = 194956,
    CACHE_OF_INNOVATION_HARDMODE_25             = 194957
};

const Position SummonPos[9] =
{
{2703.93f, 2569.32f, 364.397f, 0},
{2715.33f, 2569.23f, 364.397f, 0},
{2726.85f, 2569.28f, 364.397f, 0},
{2765.24f, 2534.38f, 364.397f, 0},
{2759.54f, 2544.30f, 364.397f, 0},
{2753.82f, 2554.22f, 364.397f, 0},
{2764.95f, 2604.11f, 364.397f, 0},
{2759.19f, 2594.26f, 364.397f, 0},
{2753.56f, 2584.30f, 364.397f, 0}
};

class boss_mimiron : public CreatureScript
{
public:
    boss_mimiron() : CreatureScript("boss_mimiron") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_mimironAI (pCreature);
    }

    struct boss_mimironAI : public BossAI
    {
        boss_mimironAI(Creature *pCreature) : BossAI(pCreature, BOSS_MIMIRON)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
            me->ApplySpellImmune(0, IMMUNITY_ID, 63041, true); // Rocket Strike immunity
            me->SetReactState(REACT_PASSIVE);
        }
        InstanceScript *pInstance;

        uint32 uiPhase_timer;
        uint32 uiStep;
        uint32 EnrageTimer;
        uint32 FlameTimer;
        uint32 uiBotTimer;
        bool Enraged;
        bool checkBotAlive;

        Phases phase;

        void Reset()
        {
            _Reset();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USESTANDING);
            me->SetVisibility(VISIBILITY_ON);
            me->ExitVehicle();
            me->GetMotionMaster()->MoveTargetedHome();
            if (pInstance)
                pInstance->SetData(DATA_MIMIRON_ELEVATOR, GO_STATE_ACTIVE);
                
            // Encounter Reset
            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
            {
                if (pLeviathan->isAlive())
                {
                    pLeviathan->ExitVehicle();
                    pLeviathan->AI()->EnterEvadeMode();
                }
            }
            
            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
            {
                if (pVX_001->isAlive())
                {
                    pVX_001->ExitVehicle();
                    pVX_001->AI()->EnterEvadeMode();
                }
            }
            
            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
            {
                if (pAerialUnit->isAlive())
                {
                    pAerialUnit->ExitVehicle();
                    pAerialUnit->AI()->EnterEvadeMode();
                }
            }

            phase = PHASE_NULL;
            uiStep = 0;
            uiPhase_timer = -1;
            uiBotTimer = 0;
            checkBotAlive = true;
            Enraged = false;
            MimironHardMode = false;
            DespawnCreatures(34362, 100);
            DespawnCreatures(34050, 100);
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_V07TRON_DEATH, me);
            _JustDied();
            
            me->setFaction(35);
            
            if (pInstance)
            {
                if (MimironHardMode)
                {
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_FIREFIGHTER);
                    me->SummonGameObject(RAID_MODE(CACHE_OF_INNOVATION_HARDMODE_10, CACHE_OF_INNOVATION_HARDMODE_25), 2744.65f, 2569.46f, 364.314f, 3.14159f, 0, 0, 0.7f, 0.7f, 604800);
                }
                else
                {
                    me->SummonGameObject(RAID_MODE(CACHE_OF_INNOVATION_10, CACHE_OF_INNOVATION_25), 2744.65f, 2569.46f, 364.314f, 3.14159f, 0, 0, 0.7f, 0.7f, 604800);
                }
            }
        }

        void EnterCombat(Unit *who)
        {
            _EnterCombat();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            phase = PHASE_INTRO;
            if (MimironHardMode)
                EnrageTimer = 8*60*1000; // Enrage in 8 min
            else
                EnrageTimer = 15*60*1000; // Enrage in 15 min
            FlameTimer = 30000;
            JumpToNextStep(100);
        }

        void JumpToNextStep(uint32 uiTimer)
        {
            uiPhase_timer = uiTimer;
            ++uiStep;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;
                
            if (EnrageTimer<= diff && !Enraged)
            {
                DoScriptText(SAY_BERSERK, me);
                if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                    pLeviathan->AI()->DoAction(DO_ENTER_ENRAGE);
                if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                    pVX_001->AI()->DoAction(DO_ENTER_ENRAGE);
                if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                    pAerialUnit->AI()->DoAction(DO_ENTER_ENRAGE);

                Enraged = true;
            }
            else EnrageTimer -= diff;
            
            if (MimironHardMode)
            {
                if (FlameTimer<= diff)
                {
                    for (uint8 i = 0; i < 3; ++i)
                        if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            if (Creature* Flame = me->SummonCreature(NPC_FLAME, pTarget->GetPositionX() + irand(-6,6), pTarget->GetPositionY() + irand(-6,6), pTarget->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN))
                                Flame->AI()->AttackStart(pTarget);
                    FlameTimer = 30000;
                }
                else FlameTimer -= diff;
            }
                
            // All sections need to die within 10 seconds, else they respawn
            if (checkBotAlive)
                uiBotTimer = 0;
            else
            {
                uiBotTimer += diff;
                if (uiBotTimer > 10000)
                {
                    if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                        pLeviathan->AI()->DoAction(DO_LEVIATHAN_ASSEMBLED);
                    if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                        pVX_001->AI()->DoAction(DO_VX001_ASSEMBLED);
                    if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                        pAerialUnit->AI()->DoAction(DO_AERIAL_ASSEMBLED);

                    checkBotAlive = true;
                }
                else
                {
                    if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                        if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                                if (pLeviathan->getStandState() == UNIT_STAND_STATE_DEAD)
                                    if (pVX_001->getStandState() == UNIT_STAND_STATE_DEAD)
                                        if (pAerialUnit->getStandState() == UNIT_STAND_STATE_DEAD)
                                        {
                                            if (Unit* pTarget = me->SelectNearestTarget())
                                                pTarget->ToPlayer()->RewardPlayerAndGroupAtKill(pLeviathan);
                                            pLeviathan->DisappearAndDie();
                                            pVX_001->DisappearAndDie();
                                            pAerialUnit->DisappearAndDie();
                                            DespawnCreatures(34050, 100);
                                            me->Kill(me, false);
                                            checkBotAlive = true;
                                        }
                }
            }

            if (phase == PHASE_INTRO)
            {
                if (uiPhase_timer <= diff)
                {
                    switch (uiStep)
                    {
                    case 1:
                        if (MimironHardMode)
                            DoScriptText(SAY_HARDMODE_ON, me);
                        else
                            DoScriptText(SAY_AGGRO, me);
                        JumpToNextStep(10000);
                        break;
                    case 2:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                me->EnterVehicle(pLeviathan->GetVehicleKit(), 4);
                        JumpToNextStep(2000);
                        break;
                    case 3:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                me->EnterVehicle(pLeviathan->GetVehicleKit(), 2);
                        JumpToNextStep(2000);
                        break;
                    case 4:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                me->EnterVehicle(pLeviathan->GetVehicleKit(), 5);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                        JumpToNextStep(2500);
                        break;
                    case 5:
                        DoScriptText(SAY_MKII_ACTIVATE, me);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                        JumpToNextStep(6000);
                        break;
                    case 6:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                me->EnterVehicle(pLeviathan->GetVehicleKit(), 6);
                        JumpToNextStep(2000);
                        break;
                    case 7:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                            {
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                                pLeviathan->AI()->DoAction(DO_START_ENCOUNTER);
                                phase = PHASE_COMBAT;
                            }
                    default:
                        break;
                    }
                }
                else
                    uiPhase_timer -= diff;
            }
            
            if (phase == PHASE_VX001_ACTIVATION)
            {
                if (uiPhase_timer <= diff)
                {
                    switch (uiStep)
                    {
                    case 1:
                        DoScriptText(SAY_MKII_DEATH, me);
                        JumpToNextStep(10000);
                        break;
                    case 2:
                        if (pInstance)
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                me->EnterVehicle(pLeviathan->GetVehicleKit(), 1);
                        JumpToNextStep(2000);
                        break;
                    case 3:
                        if (pInstance)
                            pInstance->SetData(DATA_MIMIRON_ELEVATOR, GO_STATE_READY);
                        JumpToNextStep(5000);
                        break;
                    case 4:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                            {
                                pInstance->SetData(DATA_MIMIRON_ELEVATOR, GO_STATE_ACTIVE_ALTERNATIVE);
                                pVX_001->SetVisibility(VISIBILITY_ON);
                                if (Creature* Rocket1 = me->SummonCreature(34050, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN))
                                    Rocket1->EnterVehicle(pVX_001->GetVehicleKit(), 5);
                                if (Creature* Rocket2 = me->SummonCreature(34050, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN))
                                    Rocket2->EnterVehicle(pVX_001->GetVehicleKit(), 6);
                            }
                        JumpToNextStep(8000);
                        break;
                    case 5:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                me->EnterVehicle(pVX_001->GetVehicleKit(), 0);
                        JumpToNextStep(3500);
                        break;
                    case 6:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                        DoScriptText(SAY_VX001_ACTIVATE, me);
                        JumpToNextStep(10000);
                        break;
                    case 7:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                me->EnterVehicle(pVX_001->GetVehicleKit(), 1);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SIT);
                        JumpToNextStep(2000);
                        break;
                    case 8:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                pVX_001->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        JumpToNextStep(3500);
                        break;
                    case 9:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                            {
                                pVX_001->AddAura(SPELL_HOVER, pVX_001); // Hover
                                pVX_001->AI()->DoAction(DO_START_VX001);
                                phase = PHASE_COMBAT;
                            }
                        break;
                    default:
                        break;
                    }
                }
                else
                    uiPhase_timer -= diff;
            }
            
            if (phase == PHASE_AERIAL_ACTIVATION)
            {
                if (uiPhase_timer <= diff)
                {
                    switch (uiStep)
                    {
                    case 1:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                me->EnterVehicle(pVX_001->GetVehicleKit(), 4);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                        JumpToNextStep(2500);
                        break;
                    case 2:
                        DoScriptText(SAY_VX001_DEATH, me);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                        JumpToNextStep(5000);
                        break;
                    case 3:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                        if (pInstance)
                            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                                pAerialUnit->SetVisibility(VISIBILITY_ON);
                        JumpToNextStep(5000);
                        break;
                    case 4:
                        me->ExitVehicle();
                        me->GetMotionMaster()->MoveJump(2745.06f, 2569.36f, 379.90f, 10, 15);
                        JumpToNextStep(2000);
                        break;
                    case 5:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                        DoScriptText(SAY_AERIAL_ACTIVATE, me);
                        JumpToNextStep(8000);
                        break;
                    case 6:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                        me->SetVisibility(VISIBILITY_OFF);
                        if (pInstance)
                            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                            {
                                pAerialUnit->AI()->DoAction(DO_START_AERIAL);
                                phase = PHASE_COMBAT;
                            }
                        break;
                    default:
                        break;
                    }
                }
                else
                    uiPhase_timer -= diff;
            }
            
            if (phase == PHASE_V0L7R0N_ACTIVATION)
            {
                if (uiPhase_timer <= diff)
                {
                    switch (uiStep)
                    {
                    case 1:
                        if (pInstance)
                        {
                            me->SetVisibility(VISIBILITY_ON);
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                               pLeviathan->GetMotionMaster()->MovePoint(0, 2744.65f, 2569.46f, 364.397f);
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                            {
                                me->EnterVehicle(pVX_001->GetVehicleKit(), 1);
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                                DoScriptText(SAY_AERIAL_DEATH, me);
                            }
                        }
                        JumpToNextStep(5000);
                        break;
                    case 2:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                {
                                    pVX_001->SetStandState(UNIT_STAND_STATE_STAND);
                                    pVX_001->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_01);
                                    pVX_001->EnterVehicle(pLeviathan->GetVehicleKit(), 7);
                                }
                        JumpToNextStep(2000);
                        break;
                    case 3:
                        if (pInstance)
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                                {
                                    pAerialUnit->SetFlying(false);
                                    pAerialUnit->EnterVehicle(pVX_001->GetVehicleKit(), 3);
                                    DoScriptText(SAY_V07TRON_ACTIVATE, me);
                                }
                        JumpToNextStep(10000);
                        break;
                    case 4:
                        if (pInstance)
                        {
                            if (Creature *pLeviathan = Creature::GetCreature((*me), pInstance->GetData64(DATA_LEVIATHAN_MK_II)))
                                pLeviathan->AI()->DoAction(DO_LEVIATHAN_ASSEMBLED);
                            if (Creature *pVX_001 = Creature::GetCreature((*me), pInstance->GetData64(DATA_VX_001)))
                                pVX_001->AI()->DoAction(DO_VX001_ASSEMBLED);
                            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                                pAerialUnit->AI()->DoAction(DO_AERIAL_ASSEMBLED);
                            phase = PHASE_COMBAT;
                        }
                        break;
                    default:
                        break;
                    }
                }
                else
                    uiPhase_timer -= diff;
            }
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
            case DO_ACTIVATE_VX001:
                phase = PHASE_VX001_ACTIVATION;
                uiStep = 0;
                uiPhase_timer = -1;
                JumpToNextStep(100);
                break;
            case DO_ACTIVATE_AERIAL:
                phase = PHASE_AERIAL_ACTIVATION;
                uiStep = 0;
                uiPhase_timer = -1;
                JumpToNextStep(5000);
                break;
            case DO_ACTIVATE_V0L7R0N:
                phase = PHASE_V0L7R0N_ACTIVATION;
                uiStep = 0;
                uiPhase_timer = -1;
                JumpToNextStep(1000);
                break;
            case DO_ACTIVATE_DEATH_TIMER:
                checkBotAlive = false;
                break;
            case DO_ACTIVATE_HARD_MODE:
                MimironHardMode = true;
                DoZoneInCombat();
                break;
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

class boss_leviathan_mk : public CreatureScript
{
public:
    boss_leviathan_mk() : CreatureScript("boss_leviathan_mk") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_leviathan_mkAI (pCreature);
    }

    struct boss_leviathan_mkAI : public BossAI
    {
        boss_leviathan_mkAI(Creature *pCreature) : BossAI(pCreature, BOSS_MIMIRON), pVehicle(me->GetVehicleKit()), phase(PHASE_NULL)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
            me->ApplySpellImmune(0, IMMUNITY_ID, 63041, true); // Rocket Strike immunity
        }
        InstanceScript *pInstance;
        Phases phase;
        Vehicle *pVehicle;

        EventMap events;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetReactState(REACT_PASSIVE);
            me->RemoveAllAuras();
            phase = PHASE_NULL;
            events.SetPhase(PHASE_NULL);
            if (Creature *turret = CAST_CRE(me->GetVehicleKit()->GetPassenger(3)))
                turret->AI()->EnterEvadeMode();
        }

        void KilledUnit(Unit *who)
        {
            if (!(rand()%5))
                if (pInstance)
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                    {
                        if (phase == PHASE_LEVIATHAN_SOLO)
                            DoScriptText(RAND(SAY_MKII_SLAY_1, SAY_MKII_SLAY_2), pMimiron);
                        else
                            DoScriptText(RAND(SAY_V07TRON_SLAY_1, SAY_V07TRON_SLAY_2), pMimiron);
                    }
        }

        void DamageTaken(Unit *who, uint32 &damage)
        {
            if (phase == PHASE_LEVIATHAN_SOLO)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->AttackStop();
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    events.SetPhase(PHASE_NULL);
                    phase = PHASE_NULL;
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_VX001);
                    if (Creature *turret = CAST_CRE(me->GetVehicleKit()->GetPassenger(3)))
                        turret->Kill(turret, false);
                    me->SetSpeed(MOVE_RUN, 1.5f, true);
                    me->GetMotionMaster()->MovePoint(0, 2790.11f, 2595.83f, 364.32f);
                }
                
            if (phase == PHASE_LEVIATHAN_ASSEMBLED)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->AttackStop();
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    events.SetPhase(PHASE_NULL);
                    phase = PHASE_NULL;
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_DEATH_TIMER);
                }
        }

        void EnterCombat(Unit *who)
        {
            if (MimironHardMode)
            {
                DoCast(me, SPELL_EMERGENCY_MODE);
                events.ScheduleEvent(EVENT_FLAME_SUPPRESSANT, 60000, 0, PHASE_LEVIATHAN_SOLO);
            }

            events.ScheduleEvent(EVENT_PROXIMITY_MINE, 1000);
            events.ScheduleEvent(EVENT_PLASMA_BLAST, 10000, 0, PHASE_LEVIATHAN_SOLO);
            
            if (Creature *turret = CAST_CRE(me->GetVehicleKit()->GetPassenger(3)))
                turret->AI()->DoZoneInCombat();
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
                case DO_START_ENCOUNTER:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    phase = PHASE_LEVIATHAN_SOLO;
                    events.SetPhase(PHASE_LEVIATHAN_SOLO);
                    DoZoneInCombat();
                    break;
                case DO_LEVIATHAN_ASSEMBLED:
                    if (MimironHardMode)
                        DoCast(me, SPELL_EMERGENCY_MODE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetHealth(int32(me->GetMaxHealth() / 2));
                    me->SetSpeed(MOVE_RUN, 1.0f, true);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    phase = PHASE_LEVIATHAN_ASSEMBLED;
                    events.SetPhase(PHASE_LEVIATHAN_ASSEMBLED);
                    events.RescheduleEvent(EVENT_PROXIMITY_MINE, 1000);
                    events.RescheduleEvent(EVENT_SHOCK_BLAST, 30000);
                    break;
                case DO_ENTER_ENRAGE:
                    DoCast(me, SPELL_BERSERK, true);
                    break;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            events.Update(diff);

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            if (phase == PHASE_LEVIATHAN_SOLO || phase == PHASE_LEVIATHAN_ASSEMBLED)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_PROXIMITY_MINE:
                            for (int i = 0; i < 10; i++)
                                DoCast(SPELL_MINES_SPAWN);
                            DoCast(SPELL_PROXIMITY_MINES);
                            events.RescheduleEvent(EVENT_PROXIMITY_MINE, 35000);
                            break;
                        case EVENT_PLASMA_BLAST:
                            me->MonsterTextEmote(EMOTE_LEVIATHAN, 0, true);
                            DoCast(RAID_MODE(SPELL_PLASMA_BLAST_10, SPELL_PLASMA_BLAST_25));
                            events.RescheduleEvent(EVENT_PLASMA_BLAST, urand(30000, 35000), 0, PHASE_LEVIATHAN_SOLO);
                            events.RescheduleEvent(EVENT_SHOCK_BLAST, urand(6000, 10000));
                            break;
                        case EVENT_SHOCK_BLAST:
                            DoCastAOE(SPELL_SHOCK_BLAST);
                            events.RescheduleEvent(EVENT_SHOCK_BLAST, 35000);
                            break;
                        case EVENT_FLAME_SUPPRESSANT:
                            DoCastAOE(SPELL_FLAME_SUPPRESSANT_1);
                            std::list<Creature*> m_pCreatures;
                            GetCreatureListWithEntryInGrid(m_pCreatures, me, NPC_FLAME, 100);
                            if (!m_pCreatures.empty())
                                for(std::list<Creature*>::iterator iter = m_pCreatures.begin(); iter != m_pCreatures.end(); ++iter)
                                    (*iter)->ForcedDespawn(3000);
                            events.CancelEvent(EVENT_FLAME_SUPPRESSANT);
                            break;
                    }
                }
            }
                        
            DoMeleeAttackIfReady();
        }
    };
};

class boss_leviathan_mk_turret : public CreatureScript
{
public:
    boss_leviathan_mk_turret() : CreatureScript("boss_leviathan_mk_turret") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_leviathan_mk_turretAI (pCreature);
    }

    struct boss_leviathan_mk_turretAI : public ScriptedAI
    {
        boss_leviathan_mk_turretAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }
        InstanceScript *pInstance;

        uint32 uiNapalmShell;

        void Reset()
        {
            uiNapalmShell = urand(8000, 10000);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            me->DeleteThreatList();
        }
        
        void EnterCombat(Unit *who)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if (uiNapalmShell <= diff)
            {
                if (Unit *pTarget = SelectUnit(SELECT_TARGET_FARTHEST, 0))
                    DoCast(pTarget, RAID_MODE(SPELL_NAPALM_SHELL_10, SPELL_NAPALM_SHELL_25));
                uiNapalmShell = urand(10000, 15000);
            }
            else
                uiNapalmShell -= diff;
        }
    };
};

class mob_proximity_mine : public CreatureScript
{
public:
    mob_proximity_mine() : CreatureScript("mob_proximity_mine") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_proximity_mineAI (pCreature);
    }

    struct mob_proximity_mineAI : public ScriptedAI
    {
        mob_proximity_mineAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
           me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
           uiBoomTimer = 35000;
           Boom = false;
        }
        
        uint32 uiBoomTimer;
        bool Boom;

        void MoveInLineOfSight(Unit *who)
        {
            if (!Boom && me->IsWithinDistInMap(who, 0.5f) && who->GetTypeId() == TYPEID_PLAYER)
            {
                DoCastAOE(RAID_MODE(SPELL_EXPLOSION_10, SPELL_EXPLOSION_25));
                me->ForcedDespawn(1000);
                Boom = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        void UpdateAI(const uint32 diff)
        {
            if (uiBoomTimer <= diff)
            {
                if (!Boom)
                {
                    DoCastAOE(RAID_MODE(SPELL_EXPLOSION_10, SPELL_EXPLOSION_25));
                    me->ForcedDespawn(1000);
                    Boom = true;
                }
            }
            else uiBoomTimer -= diff;
        }
    };
};

class boss_vx_001 : public CreatureScript
{
public:
    boss_vx_001() : CreatureScript("boss_vx_001") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_vx_001AI (pCreature);
    }

    struct boss_vx_001AI : public BossAI
    {
        boss_vx_001AI(Creature *pCreature) : BossAI(pCreature, BOSS_MIMIRON), pVehicle(me->GetVehicleKit()), phase(PHASE_NULL)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
            me->ApplySpellImmune(0, IMMUNITY_ID, 63041, true); // Rocket Strike immunity
        }
        InstanceScript *pInstance;
        Phases phase;
        Vehicle *pVehicle;

        EventMap events;
        uint8 RapidBurst;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
            me->RemoveAllAuras();
            phase = PHASE_NULL;
            events.SetPhase(PHASE_NULL);
            RapidBurst = 0;
        }

        void KilledUnit(Unit *who)
        {
            if (!(rand()%5))
                if (pInstance)
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                    {
                        if (phase == PHASE_VX001_SOLO)
                            DoScriptText(RAND(SAY_VX001_SLAY_1, SAY_VX001_SLAY_2), pMimiron);
                        else
                            DoScriptText(RAND(SAY_V07TRON_SLAY_1, SAY_V07TRON_SLAY_2), pMimiron);
                    }
        }

        void EnterCombat(Unit *who)
        {
            if (MimironHardMode)
            {
                DoCast(me, SPELL_EMERGENCY_MODE);
                events.ScheduleEvent(EVENT_FROST_BOMB, 15000);
            }
                
            events.ScheduleEvent(EVENT_RAPID_BURST, 500, 0, PHASE_VX001_SOLO);
            events.ScheduleEvent(EVENT_PRE_LASER_BARRAGE, urand(35000, 40000), 0, PHASE_VX001_SOLO); // Not works in phase 4 :(
            events.ScheduleEvent(EVENT_ROCKET_STRIKE, 20000);
            events.ScheduleEvent(EVENT_HEAT_WAVE, urand(8000, 10000), 0, PHASE_VX001_SOLO);
            events.ScheduleEvent(EVENT_HAND_PULSE, 15000, 0, PHASE_VX001_ASSEMBLED);
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
                case DO_START_VX001:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    phase = PHASE_VX001_SOLO;
                    events.SetPhase(PHASE_VX001_SOLO);
                    DoZoneInCombat();
                    break;
                case DO_VX001_ASSEMBLED:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetHealth(int32(me->GetMaxHealth() / 2));
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    phase = PHASE_VX001_ASSEMBLED;
                    events.SetPhase(PHASE_VX001_ASSEMBLED);
                    events.RescheduleEvent(EVENT_PRE_LASER_BARRAGE, urand(35000, 40000), 0, PHASE_VX001_SOLO); // not works in phase 4
                    events.RescheduleEvent(EVENT_ROCKET_STRIKE, 20000);
                    events.RescheduleEvent(EVENT_HAND_PULSE, 15000, 0, PHASE_VX001_ASSEMBLED);
                    if (MimironHardMode)
                    {
                        DoCast(me, SPELL_EMERGENCY_MODE);
                        events.RescheduleEvent(EVENT_FROST_BOMB, 15000);
                    }
                    break;
                case DO_ENTER_ENRAGE:
                    DoCast(me, SPELL_BERSERK, true);
                    break;
            }
        }

        void DamageTaken(Unit *who, uint32 &damage)
        {
            if (phase == PHASE_VX001_SOLO)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->AttackStop();
                    me->GetMotionMaster()->Initialize();
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    phase = PHASE_NULL;
                    events.SetPhase(PHASE_NULL);
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_AERIAL);
                }
                
            if (phase == PHASE_VX001_ASSEMBLED)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->AttackStop();
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    events.SetPhase(PHASE_NULL);
                    phase = PHASE_NULL;
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_DEATH_TIMER);
                }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            events.Update(diff);

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            if (phase == PHASE_VX001_SOLO || phase == PHASE_VX001_ASSEMBLED)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_RAPID_BURST:
                            me->GetMotionMaster()->Initialize();
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                if (Creature *BurstTarget = me->SummonCreature(NPC_BURST_TARGET, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 3000))
                                    DoCast(BurstTarget, SPELL_RAPID_BURST);
                            events.RescheduleEvent(EVENT_RAPID_BURST, 3000, 0, PHASE_VX001_SOLO);
                            break;
                        case EVENT_PRE_LASER_BARRAGE:
                            DoCast(SPELL_SPINNING_UP);
                            me->GetMotionMaster()->MoveRotate(40000, rand()%2 ? ROTATE_DIRECTION_LEFT : ROTATE_DIRECTION_RIGHT);
                            events.DelayEvents(14000);
                            events.RescheduleEvent(EVENT_PRE_LASER_BARRAGE, 40000, 0, PHASE_VX001_SOLO);
                            events.RescheduleEvent(EVENT_LASER_BARRAGE, 3000);
                            break;
                        case EVENT_LASER_BARRAGE:
                            DoCastAOE(SPELL_LASER_BARRAGE);
                            events.CancelEvent(EVENT_LASER_BARRAGE);
                            break;
                        case EVENT_ROCKET_STRIKE:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                if (Creature *missile = CAST_CRE(me->GetVehicleKit()->GetPassenger(5)))
                                    missile->CastSpell(pTarget, SPELL_ROCKET_STRIKE, true);
                            if (phase == PHASE_VX001_ASSEMBLED)
                                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                    if (Creature *missile = CAST_CRE(me->GetVehicleKit()->GetPassenger(6)))
                                        missile->CastSpell(pTarget, SPELL_ROCKET_STRIKE, true);
                            events.RescheduleEvent(EVENT_ROCKET_STRIKE, urand(20000, 25000));
                            break;
                        case EVENT_HEAT_WAVE:
                            DoCastAOE(RAID_MODE(SPELL_HEAT_WAVE_10, SPELL_HEAT_WAVE_25));
                            events.RescheduleEvent(EVENT_HEAT_WAVE, 10000, 0, PHASE_VX001_SOLO);
                            break;
                        case EVENT_HAND_PULSE:
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                DoCast(pTarget, RAID_MODE(SPELL_HAND_PULSE_10, SPELL_HAND_PULSE_25));
                            events.RescheduleEvent(EVENT_HAND_PULSE, urand(10000, 12000));
                            break;
                        case EVENT_FROST_BOMB:
                            me->SummonCreature(NPC_FROST_BOMB, SummonPos[rand()%9], TEMPSUMMON_MANUAL_DESPAWN);
                            events.RescheduleEvent(EVENT_FROST_BOMB, 45000);
                            break;
                    }
                }
            }
        }
    };
};

class rocket_strike : public CreatureScript
{
public:
    rocket_strike() : CreatureScript("rocket_strike") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new rocket_strikeAI (pCreature);
    }

    struct rocket_strikeAI : public ScriptedAI
    {
        rocket_strikeAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            me->ForcedDespawn(10000);
            DoCast(me, SPELL_ROCKET_STRIKE_AURA);
        }
    };
};

class boss_aerial_unit : public CreatureScript
{
public:
    boss_aerial_unit() : CreatureScript("boss_aerial_unit") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_aerial_unitAI (pCreature);
    }

    struct boss_aerial_unitAI : public BossAI
    {
        boss_aerial_unitAI(Creature *pCreature) : BossAI(pCreature, BOSS_MIMIRON), pVehicle(me->GetVehicleKit()), phase(PHASE_NULL)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
            me->ApplySpellImmune(0, IMMUNITY_ID, 63041, true); // Rocket Strike immunity
        }
        InstanceScript *pInstance;
        Phases phase;
        Vehicle *pVehicle;

        EventMap events;
        uint8 spawnedAdds;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveAllAuras();
            me->SetFlying(true);
            phase = PHASE_NULL;
            events.SetPhase(PHASE_NULL);
            summons.DespawnAll();
            spawnedAdds = 0;
        }

        void KilledUnit(Unit *who)
        {
            if (!(rand()%5))
                if (pInstance)
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                    {
                        if (phase == PHASE_AERIAL_SOLO)
                            DoScriptText(RAND(SAY_AERIAL_SLAY_1, SAY_AERIAL_SLAY_2), pMimiron);
                        else
                            DoScriptText(RAND(SAY_V07TRON_SLAY_1, SAY_V07TRON_SLAY_2), pMimiron);
                    }
        }

        void EnterCombat(Unit *who)
        {
            if (MimironHardMode)
                DoCast(me, SPELL_EMERGENCY_MODE);

            events.ScheduleEvent(EVENT_PLASMA_BALL, 1000);
            events.ScheduleEvent(EVENT_SUMMON_BOTS, 10000, 0, PHASE_AERIAL_SOLO);
        }
        
        void DoAction(const int32 action)
        {
            switch(action)
            {
                case DO_START_AERIAL:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    phase = PHASE_AERIAL_SOLO;
                    events.SetPhase(PHASE_AERIAL_SOLO);
                    DoZoneInCombat();
                    break;
                case DO_DISABLE_AERIAL:
                    me->CastStop();
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->Clear(true);
                    DoCast(me, SPELL_MAGNETIC_CORE);
                    DoCast(me, SPELL_MAGNETIC_CORE_VISUAL);
                    if (Creature *pMagneticCore = Creature::GetCreature((*me), pInstance->GetData64(DATA_MAGNETIC_CORE)))
                        if (pMagneticCore->isAlive())
                            me->NearTeleportTo(pMagneticCore->GetPositionX(), pMagneticCore->GetPositionY(), 368.965f, 0, false);
                    events.RescheduleEvent(EVENT_PLASMA_BALL, 22000, 0, PHASE_AERIAL_SOLO);
                    events.RescheduleEvent(EVENT_SUMMON_BOTS, 24000, 0, PHASE_AERIAL_SOLO);
                    events.ScheduleEvent(EVENT_REACTIVATE_AERIAL, 20000, 0, PHASE_AERIAL_SOLO);
                    break;
                case DO_AERIAL_ASSEMBLED:
                    if (MimironHardMode)
                        DoCast(me, SPELL_EMERGENCY_MODE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetHealth(int32(me->GetMaxHealth() / 2));
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    phase = PHASE_AERIAL_ASSEMBLED;
                    events.SetPhase(PHASE_AERIAL_ASSEMBLED);
                    events.RescheduleEvent(EVENT_PLASMA_BALL, 2000);
                    break;
                case DO_ENTER_ENRAGE:
                    DoCast(me, SPELL_BERSERK, true);
                    break;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            events.Update(diff);

            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            if (phase == PHASE_AERIAL_SOLO || phase == PHASE_AERIAL_ASSEMBLED)
            {
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch(eventId)
                    {
                        case EVENT_PLASMA_BALL:
                            if (phase == PHASE_AERIAL_SOLO && me->getVictim())
                            {
                                float x = me->getVictim()->GetPositionX();
                                float y = me->getVictim()->GetPositionY();
                                float z = me->getVictim()->GetPositionZ();
                                if (me->IsWithinDist3d(x, y, z, 30))
                                {
                                    me->GetMotionMaster()->Initialize();
                                    DoCastVictim(RAID_MODE(SPELL_PLASMA_BALL_10, SPELL_PLASMA_BALL_25));
                                }
                                else me->GetMotionMaster()->MovePoint(0, x, y, 380.040f);
                            }
                            else if (phase == PHASE_AERIAL_ASSEMBLED && me->getVictim())
                            {
                                if (me->getVictim()->IsWithinDist3d(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 35))
                                    DoCastVictim(RAID_MODE(SPELL_PLASMA_BALL_10, SPELL_PLASMA_BALL_25));
                                else if (Unit *pTarget = SelectUnit(SELECT_TARGET_NEAREST, 0))
                                    DoCast(pTarget, RAID_MODE(SPELL_PLASMA_BALL_10, SPELL_PLASMA_BALL_25));
                            }
                            events.RescheduleEvent(EVENT_PLASMA_BALL, 2000);
                            break;
                        case EVENT_REACTIVATE_AERIAL:
                            me->RemoveAurasDueToSpell(SPELL_MAGNETIC_CORE_VISUAL);
                            me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), 380.040f, 3.14159f, false);
                            me->SetReactState(REACT_AGGRESSIVE);
                            events.CancelEvent(EVENT_REACTIVATE_AERIAL);
                            break;
                        case EVENT_SUMMON_BOTS:
                            if (phase == PHASE_AERIAL_SOLO)
                            {
                                spawnAdd();
                                events.RescheduleEvent(EVENT_SUMMON_BOTS, 10000, 0, PHASE_AERIAL_SOLO);
                            }
                        break;
                    }
                }
            }
        }
        
        void spawnAdd()
        {
            switch(spawnedAdds)
            {
                case 0:
                    for(uint8 n = 0; n < 2; n++)
                        me->SummonCreature(NPC_JUNK_BOT, SummonPos[rand()%9], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    break;
                case 1:
                    me->SummonCreature(NPC_ASSAULT_BOT, SummonPos[rand()%9], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                    if (MimironHardMode)
                        for (uint8 i = 0; i < 2; ++i)
                            me->SummonCreature(NPC_EMERGENCY_BOT, SummonPos[rand()%9], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    break;
                case 2:
                    me->SummonCreature(NPC_BOOM_BOT, 2744.65f, 2569.46f, 364.397f, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                    break;
            }

            spawnedAdds++;
            if(spawnedAdds > 2)
            {
                spawnedAdds = 0;
            }
        }
        
        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
            if (summon->GetEntry() != NPC_EMERGENCY_BOT)
            {
                summon->AI()->AttackStart(me->getVictim());
                summon->AI()->DoZoneInCombat();
            }
        }
        
        void DamageTaken(Unit *who, uint32 &damage)
        {
            if (phase == PHASE_AERIAL_SOLO)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->GetMotionMaster()->Clear(true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    events.CancelEvent(EVENT_SUMMON_BOTS);
                    phase = PHASE_NULL;
                    events.SetPhase(PHASE_NULL);
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_V0L7R0N);
                }
                
            if (phase == PHASE_AERIAL_ASSEMBLED)
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->AttackStop();
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    me->SetHealth(me->GetMaxHealth());
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    events.SetPhase(PHASE_NULL);
                    phase = PHASE_NULL;
                    if (Creature *pMimiron = Creature::GetCreature((*me), pInstance->GetData64(DATA_MIMIRON)))
                        pMimiron->AI()->DoAction(DO_ACTIVATE_DEATH_TIMER);
                }
        }
    };
};

class magnetic_core : public CreatureScript
{
public:
    magnetic_core() : CreatureScript("magnetic_core") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new magnetic_coreAI (pCreature);
    }

    struct magnetic_coreAI : public ScriptedAI
    {
        magnetic_coreAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            DoCast(SPELL_MAGNETIC_CORE);
            pInstance = pCreature->GetInstanceScript();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            me->ForcedDespawn(21000);
            if (Creature *pAerialUnit = Creature::GetCreature((*me), pInstance->GetData64(DATA_AERIAL_UNIT)))
                if (pAerialUnit->isAlive())
                    //if (pAerialUnit->IsWithinDist2d(me->GetPositionX(), me->GetPositionY(), 10))
                        pAerialUnit->AI()->DoAction(DO_DISABLE_AERIAL);
        }
        InstanceScript *pInstance;
    };
};

class mob_boom_bot : public CreatureScript
{
public:
    mob_boom_bot() : CreatureScript("mob_boom_bot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_boom_botAI (pCreature);
    }

    struct mob_boom_botAI : public ScriptedAI
    {
        mob_boom_botAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            if (MimironHardMode)
                DoCast(me, SPELL_EMERGENCY_MODE);
        }

        InstanceScript* m_pInstance;

        void JustDied(Unit *victim)
        {
            DoCast(me, SPELL_BOOM_BOT);
        }
    };
};

class mob_junk_bot : public CreatureScript
{
public:
    mob_junk_bot() : CreatureScript("mob_junk_bot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_junk_botAI (pCreature);
    }

    struct mob_junk_botAI : public ScriptedAI
    {
        mob_junk_botAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            if (MimironHardMode)
                DoCast(me, SPELL_EMERGENCY_MODE);
        }
    };
};

class mob_assault_bot : public CreatureScript
{
public:
    mob_assault_bot() : CreatureScript("mob_assault_bot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_assault_botAI (pCreature);
    }

    struct mob_assault_botAI : public ScriptedAI
    {
        mob_assault_botAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();

            if (MimironHardMode)
                DoCast(me, SPELL_EMERGENCY_MODE);

            uiFieldTimer = urand(4000, 6000);
        }
        
        InstanceScript* pInstance;
        uint32 uiFieldTimer;
        
        void UpdateAI(const uint32 diff)
        {
            if (uiFieldTimer <= diff)
            {
                DoCastVictim(SPELL_MAGNETIC_FIELD);
                uiFieldTimer = urand(15000, 20000);
            }
            else uiFieldTimer -= diff;
            
            DoMeleeAttackIfReady();
        }
        
        void SpellHit(Unit *caster, const SpellEntry *spell)
        {
            // Achievement Not-So-Friendly Fire
            if (spell->Id == 63041)
                pInstance->DoCompleteAchievement(ACHIEVEMENT_NOT_SO_FRIENDLY_FIRE);
        }
    };
};

class mob_emergency_bot : public CreatureScript
{
public:
    mob_emergency_bot() : CreatureScript("mob_emergency_bot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_emergency_botAI (pCreature);
    }

    struct mob_emergency_botAI : public ScriptedAI
    {
        mob_emergency_botAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->MoveRandom(15);
            uiSprayTimer = 5000;
        }
        
        uint32 uiSprayTimer;
        
        void UpdateAI(const uint32 diff)
        {
            if (uiSprayTimer <= diff)
            {
                DoCast(SPELL_WATER_SPRAY);
                std::list<Creature*> m_pCreatures;
                GetCreatureListWithEntryInGrid(m_pCreatures, me, NPC_FLAME, 12);
                if (!m_pCreatures.empty())
                    for(std::list<Creature*>::iterator iter = m_pCreatures.begin(); iter != m_pCreatures.end(); ++iter)
                        (*iter)->ForcedDespawn();
                uiSprayTimer = 5000;
            }
            else uiSprayTimer -= diff;
        }
    };
};

class GOHello_not_push_button : public GameObjectScript
{
public:

    GOHello_not_push_button()
        : GameObjectScript("not_push_button") {}

    bool OnGossipHello(Player* player, GameObject* pGo)
    {
        InstanceScript* pInstance = pGo->GetInstanceScript();

        if (!pInstance)
            return false;

        if (pInstance->GetBossState(BOSS_MIMIRON) == NOT_STARTED)
            if (Creature *pMimiron = Creature::GetCreature((*pGo), pInstance->GetData64(DATA_MIMIRON)))
                pMimiron->AI()->DoAction(DO_ACTIVATE_HARD_MODE);
            
        return true;
    }
};

class mob_mimiron_flame : public CreatureScript
{
public:
    mob_mimiron_flame() : CreatureScript("mob_mimiron_flame") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_mimiron_flameAI (pCreature);
    }

    struct mob_mimiron_flameAI : public ScriptedAI
    {
        mob_mimiron_flameAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            DoCast(me, SPELL_FLAME);
        }
    };
};

class mob_frost_bomb : public CreatureScript
{
public:
    mob_frost_bomb() : CreatureScript("mob_frost_bomb") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_frost_bombAI (pCreature);
    }

    struct mob_frost_bombAI : public ScriptedAI
    {
        mob_frost_bombAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            DoCast(me, SPELL_FROST_BOMB);
            uiFrostTimer = 10000;
        }
        
        uint32 uiFrostTimer;
        
        void UpdateAI(const uint32 diff)
        {
            if (uiFrostTimer <= diff)
            {
                DoCastAOE(SPELL_FLAME_SUPPRESSANT_2);
                std::list<Creature*> m_pCreatures;
                GetCreatureListWithEntryInGrid(m_pCreatures, me, NPC_FLAME, 25);
                if (!m_pCreatures.empty())
                    for(std::list<Creature*>::iterator iter = m_pCreatures.begin(); iter != m_pCreatures.end(); ++iter)
                        (*iter)->ForcedDespawn();
                me->ForcedDespawn(1000);
                uiFrostTimer = 10000;
            }
            else uiFrostTimer -= diff;
        }
    };
};

void AddSC_boss_mimiron()
{
    new boss_mimiron();
    new boss_leviathan_mk();
    new boss_leviathan_mk_turret();
    new mob_proximity_mine();
    new boss_vx_001();
    new rocket_strike();
    new boss_aerial_unit();
    new magnetic_core();
    new mob_boom_bot();
    new mob_junk_bot();
    new mob_assault_bot();
    new mob_emergency_bot();
    new GOHello_not_push_button();
    new mob_mimiron_flame();
    new mob_frost_bomb();
}