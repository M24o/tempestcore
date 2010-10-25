/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Icecrown
SD%Complete: 100
SDComment: Quest support: 12807
SDCategory: Icecrown
EndScriptData */

/* ContentData
npc_arete
EndContentData */

#include "ScriptPCH.h"

/*######
## npc_arete
######*/

#define GOSSIP_ARETE_ITEM1 "Lord-Commander, I would hear your tale."
#define GOSSIP_ARETE_ITEM2 "<You nod slightly but do not complete the motion as the Lord-Commander narrows his eyes before he continues.>"
#define GOSSIP_ARETE_ITEM3 "I thought that they now called themselves the Scarlet Onslaught?"
#define GOSSIP_ARETE_ITEM4 "Where did the grand admiral go?"
#define GOSSIP_ARETE_ITEM5 "That's fine. When do I start?"
#define GOSSIP_ARETE_ITEM6 "Let's finish this!"
#define GOSSIP_ARETE_ITEM7 "That's quite a tale, Lord-Commander."

enum eArete
{
    GOSSIP_TEXTID_ARETE1        = 13525,
    GOSSIP_TEXTID_ARETE2        = 13526,
    GOSSIP_TEXTID_ARETE3        = 13527,
    GOSSIP_TEXTID_ARETE4        = 13528,
    GOSSIP_TEXTID_ARETE5        = 13529,
    GOSSIP_TEXTID_ARETE6        = 13530,
    GOSSIP_TEXTID_ARETE7        = 13531,

    QUEST_THE_STORY_THUS_FAR    = 12807
};

class npc_arete : public CreatureScript
{
public:
    npc_arete() : CreatureScript("npc_arete") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if (pPlayer->GetQuestStatus(QUEST_THE_STORY_THUS_FAR) == QUEST_STATUS_INCOMPLETE)
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE1, pCreature->GetGUID());
            return true;
        }

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE2, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE3, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE4, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE5, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE6, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE7, pCreature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                pPlayer->CLOSE_GOSSIP_MENU();
                pPlayer->AreaExploredOrEventHappens(QUEST_THE_STORY_THUS_FAR);
                break;
        }

        return true;
    }
};

/*######
## npc_dame_evniki_kapsalis
######*/

enum eDameEnvikiKapsalis
{
    TITLE_CRUSADER    = 123
};

class npc_dame_evniki_kapsalis : public CreatureScript
{
public:
    npc_dame_evniki_kapsalis() : CreatureScript("npc_dame_evniki_kapsalis") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pPlayer->HasTitle(TITLE_CRUSADER))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_TRADE)
            pPlayer->SEND_VENDORLIST(pCreature->GetGUID());
        return true;
    }
};

/*######
## npc_squire_david
######*/

enum eSquireDavid
{
    QUEST_THE_ASPIRANT_S_CHALLENGE_H                    = 13680,
    QUEST_THE_ASPIRANT_S_CHALLENGE_A                    = 13679,

    NPC_ARGENT_VALIANT                                  = 33448,

    GOSSIP_TEXTID_SQUIRE_DAVID                                = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_david : public CreatureScript
{
public:
    npc_squire_david() : CreatureScript("npc_squire_david") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pPlayer->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_H) == QUEST_STATUS_INCOMPLETE ||
            pPlayer->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_A) == QUEST_STATUS_INCOMPLETE)//We need more info about it.
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DAVID, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
        pPlayer->CLOSE_GOSSIP_MENU();
        pCreature->SummonCreature(NPC_ARGENT_VALIANT,8575.451,952.472,547.554,0.38);
        }
        //else
        //pPlayer->SEND_GOSSIP_MENU(???, pCreature->GetGUID()); Missing text
        return true;
    }
};

/*######
## npc_argent_valiant
######*/

enum eArgentValiant
{
    SPELL_CHARGE                = 63010,
    SPELL_SHIELD_BREAKER        = 65147,
    SPELL_DEFEND        = 62719,
    SPELL_THRUST        = 62544,

    NPC_ARGENT_VALIANT_CREDIT   = 24108
};

