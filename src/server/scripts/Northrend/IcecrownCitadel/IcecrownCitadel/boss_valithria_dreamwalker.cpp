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
 
#include "ScriptPCH.h"
#include "icecrown_citadel.h"

enum Yells
{
    SAY_AGGRO       = -1666063,
    SAY_BELOW_25    = -1666066,
    SAY_ABOVE_75    = -1666065,
    SAY_DEATH       = -1666067,
    SAY_PDEATH      = -1666068,
    SAY_END         = -1666070,
    SAY_BERSERK     = -1666069,
    SAY_OPEN_PORTAL = -1666064
};

enum Spells
{
    SPELL_CORRUPTION    = 70904,
    SPELL_DREAM_SLIP    = 71196,
    SPELL_RAGE          = 71189,
    SPELL_VOLLEY        = 70759,
    SPELL_COLUMN        = 70704,
    SPELL_COLUMN_AURA   = 70702,
    SPELL_MANA_VOID     = 71085,
    SPELL_CORRUPTING    = 70602,
    SPELL_WASTE         = 69325,
    SPELL_FIREBALL      = 70754,
    SPELL_SUPRESSION    = 70588,
    SPELL_CORROSION     = 70751,
    SPELL_BURST         = 70744,
    SPELL_SPRAY         = 71283,
    SPELL_ROT           = 72963,
    SPELL_DREAM_STATE   = 70766,
    SPELL_PORTAL_VISUAL = 71304,
    SPELL_VIGOR         = 70873,
    SPELL_CLOUD_VISUAL  = 70876
};

const Position Pos[] =
{
    {4239.579102f, 2566.753418f, 364.868439f, 0.0f}, 
    {4240.688477f, 2405.794678f, 364.868591f, 0.0f}, 
    {4165.112305f, 2405.872559f, 364.872925f, 0.0f}, 
    {4166.216797f, 2564.197266f, 364.873047f, 0.0f}
};

Unit* pValithria;
Unit* pPlayer;
Unit* pBuff;

Creature* combat_trigger= NULL;

class boss_valithria : public CreatureScript
{
    public:
        boss_valithria() : CreatureScript("boss_valithria") { }

        struct boss_valithriaAI : public BossAI
        {
            boss_valithriaAI(Creature* pCreature) : BossAI(pCreature, DATA_VALITHRIA_DREAMWALKER), summons(me)
            {
                pInstance = me->GetInstanceScript();
            }

            void Reset()
            {
                m_uiStage = 1;

                DoCast(me, SPELL_CORRUPTION);
                me->SetHealth(uint32(me->GetMaxHealth() * 0.50));

                m_uiSummonTimer = 15000;
                m_uiPortalTimer = 30000;
                m_uiEndTimer = 1000;

                bIntro = false;
                bEnd = false;
                bAboveHP = false;
                bBelowHP = false;

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);

                if (pInstance && me->isAlive())
                    pInstance->SetData(DATA_VALITHRIA_DREAMWALKER_EVENT, NOT_STARTED);
            }

