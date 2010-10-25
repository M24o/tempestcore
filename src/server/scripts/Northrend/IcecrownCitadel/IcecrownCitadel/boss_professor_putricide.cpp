/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * Copyright (C) 2010 Bolvor <http://bitbucket.org/bolvor/icecrown-citadel/>
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

/*
*Need implantet Tentacle stalker
*Need implantet heroic mode
*Need correct ozze and gas mechanic
*Need correct bomb mechanic
*/

#include "ScriptPCH.h"
#include "icecrown_citadel.h"

enum eBrothersYells
{
    SAY_FESTERGUT_GASEOUS_BLIGHT = -1631080,
    SAY_FESTERGUT_DEATH          = -1631090,

    SAY_ROTFACE_DEATH            = -1666025
};

enum eBrothersSpells
{
    SPELL_RELEASE_GAS_VISUAL    = 69125,
    SPELL_MALLABLE_GOO_H        = 70852,

    SPELL_OOZE_FLOOD_H          = 69783,
    SPELL_VILE_GAS              = 69240
};

enum Yells
{
    SAY_AGGRO       = -1666026,
    SAY_AIRLOCK     = -1666027,
    SAY_PHASE_HC    = -1666028,
    SAY_TRANSFORM_1 = -1666029,
    SAY_TRANSFORM_2 = -1666030,
    SAY_KILL_1      = -1666031,
    SAY_KILL_2      = -1666032,
    SAY_BERSERK     = -1666033,
    SAY_DEATH       = -1666034
};

enum Spells
{
    SPELL_UNSTABLE_EXPERIMENT   = 70351,
    SPELL_TEAR_GAS              = 71617,
    SPELL_CREATE_CONCOTION      = 71621,
    SPELL_GUZZLE_POTIONS        = 71893,
    SPELL_MALLEABLE_GOO         = 72296,
    SPELL_MUTATED_PLAGUE        = 72672,
    SPELL_OOZE_ERUPTION         = 70492,
    SPELL_VOLATILE_OOZE         = 72838,
    SPELL_CHOKING_GAS           = 71278,
    SPELL_SLIME_PUDDLE          = 70341,
    SPELL_SLIME_PUDDLE_AURA     = 70346,
    SPELL_CHOKING_GAS_EXPLOSION = 71279,
    SPELL_CHOKING_GAS_BOMB      = 71273,
    SPELL_CHOKING_GAS_AURA      = 71278,
    SPELL_SUMMON_OOZE           = 71413,
    SPELL_GASEOUS_BLOAT         = 70215,
    SPELL_GASEOUS_BLOAT_AURA    = 72455,
    SPELL_MUTATED               = 70405,
    SPELL_STRENGTH              = 71603,
    SPELL_ORANGE_RADIATION      = 45857,
    SPELL_PUDDLE_TRIGGER        = 71425,
    SPELL_HITTIN_PROC           = 71971,
    SPELL_OOZE_SEARCH_EFFECT    = 70457,
    SPELL_OOZE_FLOOD            = 69783,
    SPELL_GAS_FLOOD             = 71379
};

enum ePhases
{
    PHASE_FESTERGUT     = 1,
    PHASE_ROTFACE       = 2,
    PHASE_COMBAT        = 3,
    PHASE_READY         = 4,


    PHASE_MASK_NOT_SELF = (1 << PHASE_FESTERGUT) | (1 << PHASE_ROTFACE)
};

#define EMOTE_UNSTABLE_EXPERIMENT "Professor Putricide begins unstable experiment!"

static const Position festergutWatchPos = {4324.82f, 3166.03f, 389.3831f, 3.316126f};
static const Position rotfaceWatchPos = {4417.302246f, 3188.219971f, 389.332520f, 5.102f};
static const Position professorStartPos = {4356.779785f, 3263.510010f, 389.398010f, 1.586f};

const Position SpawnLoc[]=
{
    {4486.825f, 3211.986f, 404.385f, 0.0f},
    {4486.825f, 3111.452f, 389.385f, 0.0f},
    {4486.825f, 3213.452f, 404.385f, 0.0f},
    {4486.825f, 3213.452f, 389.385f, 0.0f}
};

