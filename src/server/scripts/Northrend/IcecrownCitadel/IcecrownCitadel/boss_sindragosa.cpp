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
*Need correct timers
*Need add  Sindragossa fly in fly phase
*/

#include "ScriptPCH.h"
#include "icecrown_citadel.h"

enum Yells
{
    SAY_AGGRO            = -1666071,
    SAY_UNCHAIND_MAGIC   = -1666072,
    SAY_BLISTERING_COLD  = -1666073,
    SAY_BREATH           = -1666074,
    SAY_AIR_PHASE        = -1666075,
    SAY_PHASE_3          = -1666076,
    SAY_KILL_1           = -1666077,
    SAY_KILL_2           = -1666078,
    SAY_BERSERK          = -1666079,
    SAY_DEATH            = -1666080
};

enum Spells
{
    SPELL_FROST_AURA          = 70084,
    SPELL_CLEAVE              = 19983,
    SPELL_TAIL_SMASH          = 71077,
    SPELL_FROST_BREATH        = 73061,
    SPELL_PERMEATING_CHILL    = 70107, //
    SPELL_PERMEATING_AURA     = 70106,
    SPELL_UNCHAINED_MAGIC     = 69762, // нужно узнать механику на офе
    SPELL_ICY_TRIP_PULL       = 70122,
    SPELL_BOMB_VISUAL_1       = 64624,
    SPELL_BOMB_VISUAL_2       = 69016,
    SPELL_BLISTERING_COLD     = 70123,
    SPELL_FROST_BOMB_TRIGGER  = 69846,
    SPELL_FROST_BEACON        = 70126,
    SPELL_ICE_TOMB            = 70157,
    SPELL_FROST_BOMB          = 69845,
    SPELL_MYSTIC_BUFFED       = 70128,
    SPELL_ASPHYXATION         = 71665,
    SPELL_FROST_AURA_ADD      = 71387,
    SPELL_FROST_BREATH_ADD    = 71386,
    SPELL_ICE_BLAST           = 71376,
    SPELL_BELLOWING_ROAR      = 36922,
    SPELL_CLEAVE_ADD          = 40505,
    SPELL_TAIL_SWEEP          = 71369
};

const Position SpawnLoc[]=
{
    {4523.889f, 2486.907f, 280.249f, 3.155f}, //fly pos
    {4407.439f, 2484.905f, 203.374f, 3.166f}, //land pos
    {4671.521f, 2481.815f, 343.365f, 3.166f} //spawn pos
};

class boss_sindragosa : public CreatureScript
{
    public:
        boss_sindragosa() : CreatureScript("boss_sindragosa") { }

        struct boss_sindragosaAI : public BossAI
        {
            boss_sindragosaAI(Creature* pCreature) : BossAI(pCreature, DATA_SINDRAGOSA)
            {
                pInstance = me->GetInstanceScript();
                count = RAID_MODE(2,5,2,5);
            }

            void Reset()
            {
                m_uiPhase = 0;

                m_uiBreathTimer = 15000;
                m_uiTailSmashTimer = 11000;
                m_uiBlisteringColdTimer = 30000;
                m_uiMarkTimer = 20000;
                m_uiPermatingChilTimer = 12000;
                m_uiMysticTimer = 6000;
                m_uiBerserkTimer = 600000;
                m_uiChangePhaseTimer = 170000;
                m_uiUnchainedMagicTimer = 12000;
                m_uiBombTimer = 9000;
                m_uiCleaveTimer = 5000;

                me->SetFlying(true);
                me->SetSpeed(MOVE_WALK, 1.5f, true);
                me->SetSpeed(MOVE_RUN, 1.5f, true);
                me->SetSpeed(MOVE_FLIGHT, 2.5f, true);

                Switch = false;

                memset(&marked, 0, sizeof(marked));
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoCast(me, SPELL_FROST_AURA);
                DoScriptText(SAY_AGGRO, me);

                m_uiPhase = 1;
            }