            void MoveInLineOfSight(Unit *who)
            {
                if (!bIntro && who->IsWithinDistInMap(me, 40.0f,true))
                {
                    DoScriptText(SAY_AGGRO, me);
                    bIntro = true;

                    combat_trigger = me->SummonCreature(CREATURE_COMBAT_TRIGGER, me->GetPositionX(), me->GetPositionY(),me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                    me->AddThreat(combat_trigger, 10000000.0f);
                    combat_trigger->AddThreat(me, 10000000.0f);
                    me->AI()->AttackStart(combat_trigger);
                    combat_trigger->AI()->AttackStart(me);

                    ScriptedAI::MoveInLineOfSight(who);
                }
            }

            void EnterCombat(Unit* /*pWho*/) { }

            void JustSummoned(Creature* pSummoned)
            {
                if (pSummoned && !pSummoned->HasAura(SPELL_PORTAL_VISUAL))
                    pSummoned->AI()->AttackStart(me);

                summons.Summon(pSummoned);
            }

            void ResetEvent()
            {
                Map::PlayerList const &PlList = me->GetMap()->GetPlayers();

                if (PlList.isEmpty())
                    return;

                for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
                {
                    if (Player* pPlayer = i->getSource())
                    {
                        if (pPlayer && pPlayer->isDead() && me->isAlive())
                        {
                            if (pInstance)
                                pInstance->SetData(DATA_VALITHRIA_DREAMWALKER_EVENT, FAIL);
                        }
                    }
                }
            }

            void HeroicSummon(uint8 coords)
            {
                urand(0,1); DoSummon(CREATURE_ZOMBIE, Pos[coords]);
                urand(0,1); DoSummon(CREATURE_SKELETON, Pos[coords]);
                urand(0,1); DoSummon(CREATURE_ARCHMAGE, Pos[coords]);
                urand(0,1); DoSummon(CREATURE_SUPPRESSER, Pos[coords]);
                urand(0,1); DoSummon(CREATURE_ABOMINATION, Pos[coords]);
            }

            void JustDied(Unit* /*pKiller*/)
            {
                DoScriptText(SAY_DEATH, me);

                summons.DespawnAll();

                if (pInstance)
                    pInstance->SetData(DATA_VALITHRIA_DREAMWALKER_EVENT, FAIL);
            }

            void UpdateAI(const uint32 diff)
            {
                ResetEvent();

                if (pInstance && pInstance->GetData(DATA_VALITHRIA_DREAMWALKER_EVENT) == IN_PROGRESS)
                {
                    DoStartNoMovement(me->getVictim());

                    if (m_uiSummonTimer <= diff)
                    {
                        uint8 location = RAID_MODE(1,3,1,3);
                        for (uint8 i = 0; i < location; ++i)
                        {
                            HeroicSummon(i);
                        }
                        m_uiSummonTimer = 20000;
                    } else m_uiSummonTimer -= diff;

                    if (m_uiPortalTimer <= diff)
                    {
                        DoScriptText(SAY_OPEN_PORTAL, me);

                        me->SummonCreature(CREATURE_PORTAL, me->GetPositionX()+15, me->GetPositionY()+15, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 15000);
                        me->SummonCreature(CREATURE_PORTAL, me->GetPositionX()+10, me->GetPositionY()+25, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 15000);
                        me->SummonCreature(CREATURE_PORTAL, me->GetPositionX()+15, me->GetPositionY()-25, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 15000);
                        m_uiPortalTimer = 30000;
                    } else m_uiPortalTimer -= diff;

                    if (!bAboveHP && (HealthAbovePct(74)))
                    {
                        DoScriptText(SAY_ABOVE_75, me);
                        bAboveHP = true;
                    }

                    if (!bBelowHP && (HealthBelowPct(26)))
                    {
                        DoScriptText(SAY_BELOW_25, me);
                        bBelowHP = true;
                    }

                    if ((HealthAbovePct(99)) && !bEnd)
                    {
                        DoScriptText(SAY_END, me);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                        me->SetReactState(REACT_PASSIVE);
                        me->RemoveAurasDueToSpell(SPELL_CORRUPTION);

                        bEnd = true;
                    }

                    if(bEnd)
                    {
                        if (m_uiEndTimer <= diff)
                        {
                            switch(m_uiStage)
                            {
                                case 1:
                                    DoScriptText(SAY_BERSERK , me);
                                    DoCast(me, SPELL_RAGE);
                                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                    ++m_uiStage;
                                    m_uiEndTimer = 6000;
                                    break;
                                case 2:
                                    {
                                        combat_trigger->ForcedDespawn();
                                        DoCast(me, SPELL_DREAM_SLIP, true);
                                        ++m_uiStage;
                                        m_uiEndTimer = 1000;
                                    }
                                    break;
                                case 3:
                                    if (pInstance)
                                        pInstance->SetData(DATA_VALITHRIA_DREAMWALKER_EVENT, DONE);
                                    me->ForcedDespawn();
                                    m_uiEndTimer = 1000;
                                    bEnd = false;
                                    ++m_uiStage;
                                    break;
                            }
                        } else m_uiEndTimer -= diff;
                    }
                }
            }

        private:
            InstanceScript* pInstance;

            uint8 m_uiStage;
            uint32 m_uiPortalTimer;
            uint32 m_uiEndTimer;
            uint32 m_uiSummonTimer;
            bool bIntro;
            bool bEnd;
            bool bAboveHP;
            bool bBelowHP;
            SummonList summons;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_valithriaAI(pCreature);
        }
};

class npc_dreamportal_icc : public CreatureScript
{
    public:
        npc_dreamportal_icc() : CreatureScript("npc_dreamportal_icc") { }

        struct npc_dreamportal_iccAI : public ScriptedAI
        {
            npc_dreamportal_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void InitializeAI()
            {
                DoCast(SPELL_PORTAL_VISUAL);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);

