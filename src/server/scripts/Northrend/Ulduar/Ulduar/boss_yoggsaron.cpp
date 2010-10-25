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
SDName: Yogg-Saron
SDAuthor: PrinceCreed
SD%Complete: 25
SDComments: Keeper's scripts completed
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Sara_Yells
{
    SAY_SARA_PREFIGHT_1                         = -1603310,
    SAY_SARA_PREFIGHT_2                         = -1603311,
    SAY_SARA_AGGRO_1                            = -1603312,
    SAY_SARA_AGGRO_2                            = -1603313,
    SAY_SARA_AGGRO_3                            = -1603314,
    SAY_SARA_SLAY_1                             = -1603315,
    SAY_SARA_SLAY_2                             = -1603316,
    WHISP_SARA_INSANITY                         = -1603317,
    SAY_SARA_PHASE2_1                           = -1603318,
    SAY_SARA_PHASE2_2                           = -1603319,
};

enum YoggSaron_Yells
{
    SAY_PHASE2_1                                = -1603330,
    SAY_PHASE2_2                                = -1603331,
    SAY_PHASE2_3                                = -1603332,
    SAY_PHASE2_4                                = -1603333,
    SAY_PHASE2_5                                = -1603334,
    SAY_PHASE3                                  = -1603335,
    SAY_VISION                                  = -1603336,
    SAY_SLAY_1                                  = -1603337,
    SAY_SLAY_2                                  = -1603338,
    WHISP_INSANITY_1                            = -1603339,
    WHISP_INSANITY_2                            = -1603340,
    SAY_DEATH                                   = -1603341,
};

enum Phases
{
    PHASE_NULL = 0,
    PHASE_1,
    PHASE_2,
    PHASE_3
};

Phases phase;

enum Npcs
{
    NPC_IMAGE_OF_FREYA                          = 33241,
    NPC_IMAGE_OF_THORIM                         = 33242,
    NPC_IMAGE_OF_MIMIRON                        = 33244,
    NPC_IMAGE_OF_HODIR                          = 33213,
    
    NPC_SANITY_WELL                             = 33991,
    
    NPC_GUARDIAN_OF_YOGGSARON                   = 33136,
    NPC_CRUSHER_TENTACLE                        = 33966,
    NPC_CORRUPTOR_TENTACLE                      = 33985,
    NPC_CONSTRICTOR_TENTACLE                    = 33983,
    NPC_DESCEND_INTO_MADNESS                    = 34072,

    NPC_LAUGHING_SKULL                          = 33990,
    NPC_INFLUENCE_TENTACLE                      = 33943,
    NPC_IMMORTAL_GUARDIAN                       = 33988,

    NPC_YOGG_SARON_BRAIN                        = 33890,
    NPC_SUIT_OF_ARMOR                           = 33433,
    NPC_AZURE_CONSORT                           = 33717,
    NPC_EMERALD_CONSORT                         = 33719,
    NPC_OBSIDIAN_CONSORT                        = 33720,
    NPC_RUBY_CONSORT                            = 33716,
    NPC_DEATHSWORN_ZEALOT                       = 33567,
    NPC_OMINOUS_CLOUD                           = 33292
};

#define GOSSIP_KEEPER_HELP                      "I need your help."

enum Keepers_Yells
{
    SAY_MIMIRON_HELP                            = -1603259,
    SAY_FREYA_HELP                              = -1603189,
    SAY_THORIM_HELP                             = -1603287,
    SAY_HODIR_HELP                              = -1603217,
};

enum Keepers_Spells
{
    SPELL_KEEPER_ACTIVE                         = 62647,
    
    // Freya
    SPELL_RESILIENCE_OF_NATURE                  = 62670,
    SPELL_SANITY_WELL_SPAWN                     = 64170,
    SPELL_SANITY_WELL_VISUAL                    = 63288,
    SPELL_SANITY_WELL                           = 64169,
    
    // Thorim
    SPELL_FURY_OF_THE_STORMS                    = 62702,
    SPELL_TITANIC_STORM                         = 64171,
    SPELL_TITANIC_STORM_DEBUFF                  = 64162,
    
    // Mimiron
    SPELL_SPEED_OF_INVENTION                    = 62671,
    SPELL_DESTABILIZATION                       = 65210,
    SPELL_DESTABILIZATION_DEBUFF                = 65206,
    
    // Hodir
    SPELL_FORTITUDE_OF_FROST                    = 62650,
    SPELL_PROTECTIVE_GAZE                       = 64174
};

const Position SanityWellPos[10] =
{
{2008.38f,35.41f,331.251f,0},
{1990.63f,50.35f,332.041f,0},
{1973.40f,41.09f,330.989f,0},
{1973.12f,-90.27f,330.14f,0},
{1994.26f,-96.62f,330.62f,0},
{2005.41f,-82.88f,329.50f,0},
{2042.09f,-41.70f,329.12f,0},
{1918.06f,16.50f,330.970f,0},
{1899.59f,-4.87f,332.137f,0},
{1897.75f,-48.24f,332.35f,0}
};


/*------------------------------------------------------*
 *                  Images of Keepers                   *
 *------------------------------------------------------*/