enum eValiantText
{
    NPC_FACTION_VAILIANT_TEXT_SAY_START_1     = -1850004,//    Tenez-vous pr�t !
    NPC_FACTION_VAILIANT_TEXT_SAY_START_2     = -1850005,//    Que le combat commence !
    NPC_FACTION_VAILIANT_TEXT_SAY_START_3     = -1850006,//    Pr�parez-vous !
    NPC_ARGENT_VAILIANT_TEXT_SAY_START         = -1850007,//    Vous pensez avoir la vaillance en vous ? Nous verrons.
    NPC_ARGENT_VAILIANT_TEXT_SAY_WIN         = -1850008,//    Impressionnante d�monstration. Je pense que vous �tes tout � fait en mesure de rejoindre les rangs des vaillants.
    NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE         = -1850009,//    J'ai gagn�. Vous aurez sans doute plus de chance la prochaine fois.
    NPC_FACTION_VAILIANT_TEXT_SAY_WIN_1     = -1850010,//    Je suis vaincue. Joli combat !
    NPC_FACTION_VAILIANT_TEXT_SAY_WIN_2     = -1850011,//    On dirait que j'ai sous-estim� vos comp�tences. Bien jou�.
    NPC_FACTION_VAILIANT_TEXT_SAY_LOOSE     = -1850012,//    J'ai gagn�. Vous aurez sans doute plus de chance la prochaine fois.
};

class npc_argent_valiant : public CreatureScript
{
public:
    npc_argent_valiant() : CreatureScript("npc_argent_valiant") { }

    struct npc_argent_valiantAI : public ScriptedAI
    {
        npc_argent_valiantAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        me->CastSpell(me, SPELL_DEFEND, true);
        me->CastSpell(me, SPELL_DEFEND, true);
            pCreature->GetMotionMaster()->MovePoint(0,8599.258f,963.951f,547.553f);
            pCreature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
    uint32 uiDefendTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
        uiDefendTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
        if(pDoneBy)
        {
            if (uiDamage > me->GetHealth() && (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
            {
                DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_WIN, me);
                uiDamage = 0;

                if(pDoneBy->GetOwner())
                    (pDoneBy->GetOwner())->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);
                if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
                    pDoneBy->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);

                me->setFaction(35);
                me->ForcedDespawn(5000);
                me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());
                EnterEvadeMode();
            }
        }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            me->setFaction(35);
            me->ForcedDespawn(5000);
            DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE, me);
            me->CombatStop(true);
        }

        void DoMeleeAttackIfReady()
    {
        if (me->hasUnitState(UNIT_STAT_CASTING))
            return;

        //Make sure our attack is ready and we aren't currently casting before checking distance
        if (me->isAttackReady())
        {
            //If we are within range melee the target
            if (me->IsWithinMeleeRange(me->getVictim()))
            {
                DoCastVictim(SPELL_THRUST);
                me->resetAttackTimer();
            }
        }
    }

    void EnterCombat(Unit* /*who*/)
        {
        DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_START, me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiChargeTimer <= uiDiff)
            {
                DoCastVictim(SPELL_CHARGE);
                uiChargeTimer = 7000;
            } else uiChargeTimer -= uiDiff;

            if (uiShieldBreakerTimer <= uiDiff)
            {
                DoCastVictim(SPELL_SHIELD_BREAKER);
                uiShieldBreakerTimer = 10000;
            } else uiShieldBreakerTimer -= uiDiff;

            if (uiDefendTimer <= uiDiff)
            {
            me->CastSpell(me, SPELL_DEFEND, true);
            uiDefendTimer = 10000;
            } else uiDefendTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_argent_valiantAI(creature);
    }
};

/*######
## npc_argent_tournament_post
######*/

enum eArgentTournamentPost
{
    SPELL_ROPE_BEAM                 = 63413,
    NPC_GORMOK_THE_IMPALER          = 35469,
    NPC_ICEHOWL                     = 35470
};

class npc_argent_tournament_post : public CreatureScript
{
public:
    npc_argent_tournament_post() : CreatureScript("npc_argent_tournament_post") { }

    struct npc_argent_tournament_postAI : public ScriptedAI
    {
        npc_argent_tournament_postAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (Creature* pTarget = me->FindNearestCreature(NPC_GORMOK_THE_IMPALER, 6.0f))
                DoCast(pTarget, SPELL_ROPE_BEAM);

            if (Creature* pTarget2 = me->FindNearestCreature(NPC_ICEHOWL, 6.0f))
                DoCast(pTarget2, SPELL_ROPE_BEAM);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_argent_tournament_postAI(creature);
    }
};

/*######
## npc_alorah_and_grimmin
######*/

enum ealorah_and_grimmin
{
    SPELL_CHAIN                     = 68341,
    NPC_FJOLA_LIGHTBANE             = 36065,
    NPC_EYDIS_DARKBANE              = 36066,
    NPC_PRIESTESS_ALORAH            = 36101,
    NPC_PRIEST_GRIMMIN              = 36102
};

class npc_alorah_and_grimmin : public CreatureScript
{
public:
    npc_alorah_and_grimmin() : CreatureScript("npc_alorah_and_grimmin") { }

    struct npc_alorah_and_grimminAI : public ScriptedAI
    {
        npc_alorah_and_grimminAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        bool uiCast;