                ScriptedAI::InitializeAI();
            }

            void MoveInLineOfSight(Unit *who)
            {
                if (who->IsControlledByPlayer())
                {
                    if (me->IsWithinDistInMap(who,5.0f))
                    {
                        pPlayer = who;
                        pPlayer->CastSpell(pPlayer, SPELL_DREAM_STATE, false, 0, 0, 0);
                        pPlayer->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
                        pPlayer->SendMovementFlagUpdate();
                        m_uiStateTimer = 15000;
                        me->ForcedDespawn();
                    }
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiStateTimer <= diff)
                {
                    pPlayer->RemoveAurasDueToSpell(SPELL_DREAM_STATE);
                    pPlayer->RemoveUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
                    pPlayer->SendMovementFlagUpdate();
                } else m_uiStateTimer -= diff;
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiStateTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_dreamportal_iccAI(pCreature);
        }
};

class npc_skellmage_icc : public CreatureScript
{
    public:
        npc_skellmage_icc() : CreatureScript("npc_skellmage_icc") { }

        struct npc_skellmage_iccAI : public ScriptedAI
        {
            npc_skellmage_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                m_uiVolleyTimer = 12000;
                m_uiColumnTimer = 20000;
                m_uiVoidTimer = 30000;
            }

            void EnterCombat(Unit* /*who*/)
            {
                if (pInstance && pInstance->GetData(DATA_VALITHRIA_DREAMWALKER_EVENT) == NOT_STARTED)
                    pInstance->SetData(DATA_VALITHRIA_DREAMWALKER_EVENT, IN_PROGRESS);
            }

            void KilledUnit(Unit* /*victim*/)
            {
                DoScriptText(SAY_PDEATH, pValithria);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiVolleyTimer <= diff)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                        DoCast(pTarget, SPELL_VOLLEY);
                    m_uiVolleyTimer = 15000;
                } else m_uiVolleyTimer -= diff;

                if (m_uiVoidTimer <= diff)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_TOPAGGRO, 0))
                        me->SummonCreature(CREATURE_VOID, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 15000);
                    m_uiVoidTimer = 30000;
                } else m_uiVoidTimer -= diff;

                if (m_uiColumnTimer <= diff)
                {
                    Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1);
                    if(pTarget && pTarget->GetTypeId() == TYPEID_PLAYER)
                    {
                        DoCast(pTarget, SPELL_COLUMN);
                    }
                    m_uiColumnTimer = 20000;
                } else m_uiColumnTimer -= diff;

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiVolleyTimer;
            uint32 m_uiColumnTimer;
            uint32 m_uiVoidTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_skellmage_iccAI(pCreature);
        }
};

class npc_fireskell_icc : public CreatureScript
{
    public:
        npc_fireskell_icc() : CreatureScript("npc_fireskell_icc") { }

        struct npc_fireskell_iccAI : public ScriptedAI
        {
            npc_fireskell_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                m_uiWasteTimer = 20000;
                m_uiFireballTimer = 5000;
            }

            void EnterCombat(Unit* /*who*/) { }

            void KilledUnit(Unit* /*pVictim*/)
            {
                DoScriptText(SAY_PDEATH, pValithria);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiWasteTimer <= diff)
                {
                    DoCast(SPELL_WASTE);
                    m_uiWasteTimer = 20000;
                } else m_uiWasteTimer -= diff;

                if (m_uiFireballTimer <= diff)
                {
                    if(Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1))
                        DoCast(pTarget, SPELL_FIREBALL);
                    m_uiFireballTimer = 5000;
                } else m_uiFireballTimer -= diff;

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiWasteTimer;
            uint32 m_uiFireballTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_fireskell_iccAI(pCreature);
        }
};

class npc_suppressor_icc : public CreatureScript
{
    public:
        npc_suppressor_icc() : CreatureScript("npc_suppressor_icc") { }

        struct npc_suppressor_iccAI : public ScriptedAI
        {
            npc_suppressor_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void EnterCombat(Unit* /*who*/)
            {
                me->SetReactState(REACT_PASSIVE);
                m_uiCheckTimer = 2500;
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiCheckTimer <= diff)
                {
                    me->CastSpell(pValithria, SPELL_SUPRESSION, true, 0, 0, 0);
                    m_uiCheckTimer = 100000;
                } else m_uiCheckTimer -= diff;
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiCheckTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_suppressor_iccAI(pCreature);
        }
};