class keeper_image : public CreatureScript
{
public:
    keeper_image() : CreatureScript("keeper_image") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new keeper_imageAI (pCreature);
    }

    struct keeper_imageAI : public ScriptedAI
    {
        keeper_imageAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
    };

    bool GossipHello_keeper_image(Player* pPlayer, Creature* pCreature)
    {
        InstanceScript *pInstance = pCreature->GetInstanceScript();
        
        if (pInstance && pPlayer)
        {
            if (!pCreature->HasAura(SPELL_KEEPER_ACTIVE))
            {
                pPlayer->PrepareQuestMenu(pCreature->GetGUID());
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_KEEPER_HELP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
            }
        }
        return true;
    }

    bool GossipSelect_keeper_image(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
    {
        InstanceScript* pInstance = pCreature->GetInstanceScript();
        
        if (pPlayer)
            pPlayer->CLOSE_GOSSIP_MENU();
            
        switch (pCreature->GetEntry())
        {
            case NPC_IMAGE_OF_FREYA:
                DoScriptText(SAY_FREYA_HELP, pCreature);
                pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
                if (Creature *pFreya = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_FREYA)))
                    pFreya->SetVisibility(VISIBILITY_ON);
                break;
            case NPC_IMAGE_OF_THORIM:
                DoScriptText(SAY_THORIM_HELP, pCreature);
                pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
                if (Creature *pThorim = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_THORIM)))
                    pThorim->SetVisibility(VISIBILITY_ON);
                break;
            case NPC_IMAGE_OF_MIMIRON:
                DoScriptText(SAY_MIMIRON_HELP, pCreature);
                pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
                if (Creature *pMimiron = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_MIMIRON)))
                    pMimiron->SetVisibility(VISIBILITY_ON);
                break;
            case NPC_IMAGE_OF_HODIR:
                DoScriptText(SAY_HODIR_HELP, pCreature);
                pCreature->CastSpell(pCreature, SPELL_KEEPER_ACTIVE, true);
                if (Creature *pHodir = pCreature->GetCreature(*pCreature, pInstance->GetData64(DATA_YS_HODIR)))
                    pHodir->SetVisibility(VISIBILITY_ON);
                break;
        }
        return true;
    }
};

class npc_ys_freya : public CreatureScript
{
public:
    npc_ys_freya() : CreatureScript("npc_ys_freya") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ys_freyaAI (pCreature);
    }

    struct npc_ys_freyaAI : public ScriptedAI
    {
        npc_ys_freyaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
        }

        InstanceScript* pInstance;
        int32 WellTimer;

        void Reset()
        {
            WellTimer = urand(5000, 10000);
        }
        
        void EnterCombat()
        {
            DoCast(me, SPELL_RESILIENCE_OF_NATURE);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
                
            if (WellTimer <= (int32)uiDiff)
            {
                DoCast(SPELL_SANITY_WELL_SPAWN);
                me->SummonCreature(NPC_SANITY_WELL, SanityWellPos[rand()%10], TEMPSUMMON_TIMED_DESPAWN, 60000);
                WellTimer = 15000;
            }
            else WellTimer -= uiDiff;
        }
    };
};

class npc_sanity_well : public CreatureScript
{
public:
    npc_sanity_well() : CreatureScript("npc_sanity_well") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_sanity_wellAI (pCreature);
    }

    struct npc_sanity_wellAI : public Scripted_NoMovementAI
    {
        npc_sanity_wellAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            DoCast(me, SPELL_SANITY_WELL_VISUAL);
            DoCast(me, SPELL_SANITY_WELL);
        }

        InstanceScript* pInstance;
    };
};

class npc_ys_thorim : public CreatureScript
{
public:
    npc_ys_thorim() : CreatureScript("npc_ys_thorim") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ys_thorimAI (pCreature);
    }

    struct npc_ys_thorimAI : public ScriptedAI
    {
        npc_ys_thorimAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
        }

        InstanceScript* pInstance;

        void Reset(){}
        
        void EnterCombat()
        {
            DoCast(me, SPELL_FURY_OF_THE_STORMS);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim() || me->hasUnitState(UNIT_STAT_CASTING))
                return;
                
            if (!me->HasAura(SPELL_TITANIC_STORM) && phase == PHASE_3)
                DoCast(me, SPELL_TITANIC_STORM);
        }
    };
};

class npc_ys_mimiron : public CreatureScript
{
public:
    npc_ys_mimiron() : CreatureScript("npc_ys_mimiron") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ys_mimironAI (pCreature);
    }

    struct npc_ys_mimironAI : public ScriptedAI
    {
        npc_ys_mimironAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
        }

        InstanceScript* pInstance;
        int32 DestabilizeTimer;

        void Reset()
        {
            DestabilizeTimer = 15000;
        }
        
        void EnterCombat()
        {
            DoCast(me, SPELL_SPEED_OF_INVENTION);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
                
            if (DestabilizeTimer <= (int32)uiDiff)
            {
                if (phase == PHASE_2)
                    DoCast(SPELL_DESTABILIZATION);
                DestabilizeTimer = 15000;
            }
            else DestabilizeTimer -= uiDiff;
        }
    };
};

class npc_ys_hodir : public CreatureScript
{
public:
    npc_ys_hodir() : CreatureScript("npc_ys_hodir") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ys_hodirAI (pCreature);
    }

    struct npc_ys_hodirAI : public ScriptedAI
    {
        npc_ys_hodirAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->SetVisibility(VISIBILITY_OFF);
        }

        InstanceScript* pInstance;

        void Reset(){}
        
        void EnterCombat()
        {
            DoCast(me, SPELL_FORTITUDE_OF_FROST);
        }
        
        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
        }
    };
};

void AddSC_boss_yogg_saron()
{
    new keeper_image();
    new npc_ys_freya();
    new npc_sanity_well();
    new npc_ys_thorim();
    new npc_ys_mimiron();
    new npc_ys_hodir();
}