        void Reset()
        {
            uiCast = false;
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (uiCast)
                return;
            uiCast = true;
            Creature* pTarget = NULL;

            switch(me->GetEntry())
            {
                case NPC_PRIESTESS_ALORAH:
                    pTarget = me->FindNearestCreature(NPC_EYDIS_DARKBANE, 10.0f);
                    break;
                case NPC_PRIEST_GRIMMIN:
                    pTarget = me->FindNearestCreature(NPC_FJOLA_LIGHTBANE, 10.0f);
                    break;
            }
            if (pTarget)
                DoCast(pTarget, SPELL_CHAIN);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_alorah_and_grimminAI(creature);
    }
};

/*######
## npc_guardian_pavilion
######*/

enum eGuardianPavilion
{
    SPELL_TRESPASSER_H                            = 63987,
    AREA_SUNREAVER_PAVILION                       = 4676,

    AREA_SILVER_COVENANT_PAVILION                 = 4677,
    SPELL_TRESPASSER_A                            = 63986,
};

class npc_guardian_pavilion : public CreatureScript
{
public:
    npc_guardian_pavilion() : CreatureScript("npc_guardian_pavilion") { }

    struct npc_guardian_pavilionAI : public Scripted_NoMovementAI
    {
        npc_guardian_pavilionAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature) {}