static const uint32 gaseousBlight[3]        = {69157, 69162, 69164};

class boss_professor_putricide : public CreatureScript
{
    public:
        boss_professor_putricide() : CreatureScript("boss_professor_putricide") { }

        struct boss_professor_putricideAI : public BossAI
        {
            boss_professor_putricideAI(Creature* pCreature) : BossAI(pCreature, DATA_PROFESSOR_PUTRICIDE)
            {
                pInstance = me->GetInstanceScript();
                phase = ePhases(0);
                PhaseSwitch1 = false;
                PhaseSwitch2 = false;
                fDie = false; //festergut die
                rDie = false; // rotface die
            }

            void Reset()
            {
                m_uiPhase = 1;
                m_uiUnstableExperimentTimer = 35000;
                m_uiPuddleTimer = 19000;
                m_uiMalleableTimer = 15000;
                m_uiPhaseSwitchTimer = 1000;
                m_uiBerserkTimer = 600000;
                m_uiBombTimer = 20000;

                experement = 1;
                phaseswitch = 0;
                stage = 1;
                count = RAID_MODE(1,2,1,2);

                fBaseSpeed = me->GetSpeedRate(MOVE_RUN);
                SetSonPhase(PHASE_READY);

                if (pInstance && me->isAlive())
                    pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                if(!pInstance)
                    return;

                pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, IN_PROGRESS);
                SetSonPhase(PHASE_COMBAT);
                DoScriptText(SAY_AGGRO, me);
                DoCast(me, SPELL_HITTIN_PROC);
            }