class npc_manavoid_icc : public CreatureScript
{
    public:
        npc_manavoid_icc() : CreatureScript("npc_manavoid_icc") { }

        struct npc_manavoid_iccAI : public ScriptedAI
        {
            npc_manavoid_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                DoCast(SPELL_MANA_VOID);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                DoStartNoMovement(me->getVictim());
            }

        private:
            InstanceScript* pInstance;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_manavoid_iccAI(pCreature);
        }
};

class npc_glutabomination_icc : public CreatureScript
{
    public:
        npc_glutabomination_icc() : CreatureScript("npc_glutabomination_icc") { }

        struct npc_glutabomination_iccAI : public ScriptedAI
        {
            npc_glutabomination_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void EnterCombat(Unit* /*who*/) { }

            void Reset()
            {
                m_uiSprayTimer = 10000;
            }

            void KilledUnit(Unit* /*pVictim*/)
            {
                DoScriptText(SAY_PDEATH, pValithria);
            }

            void JustDied(Unit* /*killer*/)
            {
                for (uint8 i = 1; i < 5; i++)
                {
                    me->SummonCreature(CREATURE_WORM, me->GetPositionX()+urand(3,6), me->GetPositionY()+urand(3,6), me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_DESPAWN, 10000);
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiSprayTimer <= diff)
                {
                    DoCast(me, SPELL_SPRAY);
                    m_uiSprayTimer = 20000;
                } else m_uiSprayTimer -= diff;

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiSprayTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_glutabomination_iccAI(pCreature);
        }
};

class npc_blistzombie_icc : public CreatureScript
{
    public:
        npc_blistzombie_icc() : CreatureScript("npc_blistzombie_icc") { }

        struct npc_blistzombie_iccAI : public ScriptedAI
        {
            npc_blistzombie_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void EnterCombat(Unit* /*who*/) { }

            void Reset()
            {
                m_uiBurstTimer = 20000;
                m_uiDelayTimer = 99999;
            }

            void KilledUnit(Unit* /*victim*/)
            {
                DoScriptText(SAY_PDEATH, pValithria);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (m_uiBurstTimer <= diff)
                {
                    DoCast(SPELL_BURST);
                    m_uiBurstTimer = 20000;
                    m_uiDelayTimer = 1000;
                } else m_uiBurstTimer -= diff;

                if (m_uiDelayTimer <= diff)
                {
                    me->ForcedDespawn();
                    m_uiDelayTimer = 100000;
                } else m_uiDelayTimer -= diff;

                DoMeleeAttackIfReady();
            }
        private:
            InstanceScript* pInstance;

            uint32 m_uiBurstTimer;
            uint32 m_uiDelayTimer;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_blistzombie_iccAI(pCreature);
        }
};

class npc_dreamcloud_icc : public CreatureScript
{
    public:
        npc_dreamcloud_icc() : CreatureScript("npc_dreamcloud_icc") { }

        struct npc_dreamcloud_iccAI : public ScriptedAI
        {
            npc_dreamcloud_iccAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                DoCast(SPELL_CLOUD_VISUAL);
                me->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
                me->SendMovementFlagUpdate();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }

            void MoveInLineOfSight(Unit *who)
            {
                if (me->IsWithinDistInMap(who, 5.0f))
                {
                    DoCast(SPELL_VIGOR);
                }
            }

            void UpdateAI(const uint32 diff) { }

        private:
            InstanceScript* pInstance;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_dreamcloud_iccAI(pCreature);
        }
};

class npc_icc_column_stalker : public CreatureScript
{
    public:
        npc_icc_column_stalker() : CreatureScript("npc_icc_column_stalker") { }

        struct npc_icc_column_stalkerAI : public ScriptedAI
        {
            npc_icc_column_stalkerAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                pInstance = pCreature->GetInstanceScript();
            }

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetInCombatWithZone();
                DoStartNoMovement(me->getVictim());
                DoCast(SPELL_COLUMN_AURA);
            }

            void UpdateAI(const uint32 /*uiDiff*/) { }


        private:
            InstanceScript* pInstance;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_icc_column_stalkerAI(pCreature);
        }
};

void AddSC_boss_valithria()
{
    new boss_valithria();
    new npc_skellmage_icc();
    new npc_fireskell_icc();
    new npc_dreamportal_icc();
    new npc_suppressor_icc();
    new npc_manavoid_icc();
    new npc_glutabomination_icc();
    new npc_blistzombie_icc();
    new npc_dreamcloud_icc();
    new npc_icc_column_stalker();
}