        void MoveInLineOfSight(Unit* pWho)
        {
            if (me->GetAreaId() != AREA_SUNREAVER_PAVILION && me->GetAreaId() != AREA_SILVER_COVENANT_PAVILION)
                return;

            if (!pWho || pWho->GetTypeId() != TYPEID_PLAYER || !me->IsHostileTo(pWho) || !me->isInBackInMap(pWho, 5.0f))
                return;

            if (pWho->HasAura(SPELL_TRESPASSER_H) || pWho->HasAura(SPELL_TRESPASSER_A))
                return;

            if (pWho->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                pWho->CastSpell(pWho, SPELL_TRESPASSER_H, true);
            else
                pWho->CastSpell(pWho, SPELL_TRESPASSER_A, true);

        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

/*######
## npc_vendor_argent_tournament
######*/
const uint32 ArgentTournamentVendor[10][4] =
{
    {33553,13726,2,14460}, // Orc
    {33554,13726,8,14464}, // Troll
    {33556,13728,6,14458}, // Tauren
    {33555,13729,5,14459}, // Undead
    {33557,13731,10,14465}, // Blood Elf
    {33307,13699,1,14456}, // Human
    {33310,13713,3,14457}, // Dwarf
    {33653,13725,4,14463}, // Night Elf
    {33650,13723,7,14462}, // Gnome
    {33657,13724,11,14461} // Draenei
};

class npc_vendor_argent_tournament : public CreatureScript
{
public:
    npc_vendor_argent_tournament(): CreatureScript("npc_vendor_argent_tournament"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        bool npcCheck = false;
        bool questCheck = false;
        bool raceCheck = false;
        uint32 textId = 0;
        
        for(int i = 0; (i < 10) && !npcCheck; i++)
        {
            if(pCreature->GetEntry() == ArgentTournamentVendor[i][0])
            {
                npcCheck = true;
                questCheck = pPlayer->GetQuestStatus(ArgentTournamentVendor[i][1]) == QUEST_STATUS_COMPLETE;
                raceCheck = pPlayer->getRace() == ArgentTournamentVendor[i][2];
                textId = ArgentTournamentVendor[i][3];
            }
        }
        
        if(questCheck || raceCheck)
            pPlayer->SEND_VENDORLIST(pCreature->GetGUID()); 
        else
            pPlayer->SEND_GOSSIP_MENU(textId, pCreature->GetGUID());
        return true;
    }

};

/*######
* quest_givers_argent_tournament
######*/

class quest_givers_argent_tournament : public CreatureScript
{
public:
    quest_givers_argent_tournament(): CreatureScript("quest_givers_argent_tournament"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        //uint64 const guid = pCreature->GetGUID();

            if (pCreature->isQuestGiver())
        {    
            Object *pObject = (Object*)pCreature;
            QuestRelations* pObjectQR = sObjectMgr.GetCreatureQuestRelationMap();
            QuestRelations* pObjectQIR = sObjectMgr.GetCreatureQuestInvolvedRelation();

            QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
            qm.ClearMenu();

            for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                    qm.AddMenuItem(quest_id, 4);
                else if (status == QUEST_STATUS_INCOMPLETE)
                    qm.AddMenuItem(quest_id, 4);
                //else if (status == QUEST_STATUS_AVAILABLE)
                //    qm.AddMenuItem(quest_id, 2);
            }

            bool EligibilityAlliance = pPlayer->GetQuestStatus(13686) == QUEST_STATUS_COMPLETE;
            bool EligibilityHorde = pPlayer->GetQuestStatus(13687) == QUEST_STATUS_COMPLETE;

            for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
                if (!pQuest) continue;

                switch(quest_id)
                {
                    case 13707: // Valiant Of Orgrimmar
                    case 13708: // Valiant Of Sen'jin
                    case 13709: // Valiant Of Thunder Bluff
                    case 13710: // Valiant Of Undercity
                    case 13711: // Valiant Of Silvermoon
                        if(!EligibilityHorde)
                        {
                            QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    case 13593: // Valiant Of Stormwind
                    case 13703: // Valiant Of Ironforge
                    case 13706: // Valiant Of Darnassus
                    case 13704: // Valiant Of Gnomeregan
                    case 13705: // Valiant Of The Exodar
                        if(!EligibilityAlliance)
                        {
                            QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        QuestStatus status = pPlayer->GetQuestStatus(quest_id);

                        if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 4);
                        else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }
        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*######
* npc_training_dummy_argent
######*/
#define SPELL_DEFEND_AURA 62719
#define SPELL_DEFEND_AURA_1 64100
#define SPELL_ARGENT_CHARGE 68321
#define SPELL_ARGENT_BREAK_SHIELD 62626
#define SPELL_ARGENT_MELEE 62544 

class npc_training_dummy_argent : public CreatureScript
{
public:
    npc_training_dummy_argent(): CreatureScript("npc_training_dummy_argent"){}
        
    struct npc_training_dummy_argentAI : Scripted_NoMovementAI
    {
        npc_training_dummy_argentAI(Creature *c) : Scripted_NoMovementAI(c)
        {
        m_Entry = c->GetEntry();
        }

        uint64 m_Entry;
        uint32 ResetTimer;
        uint32 DespawnTimer;
        uint32 ShielTimer;
        void Reset()
        {
        me->SetControlled(true,UNIT_STAT_STUNNED);//disable rotate
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);//imune to knock aways like blast wave
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
        ResetTimer = 10000;
        DespawnTimer = 15000;
            ShielTimer=0;
        }

        void EnterEvadeMode()
        {
        if (!_EnterEvadeMode())
            return;

        Reset();
        }

        void DamageTaken(Unit * /*done_by*/, uint32 &damage)
        {
        ResetTimer = 10000;
        damage = 0;
        }

        void EnterCombat(Unit * /*who*/)
        {
        if (m_Entry != 2674 && m_Entry != 2673)
            return;
        }

        void SpellHit(Unit* caster,const SpellEntry* spell)
        {
            if(caster->GetOwner())
            {
                if(m_Entry==33272)
                    if(spell->Id==SPELL_ARGENT_CHARGE)
                        if(!me->GetAura(SPELL_DEFEND_AURA))
                            caster->GetOwner()->ToPlayer()->KilledMonsterCredit(33340, 0);
                if(m_Entry==33229){
                    if(spell->Id==SPELL_ARGENT_MELEE)
                    {
                        caster->GetOwner()->ToPlayer()->KilledMonsterCredit(33341, 0);
                        me->CastSpell(caster,62709,true);
                    }
                }
                
            }
                
            if(m_Entry==33243)
                    if(spell->Id==SPELL_ARGENT_BREAK_SHIELD)
                        if(!me->GetAura(SPELL_DEFEND_AURA))
                            if(caster->GetTypeId()==TYPEID_PLAYER)
                                caster->ToPlayer()->KilledMonsterCredit(33339, 0);
        }


        void UpdateAI(const uint32 diff)
        {
            if (ShielTimer <= diff)
            {
                if(m_Entry==33243)
                    me->CastSpell(me,SPELL_DEFEND_AURA,true);

                if(m_Entry==33272 && !me->GetAura(SPELL_DEFEND_AURA_1))
                        me->CastSpell(me,SPELL_DEFEND_AURA_1,true);
                ShielTimer = 8000;
            }
            else
                ShielTimer -= diff;

        if (!UpdateVictim())
            return;
        if (!me->hasUnitState(UNIT_STAT_STUNNED))
            me->SetControlled(true,UNIT_STAT_STUNNED);//disable rotate

        if (m_Entry != 2674 && m_Entry != 2673)
        {
            if (ResetTimer <= diff)
            {
            EnterEvadeMode();
            ResetTimer = 10000;
            }
            else
            ResetTimer -= diff;
            return;
        }
        else
        {
            if (DespawnTimer <= diff)
            me->ForcedDespawn();
            else
            DespawnTimer -= diff;
        }
        }
        void MoveInLineOfSight(Unit * /*who*/){return;}
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_training_dummy_argentAI(pCreature);
    }

};

/*######
* npc_quest_givers_for_crusaders
######*/

class npc_quest_givers_for_crusaders : public CreatureScript
{
public:
    npc_quest_givers_for_crusaders(): CreatureScript("npc_quest_givers_for_crusaders"){}
        
    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pPlayer->HasTitle(TITLE_CRUSADER))
            if (pCreature->isQuestGiver())
                pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*######
* npc_crusader_rhydalla
######*/

class npc_crusader_rhydalla : public CreatureScript
{
public:
    npc_crusader_rhydalla(): CreatureScript("npc_crusader_rhydalla"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        // uint64 const guid = pCreature->GetGUID();

        if (pCreature->isQuestGiver())
        {    
            Object *pObject = (Object*)pCreature;
            QuestRelations* pObjectQR = sObjectMgr.GetCreatureQuestRelationMap();
            QuestRelations* pObjectQIR = sObjectMgr.GetCreatureQuestInvolvedRelation();

            QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
            qm.ClearMenu();

            for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                    qm.AddMenuItem(quest_id, 4);
                else if (status == QUEST_STATUS_INCOMPLETE)
                    qm.AddMenuItem(quest_id, 4);
                //else if (status == QUEST_STATUS_AVAILABLE)
                //    qm.AddMenuItem(quest_id, 2);
            }

            for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
                if (!pQuest) continue;
                QuestStatus status;
                bool allowed=false;
                switch(quest_id)
                {
                    case 13664: // The Black Knigh's Fall
                        allowed = (pPlayer->GetQuestStatus(13700) == QUEST_STATUS_COMPLETE) || (pPlayer->GetQuestStatus(13701) == QUEST_STATUS_COMPLETE);
                        if(allowed)
                        {
                            status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        status = pPlayer->GetQuestStatus(quest_id);

                        if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 4);
                        else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }
        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*######
* npc_eadric_the_pure
######*/

class npc_eadric_the_pure : public CreatureScript
{
public:
    npc_eadric_the_pure(): CreatureScript("npc_eadric_the_pure"){}
        
    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        // uint64 const guid = pCreature->GetGUID();

        if (pCreature->isQuestGiver())
        {    
            Object *pObject = (Object*)pCreature;
            QuestRelations* pObjectQR = sObjectMgr.GetCreatureQuestRelationMap();
            QuestRelations* pObjectQIR = sObjectMgr.GetCreatureQuestInvolvedRelation();

            QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
            qm.ClearMenu();

            for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                    qm.AddMenuItem(quest_id, 4);
                else if (status == QUEST_STATUS_INCOMPLETE)
                    qm.AddMenuItem(quest_id, 4);
                //else if (status == QUEST_STATUS_AVAILABLE)
                //    qm.AddMenuItem(quest_id, 2);
            }

            for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
                if (!pQuest) continue;
                QuestStatus status;
                bool allowed=false;
                switch(quest_id)
                {
                    case 13682: // Alliance Threat From Above
                    case 13809: // Horde Threat From Above
                        allowed = (pPlayer->GetQuestStatus(13664) == QUEST_STATUS_COMPLETE) && pPlayer->GetQuestRewardStatus(13664);
                        if(allowed)
                        {
                            status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        status = pPlayer->GetQuestStatus(quest_id);

                        if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 4);
                        else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }
        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*######
* npc_justicar_mariel_trueheart
######*/

class npc_justicar_mariel_trueheart : public CreatureScript
{
public:
    npc_justicar_mariel_trueheart(): CreatureScript("npc_justicar_mariel_trueheart"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        // uint64 const guid = pCreature->GetGUID();

        if (pCreature->isQuestGiver())
        {
            Object *pObject = (Object*)pCreature;
            QuestRelations* pObjectQR = sObjectMgr.GetCreatureQuestRelationMap();
            QuestRelations* pObjectQIR = sObjectMgr.GetCreatureQuestInvolvedRelation();

            QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
            qm.ClearMenu();

            for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                    qm.AddMenuItem(quest_id, 4);
                else if (status == QUEST_STATUS_INCOMPLETE)
                    qm.AddMenuItem(quest_id, 4);
                //else if (status == QUEST_STATUS_AVAILABLE)
                //    qm.AddMenuItem(quest_id, 2);
            }

            for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
                if (!pQuest) continue;
                QuestStatus status;
                bool allowed=false;
                switch(quest_id)
                {
                    case 13795: // The Scourgebane
                        allowed = (pPlayer->GetQuestStatus(13702) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13702)) || (pPlayer->GetQuestStatus(13732) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13732)) || (pPlayer->GetQuestStatus(13735) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13735)) || (pPlayer->GetQuestStatus(13733) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13733)) || (pPlayer->GetQuestStatus(13734) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13734)) || (pPlayer->GetQuestStatus(13736) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13736)) || (pPlayer->GetQuestStatus(13737) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13737)) || (pPlayer->GetQuestStatus(13738) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13738)) || (pPlayer->GetQuestStatus(13739) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13739)) || (pPlayer->GetQuestStatus(13740) == QUEST_STATUS_COMPLETE && pPlayer->GetQuestRewardStatus(13740)); // If the player has finished any of the "A Champion Rises" quests                    
                        if(allowed)
                        {
                            status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        status = pPlayer->GetQuestStatus(quest_id);

                        if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 4);
                        else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }
        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*######
* npc_crok_scourgebane
######*/

class npc_crok_scourgebane : public CreatureScript
{
public:
    npc_crok_scourgebane(): CreatureScript("npc_crok_scourgebane"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        // uint64 const guid = pCreature->GetGUID();

        if (pCreature->isQuestGiver())
        {
            Object *pObject = (Object*)pCreature;
            QuestRelations* pObjectQR = sObjectMgr.GetCreatureQuestRelationMap();
            QuestRelations* pObjectQIR = sObjectMgr.GetCreatureQuestInvolvedRelation();

            QuestMenu &qm = pPlayer->PlayerTalkClass->GetQuestMenu();
            qm.ClearMenu();

            for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                QuestStatus status = pPlayer->GetQuestStatus(quest_id);
                if (status == QUEST_STATUS_COMPLETE && !pPlayer->GetQuestRewardStatus(quest_id))
                    qm.AddMenuItem(quest_id, 4);
                else if (status == QUEST_STATUS_INCOMPLETE)
                    qm.AddMenuItem(quest_id, 4);
                //else if (status == QUEST_STATUS_AVAILABLE)
                //    qm.AddMenuItem(quest_id, 2);
            }

            for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
            {
                uint32 quest_id = i->second;
                Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
                if (!pQuest) continue;
                QuestStatus status;
                bool allowed=false;
                switch(quest_id)
                {
                    case 13788: // DK Threat From Above (Alliance)
                    case 13812: // DK Threat From Above (Horde)
                        allowed = (pPlayer->GetQuestStatus(13664) == QUEST_STATUS_COMPLETE) && pPlayer->GetQuestRewardStatus(13664);
                        if(allowed)
                        {
                            status = pPlayer->GetQuestStatus(quest_id);

                            if(pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 4);
                            else if(status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                                qm.AddMenuItem(quest_id, 2);
                        }
                        break;
                    default:
                        status = pPlayer->GetQuestStatus(quest_id);

                        if (pQuest->IsAutoComplete() && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 4);
                        else if (status == QUEST_STATUS_NONE && pPlayer->CanTakeQuest(pQuest, false))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }
        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

};

/*
* Npc Jeran Lockwood (33973)
*/
#define JERAN_DEFAULT_TEXTID 14453
#define JERAN_QUEST_TEXTID 14431
#define JERAN_RP_TEXTID 14434
#define GOSSIP_HELLO_JERAN_1 "Montrez-moi comment m'entraîner sur une cible de mêlée."
#define GOSSIP_HELLO_JERAN_2 "Parlez-moi de la défense et du coup de lance."
#define SPELL_CREDIT_JERAN 64113

class npc_jeran_lockwood : public CreatureScript
{
public:
    npc_jeran_lockwood(): CreatureScript("npc_jeran_lockwood"){}
        
    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if((pPlayer->GetQuestStatus(13828) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13829) == QUEST_STATUS_INCOMPLETE))
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        pPlayer->SEND_GOSSIP_MENU(JERAN_QUEST_TEXTID, pCreature->GetGUID());
        }
        else
        {
            pPlayer->SEND_GOSSIP_MENU(JERAN_DEFAULT_TEXTID, pCreature->GetGUID());
        }
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                pPlayer->CastSpell(pPlayer,SPELL_CREDIT_JERAN,true);
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_JERAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                pPlayer->SEND_GOSSIP_MENU(JERAN_RP_TEXTID, pCreature->GetGUID());
                break;
        }
        return true;
    }

};

/*
* Npc Rugan Steelbelly (33972)
*/
#define RUGAN_DEFAULT_TEXTID 14453
#define RUGAN_QUEST_TEXTID 14436
#define RUGAN_RP_TEXTID 14437
#define GOSSIP_HELLO_RUGAN_1 "Montrez-moi comment m'entraîner sur une cible de charge."
#define GOSSIP_HELLO_RUGAN_2 "Parlez-moi de la charge"
#define SPELL_CREDIT_RUGAN 64114

class npc_rugan_steelbelly : public CreatureScript
{
public:
    npc_rugan_steelbelly(): CreatureScript("npc_rugan_steelbelly"){}
        
    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if((pPlayer->GetQuestStatus(13837) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13839) == QUEST_STATUS_INCOMPLETE))
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        pPlayer->SEND_GOSSIP_MENU(RUGAN_QUEST_TEXTID, pCreature->GetGUID());
        }
        else
        {
            pPlayer->SEND_GOSSIP_MENU(RUGAN_DEFAULT_TEXTID, pCreature->GetGUID());
        }
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                pPlayer->CastSpell(pPlayer,SPELL_CREDIT_RUGAN,true);
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_RUGAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                pPlayer->SEND_GOSSIP_MENU(RUGAN_RP_TEXTID, pCreature->GetGUID());
                break;
        }
        return true;
    }

};