            void JustDied(Unit* /*pKiller*/)
            {
                DoScriptText(SAY_DEATH, me);

                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_PERMEATING_CHILL);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_UNCHAINED_MAGIC);

                if (pInstance)
                    pInstance->SetData(DATA_SINDRAGOSA_EVENT, DONE);
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
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_PERMEATING_CHILL);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_UNCHAINED_MAGIC);

                if(pInstance)
                    pInstance->SetData(DATA_SINDRAGOSA_EVENT, FAIL);
            }

            void BlisteringCold()
            {
                Map::PlayerList const &PlList = me->GetMap()->GetPlayers();

                if (PlList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
                {
                    if (Player* pPlayer = i->getSource())
                    if (pPlayer && pPlayer->isAlive() && pPlayer->IsWithinDistInMap(me, 25.0f))
                    {
                        DoCast(pPlayer, SPELL_ICY_TRIP_PULL);
                        DoCast(pPlayer, SPELL_BLISTERING_COLD);
                        DoScriptText(SAY_BLISTERING_COLD, me);
                    }
                }
            }

            void MarkedPlayer()
            {
                for (uint8 i = 1; i <= count; i++)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                    if(pTarget && !pTarget->HasAura(SPELL_FROST_BEACON))
                    {
                        DoCast(pTarget, SPELL_FROST_BEACON);
                        marked[i] = pTarget;
                    }
                }
            }

            void Tomb()
            {
                for (uint8 i = 1; i <= count; i++)
                {
                    if (marked[i] && marked[i]->isAlive())
                    {
                        DoCast(marked[i], SPELL_ICE_TOMB);
                        DoCast(marked[i], SPELL_ASPHYXATION);
                        marked[i]->RemoveAurasDueToSpell(SPELL_FROST_BEACON);
                        float x, y, z;
                        marked[i]->GetPosition(x, y, z);
                        if (Unit* tomb = DoSummon(CREATURE_ICE_TOMB, marked[i]))
                            tomb->AddThreat(marked[i], 5000.0f);
                    }
                }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiBerserkTimer <= uiDiff)
                {
                    DoScriptText(SAY_BERSERK, me);
                    DoCast(me, SPELL_BERSERK);
                    m_uiBerserkTimer = 600000;
                } else m_uiBerserkTimer -= uiDiff;

                if(m_uiPhase == 1)
                {
                    if(m_uiUnchainedMagicTimer <= uiDiff)
                    {
                        uint32 mcount = urand(1,3);
                        for (uint8 i = 1; i <= mcount; i++)
                        {
                            if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                            if(pTarget && pTarget->getPowerType() == POWER_MANA && !pTarget->HasAura(SPELL_UNCHAINED_MAGIC) && pTarget->GetDistance2d(me->GetPositionX(), me->GetPositionY()) > 5) //hack
                            {
                                DoScriptText(SAY_UNCHAIND_MAGIC, me);
                                DoCast(pTarget, SPELL_UNCHAINED_MAGIC);
                                m_uiUnchainedMagicTimer = 12000;
                            }
                        }
                    } else m_uiUnchainedMagicTimer -= uiDiff;

                    if (m_uiPermatingChilTimer <= uiDiff)
                    {
                        Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1);
                        if(pTarget && !pTarget->HasAura(SPELL_PERMEATING_CHILL) && pTarget->GetDistance2d(me->GetPositionX(), me->GetPositionY()) < 5) //hack
                        {
                            DoCast(pTarget, SPELL_PERMEATING_CHILL);
                        }
                        m_uiPermatingChilTimer = 20000;
                    } else m_uiPermatingChilTimer -= uiDiff;

                    if (m_uiBreathTimer <= uiDiff)
                    {
                        DoScriptText(SAY_BREATH, me);
                        DoCast(SPELL_FROST_BREATH);
                        m_uiBreathTimer = 15000;
                    } else m_uiBreathTimer -= uiDiff;

                    if (m_uiCleaveTimer <= uiDiff)
                    {
                        DoCast(me, SPELL_CLEAVE);
                        m_uiCleaveTimer = 6000;
                    } else m_uiCleaveTimer -= uiDiff;

                    if (m_uiTailSmashTimer <= uiDiff)
                    {
                        DoCast(SPELL_TAIL_SMASH);
                        m_uiTailSmashTimer = 12000;
                    } else m_uiTailSmashTimer -= uiDiff;

                    if (m_uiBlisteringColdTimer <= uiDiff)
                    {
                        BlisteringCold();
                        m_uiBlisteringColdTimer = 30000;
                    } else m_uiBlisteringColdTimer -= uiDiff;
                }

                if(m_uiPhase == 2)
                {
                    if (m_uiMarkTimer < uiDiff)
                    {
                        MarkedPlayer();
                        m_uiMarkTimer = 15000;
                        m_uiIceBoltTriggerTimer = 7000;
                    } else m_uiMarkTimer -= uiDiff;

                    if (m_uiIceBoltTriggerTimer < uiDiff)
                    {
                        Tomb();
                        m_uiIceBoltTriggerTimer = 31000;
                    } else m_uiIceBoltTriggerTimer -= uiDiff;

                    if (m_uiBombTimer <= uiDiff)
                    {
                        if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                        {
                            DoCast(pTarget, SPELL_FROST_BOMB);
                            DoCast(pTarget, SPELL_FROST_BOMB_TRIGGER);
                        }
                        m_uiBombTimer = 10000;
                    } else m_uiBombTimer -= uiDiff;
                }

                if(m_uiPhase == 3)
                {
                    if (m_uiMarkTimer < uiDiff)
                    {
                        MarkedPlayer();
                        m_uiMarkTimer = 15000;
                        m_uiIceBoltTriggerTimer = 7000;
                    } else m_uiMarkTimer -= uiDiff;

                    if (m_uiBreathTimer <= uiDiff)
                    {
                        DoScriptText(SAY_BREATH, me);
                        DoCast(SPELL_FROST_BREATH);
                        m_uiBreathTimer = 15000;
                    } else m_uiBreathTimer -= uiDiff;

                    if (m_uiMysticTimer <= uiDiff)
                    {
                        Map::PlayerList const &PlList = me->GetMap()->GetPlayers();

                        for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
                        {
                            if (Player* pPlayer = i->getSource())
                            {
                                if (pPlayer && pPlayer->GetDistance2d(me->GetPositionX(), me->GetPositionY()) <= 10)
                                {
                                    DoCast(pPlayer, SPELL_MYSTIC_BUFFED);
                                }
                            }
                        }
                       m_uiMysticTimer = 6000;
                    } else m_uiMysticTimer -= uiDiff;

                    if (m_uiIceBoltTriggerTimer < uiDiff)
                    {
                        Tomb();
                        m_uiIceBoltTriggerTimer = 31000;
                    } else m_uiIceBoltTriggerTimer -= uiDiff;
                }

                if((HealthBelowPct(36)) && !Switch)
                {
                    DoScriptText(SAY_PHASE_3, me);
                    m_uiPhase = 3;
                    Switch = true;
                }

                if (m_uiChangePhaseTimer < uiDiff)
                {
                    if(!Switch)
                    {
                        if(m_uiPhase == 1)
                        {
                            DoScriptText(SAY_AIR_PHASE, me);
                            m_uiPhase = 2;
                        }
                        if(m_uiPhase == 2)
                        {
                            m_uiPhase = 1;
                        }
                    }
                    m_uiChangePhaseTimer = 170000;
                } else m_uiChangePhaseTimer -= uiDiff;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* pInstance;

            uint8 m_uiPhase;
            uint32 m_uiBreathTimer;
            uint32 m_uiCleaveTimer;
            uint32 m_uiTailSmashTimer;
            uint32 m_uiBlisteringColdTimer;
            uint32 m_uiBerserkTimer;
            uint32 m_uiMarkTimer;
            uint32 m_uiIceBoltTriggerTimer;
            uint32 m_uiFlyTimer;
            uint32 m_uiMysticTimer;
            uint32 m_uiResetTimer;
            uint32 m_uiPermatingChilTimer;
            uint32 m_uiChangePhaseTimer;
            uint32 m_uiUnchainedMagicTimer;
            uint32 m_uiBombTimer;
            uint8 count;
            Unit* marked[6];

            bool Switch;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_sindragosaAI(pCreature);
        }
};