            void JustDied(Unit* /*pKiller*/)
            {
                DoScriptText(SAY_DEATH, me);

                if (pInstance)
                    pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, DONE);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                {
                    switch(rand()%1)
                    {
                        case 0: DoScriptText(SAY_KILL_1, me); break;
                        case 1: DoScriptText(SAY_KILL_2, me); break;
                    }
                }
            }

            void JustReachedHome()
            {
                if(pInstance)
                    pInstance->SetData(DATA_PROFESSOR_PUTRICIDE_EVENT, FAIL);
            }

            void JustSummoned(Creature* pSummoned)
            {
                if(pSummoned->GetEntry() != CREATURE_VOLATILE_OOZE || pSummoned->GetEntry() != CREATURE_GAS_CLOUD)
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                       pSummoned->AI()->AttackStart(pTarget);
            }

            void SetSonPhase(ePhases newPhase)
            {
                phase = newPhase;
                events.SetPhase(newPhase);
            }

            void DoAction(const int32 action)
            {
                switch (action)
                {
                    case ACTION_FESTERGUT_COMBAT:
                        SetSonPhase(PHASE_FESTERGUT);
                        me->SetSpeed(MOVE_RUN, fBaseSpeed*2.0f, true);
                        me->GetMotionMaster()->MovePoint(0, festergutWatchPos);
                        me->SetReactState(REACT_PASSIVE);
                        if (IsHeroic())
                        {
                            m_uiMalleableGooTimer = urand(16000, 20000);
                        }
                        break;
                    case ACTION_ROTFACE_COMBAT:
                        SetSonPhase(PHASE_ROTFACE);
                        me->SetSpeed(MOVE_RUN, fBaseSpeed*2.0f, true);
                        me->GetMotionMaster()->MovePoint(0, rotfaceWatchPos);
                        me->SetReactState(REACT_PASSIVE);
                        if (IsHeroic())
                        {
                            m_uiVileGasTimer = urand(16000, 20000);
                        }
                        break;
                    case ACTION_FESTERGUT_GAS:
                        DoScriptText(SAY_FESTERGUT_GASEOUS_BLIGHT, me);
                        if (Creature* bfestergut = Unit::GetCreature(*me, instance->GetData64(DATA_FESTERGUT)))
                        {
                            bfestergut->CastSpell(bfestergut, SPELL_RELEASE_GAS_VISUAL, false, NULL, NULL, me->GetGUID());
                        }
                        if (Creature* gasDummy = GetClosestCreatureWithEntry(me, CREATURE_ORANGE_GAS_STALKER, 500.0f, true))
                        {
                            for (uint8 i = 0; i < 3; ++i)
                            {
                                gasDummy->CastSpell(gasDummy,gaseousBlight[i], true);
                            }
                        }
                        break;
                    //case ACTION_ROTFACE_GAS:
                    case ACTION_FESTERGUT_DEATH:
                        m_uiSayDieTimer = 4000;
                        fDie = true;
                        break;
                    case ACTION_ROTFACE_DEATH:
                        m_uiSayDieTimer = 4000;
                        rDie = true;
                        break;
                    default:
                        break;
                    }
                }

            void SpawnAdds()
            {
                switch(experement)
                {
                case 1:
                    {
                        Creature* green_stalker = me->SummonCreature(CREATURE_PUDDLE_STALKER, SpawnLoc[0], TEMPSUMMON_TIMED_DESPAWN, 4000);
                        if(green_stalker)
                        {
                            green_stalker->CastSpell(green_stalker, SPELL_OOZE_FLOOD, true);
                            DoSummon(CREATURE_VOLATILE_OOZE, SpawnLoc[1]);
                        }
                    }
                    break;
                case 2:
                    {
                        Creature* orange_stalker = me->SummonCreature(CREATURE_PUDDLE_STALKER, SpawnLoc[2], TEMPSUMMON_TIMED_DESPAWN, 4000);
                        if(orange_stalker)
                        {
                            orange_stalker->CastSpell(orange_stalker, SPELL_GAS_FLOOD, true);
                            DoSummon(CREATURE_GAS_CLOUD, SpawnLoc[3]);
                        }
                    }
                }
            }

            void TwoAdds()
            {
                Creature* green_stalker = me->SummonCreature(CREATURE_PUDDLE_STALKER, SpawnLoc[0], TEMPSUMMON_TIMED_DESPAWN, 4000);//green
                if(green_stalker)
                {
                    green_stalker->CastSpell(green_stalker, SPELL_OOZE_FLOOD, true);
                    DoSummon(CREATURE_VOLATILE_OOZE, SpawnLoc[2]);
                }
                Creature* orange_stalker = me->SummonCreature(CREATURE_PUDDLE_STALKER, SpawnLoc[1], TEMPSUMMON_TIMED_DESPAWN, 4000);//orange
                if(orange_stalker)
                {
                    orange_stalker->CastSpell(orange_stalker, SPELL_GAS_FLOOD, true);
                    DoSummon(CREATURE_GAS_CLOUD, SpawnLoc[3]);
                }
            }

            void PhaseSwitch()
            {
                switch(phaseswitch)
                    {
                    case 0:
                        if (!IsHeroic())
                        {
                            Creature* gas_stalker = me->FindNearestCreature(CREATURE_TEAR_GAS_STALKER, 150.0f, true);
                            if(gas_stalker)
                            {
                                me->CastSpell(gas_stalker, SPELL_TEAR_GAS, true);
                            }
                        }
                        if (IsHeroic())
                        {
                            DoScriptText(SAY_PHASE_HC,me);
                            TwoAdds();
                        }
                        ++phaseswitch;
                        m_uiPhaseSwitchTimer = 4000;
                        break;
                    case 1:
                        me->GetMotionMaster()->MovePoint(0, professorStartPos);
                        ++phaseswitch;
                        m_uiPhaseSwitchTimer = 9000;
                        break;
                    case 2:
                    {
                        if(m_uiPhase == 1)
                        {
                            DoCast(SPELL_CREATE_CONCOTION);
                        }
                        if(m_uiPhase == 2)
                        {
                            DoCast(SPELL_GUZZLE_POTIONS);
                        }
                        m_uiPhaseSwitchTimer = 3000;
                        ++phaseswitch;
                    }
                    break;
                    case 3:
                        pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TEAR_GAS);
                        ++phaseswitch;
                        m_uiPhase = 2;
                        break;
                    }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (phase == PHASE_READY)
                    return;

                if(phase != PHASE_COMBAT)
                {
                    if(phase == PHASE_FESTERGUT)
                    {
                        if (m_uiMalleableGooTimer < uiDiff)
                        {
                            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                                DoCast(pTarget, SPELL_MALLABLE_GOO_H);
                            m_uiMalleableGooTimer = urand(16000, 20000);
                        } else m_uiMalleableGooTimer -= uiDiff;

                        if (m_uiSayDieTimer < uiDiff)
                        {
                            if(fDie)
                            {
                                DoScriptText(SAY_FESTERGUT_DEATH, me);
                                me->GetMotionMaster()->MovePoint(0, professorStartPos);
                                SetSonPhase(PHASE_READY);
                                fDie = false;
                            }
                            EnterEvadeMode();
                            m_uiSayDieTimer = 4000;
                        } else m_uiSayDieTimer -= uiDiff;
                    }
                    else if(phase == PHASE_ROTFACE)
                    {
                        if (m_uiVileGasTimer < uiDiff)
                        {
                            for (uint8 i = 1; i <= 3; i++)
                            {
                                if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                                {
                                    DoCast(pTarget, SPELL_VILE_GAS);
                                }
                            }
                            m_uiVileGasTimer = urand (16000, 20000);
                        } else m_uiVileGasTimer -= uiDiff;

                        if (m_uiSayDieTimer < uiDiff)
                        {
                            if(rDie)
                            {
                                DoScriptText(SAY_ROTFACE_DEATH, me);
                                me->GetMotionMaster()->MovePoint(0, professorStartPos);
                                SetSonPhase(PHASE_READY);
                                rDie = false;
                            }
                            EnterEvadeMode();
                            m_uiSayDieTimer = 4000;
                        } else m_uiSayDieTimer -= uiDiff;
                    }
                }

                if(phase == PHASE_COMBAT)
                {
                    if (m_uiBerserkTimer < uiDiff)
                    {
                        DoCast(me, SPELL_BERSERK);
                        DoScriptText(SAY_BERSERK,me);
                        m_uiBerserkTimer = 600000;
                    } else m_uiBerserkTimer -= uiDiff;

                    if((me->GetHealth()*100) / me->GetMaxHealth() < 81 && PhaseSwitch1 == false)
                    {
                        PhaseSwitch();
                        PhaseSwitch1 = true;
                    }

                    if((me->GetHealth()*100) / me->GetMaxHealth() < 36 && PhaseSwitch2 == false)
                    {
                        PhaseSwitch();
                        PhaseSwitch2 = true;
                    }

                    if (m_uiPuddleTimer < uiDiff)
                    {
                        for (uint8 i = 1; i <= count; i++)
                        {
                            if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                            {
                                DoCast(pTarget, SPELL_SLIME_PUDDLE);
                            }
                        }
                        m_uiPuddleTimer = 19000;
                    } else m_uiPuddleTimer -= uiDiff;

                    if (m_uiPhase == 1)
                    {
                        if (m_uiUnstableExperimentTimer < uiDiff)
                        {
                            SpawnAdds();
                            DoCast(SPELL_UNSTABLE_EXPERIMENT);
                            me->MonsterTextEmote(EMOTE_UNSTABLE_EXPERIMENT, NULL);
                            m_uiUnstableExperimentTimer = 40000;
                        } else m_uiUnstableExperimentTimer -= uiDiff;
                    }

                    if (m_uiPhase == 2)
                    {
                        if (m_uiUnstableExperimentTimer < uiDiff)
                        {
                            DoCast(me, SPELL_UNSTABLE_EXPERIMENT);
                            me->MonsterTextEmote(EMOTE_UNSTABLE_EXPERIMENT,NULL);
                            TwoAdds();
                            m_uiUnstableExperimentTimer = 40000;
                        } else m_uiUnstableExperimentTimer -= uiDiff;

                        if (m_uiMalleableTimer < uiDiff)
                        {
                            if(Unit* pTarget = SelectUnit(SELECT_TARGET_FARTHEST, 1))
                            {
                                DoCast(pTarget, SPELL_MALLEABLE_GOO);
                                m_uiMalleableTimer = 16000;
                            }
                        } else m_uiMalleableTimer -= uiDiff;

                        if (m_uiBombTimer < uiDiff)
                        {
                            DoCast(SPELL_CHOKING_GAS_BOMB);
                            m_uiBombTimer = 21000;
                        } else m_uiBombTimer -= uiDiff;
                    }
                    if (m_uiPhase == 3)
                    {
                        if(!me->HasAura(SPELL_STRENGTH))
                        {
                            DoCast(me, SPELL_STRENGTH);
                        }

                        if (m_uiMalleableTimer < uiDiff)
                        {
                            if(Unit* pTarget = SelectUnit(SELECT_TARGET_FARTHEST,1))
                            {
                                DoCast(pTarget, SPELL_MALLEABLE_GOO);
                                m_uiMalleableTimer = 16000;
                            }
                        } else m_uiMalleableTimer -= uiDiff;

                        if (m_uiBombTimer < uiDiff)
                        {
                            DoCast(SPELL_CHOKING_GAS_BOMB);
                            m_uiBombTimer = 21000;
                        } else m_uiBombTimer -= uiDiff;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* pInstance;

            uint32 m_uiPhase;
            uint32 m_uiUnstableExperimentTimer;
            uint32 m_uiResetTimer;
            uint32 m_uiPuddleTimer;
            uint32 m_uiMalleableTimer;
            uint32 m_uiPhaseSwitchTimer;
            uint32 m_uiBerserkTimer;
            uint32 m_uiBombTimer;
            //festergut and rotface
            uint32 m_uiMalleableGooTimer;
            uint32 m_uiVileGasTimer;
            uint32 m_uiSayDieTimer;
            uint64 gasDummyGUID;
            uint8 experement;
            uint8 phaseswitch;
            uint8 stage;
            uint8 count;

            bool PhaseSwitch1;
            bool PhaseSwitch2;
            bool fDie; //festergut die
            bool rDie; // rotface die

            float fBaseSpeed;

            ePhases phase;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_professor_putricideAI(pCreature);
        }
};