/*
* Npc Valis Windchaser
*/
#define VALIS_DEFAULT_TEXTID 14453
#define VALIS_QUEST_TEXTID 14438
#define VALIS_RP_TEXTID 14439
#define GOSSIP_HELLO_VALIS_1 "Montrez-moi comment m'entraîner sur une cible � distance."
#define GOSSIP_HELLO_VALIS_2 "Expliquez-moi comment utiliser le brise-bouclier."
#define SPELL_CREDIT_VALIS 64115
class npc_valis_windchaser : public CreatureScript
{
public:
    npc_valis_windchaser(): CreatureScript("npc_valis_windchaser"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        //Si il a la quete
        if((pPlayer->GetQuestStatus(13835) == QUEST_STATUS_INCOMPLETE) || 
            (pPlayer->GetQuestStatus(13838) == QUEST_STATUS_INCOMPLETE))
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        pPlayer->SEND_GOSSIP_MENU(VALIS_QUEST_TEXTID, pCreature->GetGUID());
        }
        //Sinon Texte par d�faut
        else
            pPlayer->SEND_GOSSIP_MENU(VALIS_DEFAULT_TEXTID, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                pPlayer->CastSpell(pPlayer,SPELL_CREDIT_VALIS,true);//Cast du sort de credit quest (valide l'objectif)
                pPlayer->CLOSE_GOSSIP_MENU();//Ferme la fenetre du gossip cot� client
            break;
            case GOSSIP_ACTION_INFO_DEF+2:
                //Raconte un blabla
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_VALIS_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->SEND_GOSSIP_MENU(VALIS_RP_TEXTID, pCreature->GetGUID());
            break;
        }
        return true;
    }

};