class npc_ice_tomb : public CreatureScript
{
    public:
        npc_ice_tomb() : CreatureScript("npc_ice_tomb") { }

        struct npc_ice_tombAI: public ScriptedAI
        {
            npc_ice_tombAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                IceTombGUID = 0;
            }

            void SetPrisoner(Unit* uPrisoner)
            {
                IceTombGUID = uPrisoner->GetGUID();
            }

            void Reset()
            {
                SetCombatMovement(false);
                IceTombGUID = 0;
            }

            void JustDied(Unit *killer)
            {
                if (killer->GetGUID() != me->GetGUID())

                    if (IceTombGUID)
                    {
                        Unit* IceTomb = Unit::GetUnit((*me), IceTombGUID);
                        if (IceTomb)
                            IceTomb->RemoveAurasDueToSpell(SPELL_ICE_TOMB);
                    }
            }

            void KilledUnit(Unit *pVictim)
            {
                if (pVictim->GetGUID() != me->GetGUID())

                    if (IceTombGUID)
                    {
                        Unit* IceTomb = Unit::GetUnit((*me), IceTombGUID);
                        if (IceTomb)
                            IceTomb->RemoveAurasDueToSpell(SPELL_ICE_TOMB);
                    }
            }

            void UpdateAI(const uint32 uiDiff) { }