class npc_volatile_ooze : public CreatureScript
{
    public:
        npc_volatile_ooze() : CreatureScript("npc_volatile_ooze") { }

        struct npc_volatile_oozeAI : public ScriptedAI
        {
            npc_volatile_oozeAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                me->SetSpeed(MOVE_RUN, 0.5);
                me->SetSpeed(MOVE_WALK, 0.5);

                m_uiSearchTargetTimer = 1000;
                target = false;
                aggro = false;

                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            }

            void EnterCombat(Unit* /*who*/) { }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!target && m_uiSearchTargetTimer < uiDiff)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                    {
                        me->AddThreat(me->getVictim(), 10000.0f);
                        me->GetMotionMaster()->MoveChase(me->getVictim());
                        pTarget->CastSpell(pTarget, SPELL_OOZE_SEARCH_EFFECT, true);
                        pTarget->CastSpell(pTarget, SPELL_VOLATILE_OOZE, true);
                        target = true;
                    }
                    m_uiSearchTargetTimer = 1000;
                } else m_uiSearchTargetTimer -= uiDiff;

                if (me->getVictim() && me->getVictim()->IsWithinDistInMap(me, 1))
                {
                    DoCast(me, SPELL_OOZE_ERUPTION);
                    me->getVictim()->RemoveAurasDueToSpell(SPELL_VOLATILE_OOZE);
                    me->getVictim()->RemoveAurasDueToSpell(SPELL_OOZE_SEARCH_EFFECT);
                    target = false;
                }

                DoMeleeAttackIfReady();
            }
        private:
             InstanceScript* pInstance;

             uint32 m_uiSearchTargetTimer;
             bool target;
             bool aggro;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_volatile_oozeAI(pCreature);
        }
};