/*######
## npc_squire_danny
######*/

enum eSquireDanny
{
    QUEST_THE_VALIANT_S_CHALLENGE_0 = 13699,
    QUEST_THE_VALIANT_S_CHALLENGE_1 = 13713,
    QUEST_THE_VALIANT_S_CHALLENGE_2 = 13723,
    QUEST_THE_VALIANT_S_CHALLENGE_3 = 13724,
    QUEST_THE_VALIANT_S_CHALLENGE_4 = 13725,
    QUEST_THE_VALIANT_S_CHALLENGE_5 = 13726,
    QUEST_THE_VALIANT_S_CHALLENGE_6 = 13727,
    QUEST_THE_VALIANT_S_CHALLENGE_7 = 13728,
    QUEST_THE_VALIANT_S_CHALLENGE_8 = 13729,
    QUEST_THE_VALIANT_S_CHALLENGE_9 = 13731,

    NPC_ARGENT_CHAMPION = 33707,

    GOSSIP_TEXTID_SQUIRE_DANNY = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_danny : public CreatureScript
{
public:
    npc_squire_danny(): CreatureScript("npc_squire_danny"){}

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_0) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_1) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_2) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_3) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_4) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_5) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_6) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_7) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_8) == QUEST_STATUS_INCOMPLETE ||
        pPlayer->GetQuestStatus(QUEST_THE_VALIANT_S_CHALLENGE_9) == QUEST_STATUS_INCOMPLETE)
        {
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DANNY, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
        pPlayer->CLOSE_GOSSIP_MENU();
        pCreature->SummonCreature(NPC_ARGENT_CHAMPION,8562.836914,1099.153931,556.787598,5.026550); // TODO (R�cup�rer les coordonn�es r�elles)
        }
        //else
        //pPlayer->SEND_GOSSIP_MENU(???, pCreature->GetGUID()); Missing text
        return true;
    }

};