        private:
            uint64 IceTombGUID;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_ice_tombAI(pCreature);
        }
};

class npc_frost_bomb : public CreatureScript
{
    public:
        npc_frost_bomb() : CreatureScript("npc_frost_bomb") { }

        struct npc_frost_bombAI: public ScriptedAI
        {
            npc_frost_bombAI(Creature* pCreature) : ScriptedAI(pCreature) { }

            void Reset()
            {
                DoStartNoMovement(me->getVictim());

                m_uiVisualTimer = 6000;
                m_uiBoomTimer = 9000;

                end = false;

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void EnterCombat(Unit* /*who*/) { }

            void UpdateAI(const uint32 uiDiff)
            {
                if (end == true)
                {
                    DoCast(me, SPELL_FROST_BOMB);
                    me->ForcedDespawn();
                    end = false;
                }

                if (m_uiVisualTimer <= uiDiff)
                {
                    DoCast(me, SPELL_BOMB_VISUAL_1);
                    m_uiVisualTimer = 99999;
                } else m_uiVisualTimer -= uiDiff;

                if (m_uiBoomTimer <= uiDiff)
                {
                    DoCast(me, SPELL_BOMB_VISUAL_2);
                    end = true;
                } else m_uiBoomTimer -= uiDiff;
            }

        private:
            uint32 m_uiBoomTimer;
            uint32 m_uiVisualTimer;
            bool end;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_frost_bombAI(pCreature);
        }
};

class npc_rimefang : public CreatureScript
{
    public:
        npc_rimefang() : CreatureScript("npc_rimefang") { }

        struct npc_rimefangAI: public ScriptedAI
        {
            npc_rimefangAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                m_uiFrostBreathTimer = 5000;
                m_uiIceBlastTimer = 7000;
                me->SetFlying(true);

                if(pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) != DONE)
                   pInstance->SetData(DATA_SINDRAGOSA_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                if(pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) == NOT_STARTED)
                {
                    pInstance->SetData(DATA_SINDRAGOSA_EVENT, IN_PROGRESS);
                }