class npc_gas_cloud_icc : public CreatureScript
{
    public:
        npc_gas_cloud_icc() : CreatureScript("npc_gas_cloud_icc") { }

        struct npc_gas_cloud_iccAI : public ScriptedAI
        {
            npc_gas_cloud_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                me->SetSpeed(MOVE_RUN, 0.5);
                me->SetSpeed(MOVE_WALK, 0.5);
                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);

                m_uiBloatTimer = 6000;
                m_uiSearchTargetTimer = 1000;

                target = false;
            }

            void EnterCombat(Unit* /*who*/) { }

            void UpdateAI(const uint32 diff)
            {
                if (m_uiBloatTimer < diff)
                {
                    DoCast(me->getVictim(), SPELL_GASEOUS_BLOAT_AURA);
                    m_uiBloatTimer = 5000;
                } else m_uiBloatTimer -= diff;

                if (!target && m_uiSearchTargetTimer < diff)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                    {
                        DoCast(pTarget, SPELL_GASEOUS_BLOAT);
                        me->AddThreat(pTarget, 10000000.0f);
                        me->GetMotionMaster()->MoveChase(pTarget);
                        target = true;
                    }
                    m_uiSearchTargetTimer = 1000;
                } else m_uiSearchTargetTimer -= diff;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* pInstance;

            uint32 m_uiBloatTimer;
            uint32 m_uiSearchTargetTimer;
            bool target;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_gas_cloud_iccAI(pCreature);
        }
};