/*######
## npc_argent_champion
######*/

enum eArgentChampion
{
    SPELL_CHARGE_CHAMPION                = 63010,
    SPELL_SHIELD_BREAKER_CHAMPION        = 65147,
    SPELL_DEFEND_CHAMPION        = 62719,
    SPELL_THRUST_CHAMPION        = 62544,

    NPC_ARGENT_CHAMPION_CREDIT   = 33708
};

enum eChampionText
{
    NPC_FACTION_CHAMPION_TEXT_SAY_START_1     = -1850004,//    Tenez-vous pr�t !
    NPC_FACTION_CHAMPION_TEXT_SAY_START_2     = -1850005,//    Que le combat commence !
    NPC_FACTION_CHAMPION_TEXT_SAY_START_3     = -1850006,//    Pr�parez-vous !
    NPC_ARGENT_CHAMPION_TEXT_SAY_START         = -1850007,//    Vous pensez avoir la vaillance en vous ? Nous verrons.
    NPC_ARGENT_CHAMPION_TEXT_SAY_WIN         = -1850008,//    Impressionnante d�monstration. Je pense que vous �tes tout � fait en mesure de rejoindre les rangs des vaillants.
    NPC_ARGENT_CHAMPION_TEXT_SAY_LOOSE         = -1850009,//    J'ai gagn�. Vous aurez sans doute plus de chance la prochaine fois.
    NPC_FACTION_CHAMPION_TEXT_SAY_WIN_1     = -1850010,//    Je suis vaincue. Joli combat !
    NPC_FACTION_CHAMPION_TEXT_SAY_WIN_2     = -1850011,//    On dirait que j'ai sous-estim� vos comp�tences. Bien jou�.
    NPC_FACTION_CHAMPION_TEXT_SAY_LOOSE     = -1850012,//    J'ai gagn�. Vous aurez sans doute plus de chance la prochaine fois.
};