                Creature* dragon = Unit::GetCreature(*me, pInstance->GetData64(DATA_SPINESTALKER));
                if (dragon)
                {
                    if(dragon->isDead())
                    {
                        dragon->Respawn();
                    }
                    else
                    {
                        DoCast(me, SPELL_FROST_AURA_ADD);
                        dragon->SetInCombatWithZone();
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                if(pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) != DONE)
                {
                    Creature* dragon = Unit::GetCreature(*me, pInstance->GetData64(DATA_SPINESTALKER));
                    if(dragon && dragon->isDead())
                    {
                        Creature* DragonBoss = me->SummonCreature(CREATURE_SINDRAGOSA, SpawnLoc[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,30000);
                        /*if(DragonBoss)
                        {
                            DragonBoss->GetMotionMaster()->MovePoint(0, SpawnLoc[1]);
                        }*/
                    }
                }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) == FAIL && me->isAlive())
                {
                    me->Kill(me);
                }

                if (m_uiFrostBreathTimer <= uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_FROST_BREATH_ADD);
                    m_uiFrostBreathTimer = 6000;
                } else m_uiFrostBreathTimer -= uiDiff;

                if (m_uiIceBlastTimer <= uiDiff)
                {
                    DoCast(me, SPELL_ICE_BLAST);
                    m_uiIceBlastTimer = 8000;
                } else m_uiIceBlastTimer -= uiDiff;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* pInstance;

            uint32 m_uiFrostBreathTimer;
            uint32 m_uiIceBlastTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_rimefangAI(pCreature);
        }
};

class npc_spinestalker : public CreatureScript
{
    public:
        npc_spinestalker() : CreatureScript("npc_spinestalker") { }

        struct npc_spinestalkerAI: public ScriptedAI
        {
            npc_spinestalkerAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                m_uiRoarTimer = 14000;
                m_uiCleaveTimer = 6000;
                m_uiSweepTimer = 7000;
                me->SetFlying(true);

                if (pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) != DONE)
                    pInstance->SetData(DATA_SINDRAGOSA_EVENT, NOT_STARTED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                if(pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) == NOT_STARTED)
                {
                    pInstance->SetData(DATA_SINDRAGOSA_EVENT, IN_PROGRESS);
                }

                Creature* dragon = me->GetCreature(*me, pInstance->GetData64(DATA_RIMEFANG));
                if (dragon)
                {
                    if(dragon->isDead())
                    {
                        dragon->Respawn();
                    }
                    else
                    {
                        dragon->SetInCombatWithZone();
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                if(pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) != DONE)
                {
                    Creature* dragon = Unit::GetCreature(*me, pInstance->GetData64(DATA_RIMEFANG));
                    if(dragon && dragon->isDead())
                    {
                        Creature* DragonBoss = me->SummonCreature(CREATURE_SINDRAGOSA, SpawnLoc[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,30000);
                        /*if(DragonBoss)
                        {
                            DragonBoss->GetMotionMaster()->MovePoint(0, SpawnLoc[1]);
                        }*/
                    }
                }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!UpdateVictim())
                    return;

                if (pInstance && pInstance->GetData(DATA_SINDRAGOSA_EVENT) == FAIL && me->isAlive())
                {
                    me->Kill(me);
                }

                if (m_uiRoarTimer <= uiDiff)
                {
                    DoCastAOE(SPELL_BELLOWING_ROAR);
                    m_uiRoarTimer = 15000;
                } else m_uiRoarTimer -= uiDiff;

                if (m_uiCleaveTimer <= uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_CLEAVE_ADD);
                    m_uiCleaveTimer = 5000;
                } else m_uiCleaveTimer -= uiDiff;

                if (m_uiSweepTimer <= uiDiff)
                {
                    DoCast(SPELL_TAIL_SWEEP);
                    m_uiSweepTimer = 7000;
                } else m_uiSweepTimer -= uiDiff;

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiRoarTimer;
            uint32 m_uiCleaveTimer;
            uint32 m_uiSweepTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_spinestalkerAI(pCreature);
        }
};

void AddSC_boss_sindragosa()
{
    new boss_sindragosa();
    new npc_spinestalker();
    new npc_rimefang();
    new npc_ice_tomb();
    new npc_frost_bomb();
}