class npc_bomb_icc : public CreatureScript
{
    public:
        npc_bomb_icc() : CreatureScript("npc_bomb_icc") { }

        struct npc_bomb_iccAI : public ScriptedAI
        {
            npc_bomb_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                m_uiBombTimer = 1500;
                m_uiBoomTimer = 20000;

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetInCombatWithZone();
                DoStartNoMovement(me->getVictim());
                DoCast(me, SPELL_ORANGE_RADIATION);
            }

            void EnterCombat(Unit* /*who*/) { }

            void UpdateAI(const uint32 diff)
            {
                if (m_uiBombTimer < diff)
                {
                    DoCast(SPELL_CHOKING_GAS_AURA);
                    m_uiBombTimer = 1500;
                } else m_uiBombTimer -= diff;

                if (m_uiBoomTimer < diff)
                {
                    DoCast(SPELL_CHOKING_GAS_EXPLOSION);
                    me->ForcedDespawn();
                    m_uiBoomTimer = 20000;
                } else m_uiBoomTimer -= diff;
            }

        private:
            InstanceScript* pInstance;

            uint32 m_uiBombTimer;
            uint32 m_uiBoomTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_bomb_iccAI(pCreature);
        }
};

class npc_abomination : public CreatureScript
{
    public:
        npc_abomination() : CreatureScript("npc_abomination") { }

        struct npc_abominationAI : public ScriptedAI
        {
            npc_abominationAI(Creature* pCreature) : ScriptedAI(pCreature), vehicle(pCreature->GetVehicleKit())
            {
                pInstance = pCreature->GetInstanceScript();
                assert(vehicle);
            }

            void Reset()
            {
                m_uiGrabTimer = 1000;
                bVehicle = false;
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (m_uiGrabTimer < uiDiff)
                {
                    if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 1))
                    {
                        if(target && !bVehicle && target->IsFriendlyTo(me))
                        {
                            target->EnterVehicle(vehicle, 0);
                            bVehicle = true;
                        }
                    }
                    m_uiGrabTimer = 1000;
                } else m_uiGrabTimer -= uiDiff;
            }
        private:
            InstanceScript* pInstance;

            Vehicle* vehicle;

            bool bVehicle;
            uint32 m_uiGrabTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_abominationAI(pCreature);
        }
};

void AddSC_boss_professor_putricide()
{
    new boss_professor_putricide();
    new npc_volatile_ooze();
    new npc_gas_cloud_icc();
    new npc_bomb_icc();
    new npc_abomination();
}