class npc_argent_champion : public CreatureScript
{
public:
    npc_argent_champion(): CreatureScript("npc_argent_champion"){}

    struct npc_argent_championAI : public ScriptedAI
    {
        npc_argent_championAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
        me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
        pCreature->GetMotionMaster()->MovePoint(0,8552.469727,1124.128784,556.787598); // TODO (Trouver les coordonn�es exactes)
        pCreature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
        uint32 uiDefendTimer;

        void Reset()
        {
        uiChargeTimer = 7000;
        uiShieldBreakerTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
        if (uiType != POINT_MOTION_TYPE)
            return;

        me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
            if(pDoneBy)
            {
                if (uiDamage > me->GetHealth() && (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                {
                    DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_WIN, me);
                    uiDamage = 0;

                    if(pDoneBy->GetOwner())
                        (pDoneBy->GetOwner())->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_CHAMPION_CREDIT,0);
                    if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
                        pDoneBy->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_CHAMPION_CREDIT,0);

                    me->setFaction(35);
                    me->ForcedDespawn(5000);
                    me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());
                    EnterEvadeMode();
                }
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
        me->setFaction(35);
        me->ForcedDespawn(5000);
        DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_LOOSE, me);
        me->CombatStop(true);
        }

        void DoMeleeAttackIfReady()
        {
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            //Make sure our attack is ready and we aren't currently casting before checking distance
            if (me->isAttackReady())
            {
                //If we are within range melee the target
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                DoCastVictim(SPELL_THRUST_CHAMPION);
                me->resetAttackTimer();
                }
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
        DoScriptText(NPC_ARGENT_CHAMPION_TEXT_SAY_START, me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
        if (!UpdateVictim())
            return;

        if (uiChargeTimer <= uiDiff)
        {
            DoCastVictim(SPELL_CHARGE_CHAMPION);
            uiChargeTimer = 7000;
        } else uiChargeTimer -= uiDiff;

        if (uiShieldBreakerTimer <= uiDiff)
        {
            DoCastVictim(SPELL_SHIELD_BREAKER_CHAMPION);
            uiShieldBreakerTimer = 10000;
        } else uiShieldBreakerTimer -= uiDiff;

        if (uiDefendTimer <= uiDiff)
        {
            me->CastSpell(me, SPELL_DEFEND_CHAMPION, true);
            uiDefendTimer = 10000;
        } else uiDefendTimer -= uiDiff;

        DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_argent_championAI (pCreature);
    }

};

void AddSC_icecrown()
{
    new npc_arete();
    new npc_dame_evniki_kapsalis();
    new npc_squire_david();
    new npc_argent_valiant();
    new npc_argent_tournament_post();
    new npc_alorah_and_grimmin();
    new npc_guardian_pavilion();
    new npc_vendor_argent_tournament;
    new quest_givers_argent_tournament;
    new npc_training_dummy_argent;
    new npc_quest_givers_for_crusaders;
    new npc_justicar_mariel_trueheart;
    new npc_crusader_rhydalla;
    new npc_eadric_the_pure;
    new npc_crok_scourgebane;
    new npc_valis_windchaser;
    new npc_rugan_steelbelly;
    new npc_jeran_lockwood;
    new npc_squire_danny;
    new npc_argent_champion;
}
