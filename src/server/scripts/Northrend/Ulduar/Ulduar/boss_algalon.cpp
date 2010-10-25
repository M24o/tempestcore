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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Spells
{
    A_CosmicSmash           = 62311,
    A_BlachHoleExplosion    = 64122,
    A_QuantumStrike         = 64395,
    A_PhasePunch            = 64412,
    A_BigBang               = 64443,
    A_AscentToTheHeavens    = 64487,
    A_AlgalonBerserk        = 47008,

    A_BigBang_H             = 64584,
    A_CosmicSmash_H         = 64596,
    A_QuantumStrike_H       = 64592,

    CS_EXPLODION            = 64122,
    CS_EXPLODION_H          = 65108,

    COSMIC_SMASH_MARKER     = 62293
};

enum Says
{
    Say_Intro1           = -1603017,
    Say_Intro2           = -1603018,
    Say_Intro3           = -1603019,

    Say_FirstTime        = -1603003,

    Say_Aggro            = -1603000,

    Say_SummoningStar    = -1603005,

    Say_BigBang1         = -1603012,
    Say_BigBang2         = -1603013,

    Say_Phase2           = -1603004,

    Say_Kill1            = -1603001,
    Say_Kill2            = -1603002,

    Say_Berserk          = -1603011,

    Say_Despawn1         = -1603014,
    Say_Despawn2         = -1603015,
    Say_Despawn3         = -1603016,

    Say_Defeated1        = -1603006,
    Say_Defeated2        = -1603007,
    Say_Defeated3        = -1603008,
    Say_Defeated4        = -1603009,
    Say_Defeated5        = -1603010
};

enum Defines
{
    STAR                 = 32955,
    CONSTELLATION        = 33052,
    BLACK_HOLE           = 32953,
    DARK_MATTERY         = 33089,
    UNLEASHED_DM         = 34097,

    DISPLAY_CIRCLE       = 11686,
    COSMIC_SMASH_TARGET  = 33104,

    MAX_ADDS_COUNT       = 50,
    MAX_MATTERY_COUNT    = 25,

    FACTION_HOSTILE      = 16,
    FACTION_NEUTRAL      = 189,
    FACTION_FRIENDLY     = 35
};

float Positions[10][4]    =
{
    { 1608.662476f, -273.162781f, 431.781189f, 5.745639f },
    { 1595.539063f, -287.533600f, 433.349365f, 5.815889f },
    { 1590.381104f, -307.694702f, 431.212402f, 0.009390f },
    { 1594.001220f, -324.683411f, 431.353271f, 0.335549f },
    { 1608.072388f, -340.856720f, 431.799164f, 0.952740f },
    { 1608.662476f, -273.162781f, 431.781189f, 5.745639f },
    { 1654.932007f, -279.250336f, 428.853577f, 6.055466f },
    { 1663.340332f, -288.152161f, 427.142456f, 5.207453f },
    { 1665.923828f, -297.538818f, 427.596313f, 4.961581f },
    { 1667.550781f, -306.588837f, 428.325897f, 3.907838f }
};

float aPhase2[4][4]        =
{
    { 1612.401733f, -318.095734f, 417.321106f, 0.069217f },
    { 1615.203491f, -297.438782f, 417.321106f, 0.119037f },
    { 1612.401733f, -318.095734f, 417.321106f, 0.069217f },
    { 1615.203491f, -297.438728f, 417.321106f, 0.119037f }
};

typedef std::list<uint64> GuidsList;
typedef std::list<HostileReference*> ThreatList;
#define GET_ALGALON Unit::GetCreature((*me), Instance->GetData64(DATA_ALGALON))

/******/
/** END OF DEFINES **/
/******/

class boss_algalon_the_observer : public CreatureScript
{
public:
    boss_algalon_the_observer() : CreatureScript("boss_algalon_the_observer") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_algalon_the_observerAI(pCreature);
    }

    struct boss_algalon_the_observerAI : public BossAI
    {
        boss_algalon_the_observerAI(Creature* pCreature) : BossAI(pCreature, TYPE_ALGALON)
        {
            Instance = ((InstanceScript*)pCreature->GetInstanceScript());
            (pCreature->GetMap()->IsRegularDifficulty() ? Hero = false : Hero = true);
            pCreature->setFaction(FACTION_NEUTRAL);
            pCreature->GetPosition(start_x, start_y, start_z);
            Reset();
        }

        // zmienne
        InstanceScript* Instance;
        bool Hero;
        bool Fight;

        bool IntroStart;
        bool IntroEnd;
        uint32 IntroTimer;
        uint32 IntroText;
        bool EngagedFirstTime;

        bool DespawnStart;
        bool DespawnEnd;
        uint32 DespawnTimer;
        uint32 DespawnText;

        bool DefeatedStart;
        bool DefeatedEnd;
        uint32 DefeatedTimer;
        uint32 DefeatedText;


        uint32 CosmicSmash_Timer;
        bool Target;
        uint64 TargetGUID;
        uint64 Target2GUID;
        uint64 Target3GUID;

        uint32 QuantumStrike_Timer;
        uint32 PhasePunch_Timer;
        uint32 BigBang_Timer;

        uint64 PhasePunch_GUID;
        uint32 PhasePunch_Count;

        bool Phase2;
        uint32 Berserk_Timer;
        bool JustCastedBigBang;
        uint32 BigBangCast_Timer;

        // faza pierwsza
        GuidsList LivingConstellation_GUID;
        GuidsList CollapsingStar_GUID;
        uint32 Constellation_Timer;
        GuidsList BlackHole_GUID;
        uint32 Star_Timer;

        // faza druga
        GuidsList DarkMattery_GUID;

        // for ingame debug mode
        bool DebugModeOn;

        float start_x;
        float start_y;
        float start_z;

        // reset
        void Reset()
        {
            if (Instance->GetBossState(TYPE_ALGALON) == DONE)
                return;

            if (me->HasFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9))
                me->RemoveFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9);

            me->SetReactState(REACT_AGGRESSIVE);
            SetCombatMovement(false);

            DebugModeOn = false;
            Fight = false;

            CosmicSmash_Timer = 25000;
            Target = false;
            TargetGUID = 0;
            QuantumStrike_Timer = (rand()%3+3)*1000;     // random time beetwen 3 and 5 sec
            PhasePunch_Timer = 15000;
            BigBang_Timer = 90000;

            PhasePunch_GUID = 0;
            PhasePunch_Count = 0;

            JustCastedBigBang = false;
            BigBangCast_Timer = 9000;

            Phase2 = false;
            Berserk_Timer = 360000;
            Constellation_Timer = 50000;

            Star_Timer = 15000;

            /* reset adds */
            DespawnAll();

            ThreatList const& list = me->getThreatManager().getThreatList();
            for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
            {
                Unit* pP = Unit::GetUnit((*me), (*i)->getUnitGuid());
                //const SpellEntry* bigbang = GetSpellStore()->LookupEntry(64584);
                //if (pP->IsImmunedToSpell(bigbang))
                    pP->ApplySpellImmune(RAID_MODE(A_BigBang_H, A_BigBang), IMMUNITY_ID, 0, false);
            }
        }

        void ResetDialogow()
        {
            if (Instance->GetBossState(TYPE_ALGALON) == DONE)
                return;

            IntroStart = false;
            IntroEnd = false;
            IntroTimer = 500;
            IntroText = 0;
            EngagedFirstTime = false;

            DespawnStart = false;
            DespawnEnd = false;
            DespawnTimer = 500;
            DespawnText = 0;

            DefeatedStart = false;
            DefeatedEnd = false;
            DefeatedTimer = 10000;
            DefeatedText = 0;
        }

        /******************/
        /******************/

        // handle functions
        void JustReachedHome()
        {
            if (Instance->GetBossState(TYPE_ALGALON) != DONE)
            {
                Instance->SetBossState(TYPE_ALGALON, FAIL);
                ResetDialogow();
            }
            DespawnAll();
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (Instance->GetBossState(TYPE_ALGALON) == NOT_STARTED)
            {
                EngagedFirstTime = true;
                IntroStart = true;
                DoStopCombat(false);
            }
        }

        void EnterCombat(Unit* pWho)
        {
            if (me->HasFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9))
                me->RemoveFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9);

            DoScriptText(Say_Aggro, me);
            DoStartCombat();

            Instance->SetBossState(TYPE_ALGALON, IN_PROGRESS);
        }

        void KilledUnit()
        {
            switch (rand()%2)
            {
            case 0: DoScriptText(Say_Kill1, me); break;
            case 1: DoScriptText(Say_Kill2, me); break;
            }
        }

        void JustSummoned(Creature* pC)
        {
            switch (pC->GetEntry())
            {
            case BLACK_HOLE: BlackHole_GUID.push_back(pC->GetGUID()); break;
            case STAR: CollapsingStar_GUID.push_back(pC->GetGUID()); break;
            case CONSTELLATION: LivingConstellation_GUID.push_back(pC->GetGUID()); break;
            case UNLEASHED_DM: DarkMattery_GUID.push_back(pC->GetGUID()); break;
            }
        }

        void SummonedCreatureDespawn(Creature* pC)
        {
            switch (pC->GetEntry())
            {
            case BLACK_HOLE: EraseDespawnedAdd(BlackHole_GUID, pC->GetGUID()); break;
            case STAR: EraseDespawnedAdd(CollapsingStar_GUID, pC->GetGUID()); break;
            case CONSTELLATION: EraseDespawnedAdd(LivingConstellation_GUID, pC->GetGUID()); break;
            case UNLEASHED_DM: EraseDespawnedAdd(DarkMattery_GUID, pC->GetGUID()); break;
            }
        }

        //UpdateAI
        void UpdateAI(const uint32 diff)
        {
            // dialogi
            UpdateTexts(diff);

            /****************/
            /****************/

            // AI
            if (!UpdateVictim())
                return;

            //**********************
            // Fight will only begin if bool Fight == true (used for boss monologs)
            //**********************
            if (Fight)
            {
            me->RemoveStandFlags(UNIT_STAND_FLAGS_UNK1);
            // SPRAWDZANIE
            if (!Phase2 && (me->GetHealth()*100)/me->GetMaxHealth() <= 20)
            {
                DoScriptText(Say_Phase2, me);
                DoPhase2();
                Phase2 = true;
            }

            BlackHoleDespawnCheck(); // check if living constellation is in black hole - if, despawn both

            if (!bAscentToHeavens() && !DespawnStart)
            {
                DoStopCombat(true, false); // stop combat + DespawnStart = true
                me->CastStop(); // we need to stop casting big bang first
                //DespawnAll(); // despawn all - for remove player's immunity while in black hole (TODO: remove this - try add in black_holeAI if (!DespawnStart) before adding stuff)

                //ThreatList const& list = me->getThreatManager().getThreatList();
                //for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
                //{
                //    if (Unit* pU = Unit::GetUnit((*me), (*i)->getUnitGuid()))
                //    { // remove debuff, visual effect and immunity
                //        pU->RemoveAurasDueToSpell(62169);
                //        pU->RemoveAurasDueToSpell(62168);
                //        pU->ApplySpellImmune(A_BigBang, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
                //    }
                //}
                DoCast(me->getVictim(), A_AscentToTheHeavens);
            }

            if (me->GetHealth()*100/me->GetMaxHealth() < 2 && !DefeatedStart)
            {
                DefeatedStart = true;
                Instance->SetBossState(TYPE_ALGALON, DONE);
                DoStopCombat(true, true);
                DespawnAll();
            }

            // FAZA 1
            if (!Phase2)
            {
                if (BigBang_Timer < diff)
                {
                    DoCast(me->getVictim(), RAID_MODE(A_BigBang_H, A_BigBang));
                    switch (rand()%2)
                    {
                    case 0: DoScriptText(Say_BigBang1, me); break;
                    case 1: DoScriptText(Say_BigBang2, me); break;
                    }
                    BigBang_Timer = 90000;
                } else BigBang_Timer -= diff;

                // seens that we dont need that - black holes arent despawn after casting big bang
                if (JustCastedBigBang)
                {
                    JustCastedBigBang = false;

                //    if (!BlackHole_GUID.empty())
                //        AddsDespawn(BlackHole_GUID);

                    ThreatList const& list = me->getThreatManager().getThreatList();
                    for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
                    {
                        if (Unit* pU = Unit::GetUnit((*me), (*i)->getUnitGuid()))
                        {
                            if (pU->HasAura(62169))
                                pU->RemoveAurasDueToSpell(62169);
                            if (pU->HasAura(62168))
                                pU->RemoveAurasDueToSpell(62168);

                            pU->ApplySpellImmune(RAID_MODE(A_BigBang_H, A_BigBang), IMMUNITY_ID, 0, false);
                        }
                    }
                }

                // w pierwszej fazie przy okazji algalon przywoluje 4 collapsing star
                if (PhasePunch_Timer < diff)
                {
                   DoCast(me->getVictim(), A_PhasePunch);
                    if (me->getVictim()->GetAura(A_PhasePunch) && me->getVictim()->GetAura(A_PhasePunch)->GetStackAmount() >= 5)
                        me->getThreatManager().addThreat(me->getVictim(), -100.0f);

                    //if (CollapsingStar_GUID.size() < MAX_ADDS_COUNT)
                        //SummonCollapsingStar();

                    PhasePunch_Timer = 15000;
                } else PhasePunch_Timer -= diff;

                if (Star_Timer < diff)
                {
                    if (CollapsingStar_GUID.size() < MAX_ADDS_COUNT)
                        SummonCollapsingStar();

                    Star_Timer = 60000;
                } else Star_Timer -= diff;

                if (Constellation_Timer < diff)
                {
                    if (LivingConstellation_GUID.size() < MAX_ADDS_COUNT)
                        SummonLivingConstellation();
                    Constellation_Timer = 50000;
                } else Constellation_Timer -= diff;
            }

            if (Phase2)
            {
                if (PhasePunch_Timer < diff)
                {
                   DoCast(me->getVictim(), A_PhasePunch);
                    if (me->getVictim()->GetAura(A_PhasePunch) && me->getVictim()->GetAura(A_PhasePunch)->GetStackAmount() >= 5)
                        me->getThreatManager().addThreat(me->getVictim(), -100.0f);

                    PhasePunch_Timer = 15000;
                } else PhasePunch_Timer -= diff;
            }

            // WSZYSTKIE FAZY
            if (CosmicSmash_Timer < diff)
            {
                if (!Target)
                {
                    Unit* pT = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    float fX = pT->GetPositionX();
                    float fY = pT->GetPositionY();
                    float fZ = pT->GetPositionZ();
                    float fO = pT->GetOrientation();
                    Creature* target = me->SummonCreature(COSMIC_SMASH_TARGET, fX, fY, fZ, fO, TEMPSUMMON_MANUAL_DESPAWN, 500);
                    TargetGUID = target->GetGUID();
                    DoCast(target, COSMIC_SMASH_MARKER);

                    if (me->GetMap()->IsHeroic())
                    {
                        Unit* pT2 = SelectUnit(SELECT_TARGET_RANDOM, 0);
                        float fX2 = pT2->GetPositionX();
                        float fY2 = pT2->GetPositionY();
                        float fZ2 = pT2->GetPositionZ();
                        float fO2 = pT2->GetOrientation();
                        Creature* target2 = me->SummonCreature(COSMIC_SMASH_TARGET, fX2, fY2, fZ2, fO2, TEMPSUMMON_MANUAL_DESPAWN, 500);
                        Target2GUID = target2->GetGUID();
                        DoCast(target2, COSMIC_SMASH_MARKER);

                        Unit* pT3 = SelectUnit(SELECT_TARGET_RANDOM, 0);
                        float fX3 = pT3->GetPositionX();
                        float fY3 = pT3->GetPositionY();
                        float fZ3 = pT3->GetPositionZ();
                        float fO3 = pT3->GetOrientation();
                        Creature* target3 = me->SummonCreature(COSMIC_SMASH_TARGET, fX3, fY3, fZ3, fO3, TEMPSUMMON_MANUAL_DESPAWN, 500);
                        Target3GUID = target3->GetGUID();
                        DoCast(target3, COSMIC_SMASH_MARKER);

                    }// end if (Hero)

                    Target = true;
                    CosmicSmash_Timer = 7000;
                }//end if (!Target)
                else
                {
                    if (Creature* pT = (Creature*)Unit::GetUnit((*me), TargetGUID))
                    {
                        DoCast(pT, RAID_MODE(A_CosmicSmash, A_CosmicSmash_H));
                        pT->ForcedDespawn();
                    }
                    if (me->GetMap()->IsHeroic())
                    {
                        if (Creature* pT = (Creature*)Unit::GetUnit((*me), Target2GUID))
                        {
                            DoCast(pT, A_CosmicSmash_H);
                            pT->ForcedDespawn();
                        }
                        if (Creature* pT = (Creature*)Unit::GetUnit((*me), Target3GUID))
                        {
                            DoCast(pT, A_CosmicSmash_H);
                            pT->ForcedDespawn();
                        }

                    }//end if (Hero)

                    Target = false;
                    CosmicSmash_Timer = 20000;
                }//end else (if !Target)
            } else CosmicSmash_Timer -= diff;

            if (QuantumStrike_Timer < diff)
            {
                DoCast(me->getVictim(), RAID_MODE(A_QuantumStrike, A_QuantumStrike_H));
                QuantumStrike_Timer = (rand()%3+3)*1000;
            } else QuantumStrike_Timer -= diff;


            // ATAK I BERSERK
            DoMeleeAttackIfReady();

            if (Berserk_Timer < diff)
            {
                DoCast(me, A_AlgalonBerserk);
                DoScriptText(Say_Berserk, me);
                Berserk_Timer = 360000;
            } else Berserk_Timer -= diff;

            }//end if (Fight)
            else
                me->SetStandFlags(UNIT_STAND_FLAGS_UNK1);
        }

        // funkcje

        /********/
        /** CHECK FUNCTIONS **/
        /********/
        bool bAscentToHeavens()
        {
            ThreatList const& list = me->getThreatManager().getThreatList();

            for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
            {
                if (!(Unit::GetUnit((*me), (*i)->getUnitGuid())->HasAura(62169)))
                    return true;
            }
            return false;
        }

        void BlackHoleDespawnCheck()
        {
            bool Despawn;
            for (GuidsList::iterator i = LivingConstellation_GUID.begin(); i != LivingConstellation_GUID.end(); ++i)
            {
                Despawn = false;
                if (Creature* pLC = (Creature*)Unit::GetUnit((*me), (*i)))
                {
                    for (GuidsList::iterator j = BlackHole_GUID.begin(); j != BlackHole_GUID.end(); ++j)
                    {
                        Creature* pBH = (Creature*)Unit::GetUnit((*me), (*j));
                        if (pBH && pLC->GetDistance2d(pBH) < 7.5f)
                        {
                            Despawn = true;
                            BlackHole_GUID.erase(j);
                            LivingConstellation_GUID.erase(i);

                            pLC->ForcedDespawn();
                            pBH->ForcedDespawn();
                            pLC->SetVisibility(VISIBILITY_OFF);
                            pBH->SetVisibility(VISIBILITY_OFF);
                            break;
                        }
                    }

                    if (Despawn)
                        break;
                }
            }

        }

        void UpdateTexts(const uint32 diff)
        {
            if (IntroStart && !IntroEnd)
            {
                if (0 == IntroText)
                    IntroText = 1;

                if (IntroTimer < diff)
                {
                    switch (IntroText)
                    {
                    case 1:
                        DoScriptText(Say_Intro1, me);
                        IntroTimer = 7000;
                        ++IntroText;
                        break;
                    case 2:
                        DoScriptText(Say_Intro2, me);
                        IntroTimer = 5000;
                        ++IntroText;
                        break;
                    case 3:
                        DoScriptText(Say_Intro3, me);
                        IntroTimer = 10000;

                        if (EngagedFirstTime)
                            ++IntroText;
                        else
                        {
                            IntroEnd = true; DoStartCombat();
                        }
                        break;

                    case 4:
                        DoScriptText(Say_FirstTime, me);
                        IntroEnd = true;
                        DoStartCombat();
                        break;
                    }

                } else IntroTimer -= diff;
            }

            if (DespawnStart && !DespawnEnd)
            {
                if (DespawnTimer < diff)
                {
                    if (0 == DespawnText)
                        DespawnText = 1;

                    switch (DespawnText)
                    {
                    case 1:
                        DoScriptText(Say_Despawn1, me);
                        DespawnTimer = 11000;
                        ++DespawnText;
                        break;
                    case 2:
                        DoScriptText(Say_Despawn2, me);
                        DespawnTimer = 8000;
                        ++DespawnText;
                        break;
                    case 3:
                        DoScriptText(Say_Despawn3, me);
                        DespawnTimer = 7000;
                        ++DespawnText;
                        break;
                    case 4:
                        DespawnEnd = true;
                        break;
                    }

                } else DespawnTimer -= diff;
            }

            if (DefeatedStart &&  !DefeatedEnd)
            {
                if (DefeatedTimer < diff)
                {
                    if (0 == DefeatedText)
                    {
                        me->SummonGameObject(194821, 1634.258667f, -295.101166f,417.321381f,0,0,0,0,0,0);
                        DefeatedText = 1;
                    }

                    switch (DefeatedText)
                    {
                    case 1:
                        DoScriptText(Say_Defeated1, me);
                        DefeatedTimer = 38000;
                        ++DefeatedText;
                        break;
                    case 2:
                        DoScriptText(Say_Defeated2, me);
                        DefeatedTimer = 16000;
                        ++DefeatedText;
                        break;
                    case 3:
                        DoScriptText(Say_Defeated3, me);
                        DefeatedTimer = 9000;
                        ++DefeatedText;
                        break;
                    case 4:
                        DoScriptText(Say_Defeated4, me);
                        DefeatedTimer = 10000;
                        ++DefeatedText;
                        break;
                    case 5:
                        DoScriptText(Say_Defeated5, me);
                        DefeatedTimer = 10000;
                        ++DefeatedText;
                        break;
                    case 6:
                        DefeatedEnd = true;
                        me->DisappearAndDie();
                        break;
                    }

                } else DefeatedTimer -= diff;
            }
        }
        /********/
        /** COMBAT FUNCTIONS **/
        /********/
        void DoPhase2()
        {

            AddsDespawn(CollapsingStar_GUID);
            AddsDespawn(LivingConstellation_GUID);
            AddsDespawn(BlackHole_GUID);

            for (int i = 0; i < 4; ++i)
                me->SummonCreature(BLACK_HOLE, aPhase2[i][0], aPhase2[i][1], aPhase2[i][2], aPhase2[i][3], TEMPSUMMON_DEAD_DESPAWN, 500);

        }
        void DoStartCombat()
        {
            DoZoneInCombat();
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9);
            AttackStart(SelectUnit(SELECT_TARGET_RANDOM, 0));
            SetCombatMovement(true);
            Fight = true;
        }

        void DoStopCombat(bool end, bool defeated = false)
        {
            me->SetReactState(REACT_PASSIVE);
            if (end && defeated)
            {
                me->RemoveAllAttackers();
                me->getThreatManager().clearReferences();
                me->AttackStop();
            }

            me->SetFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9);
            SetCombatMovement(false);
            me->GetMotionMaster()->MoveIdle();
            if (end)
            {
                if (defeated)
                {
                    DefeatedStart = true;
                    me->setFaction(FACTION_FRIENDLY);
                }
                else
                    DespawnStart = true;

                DespawnAll();
            }
            Fight = false;
        }


        /*********/
        /** ADDS FUNCTIONS **/
        /********/
        void SummonCollapsingStar()
        {
            DoScriptText(Say_SummoningStar, me);
            uint32 random1;
            uint32 random2;
            uint32 random3;
            uint32 random4;

            do
            {
                random1 = urand(0, 9);
                random2 = urand(0, 9);
                random3 = urand(0, 9);
                random4 = urand(0, 9);
            }
            while
                (random1 == random2
                || random1 == random3
                || random1 == random4
                || random2 == random3
                || random2 == random4
                || random3 == random4);

            float fX1 = Positions[random1][0];
            float fY1 = Positions[random1][1];
            float fZ1 = Positions[random1][2];
            float fO1 = Positions[random1][3];

            float fX2 = Positions[random2][0];
            float fY2 = Positions[random2][1];
            float fZ2 = Positions[random2][2];
            float fO2 = Positions[random2][3];

            float fX3 = Positions[random3][0];
            float fY3 = Positions[random3][1];
            float fZ3 = Positions[random3][2];
            float fO3 = Positions[random3][3];

            float fX4 = Positions[random4][0];
            float fY4 = Positions[random4][1];
            float fZ4 = Positions[random4][2];
            float fO4 = Positions[random4][3];

            GuidsList& list = CollapsingStar_GUID;

            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(STAR, fX1, fY1, fZ1, fO1, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(STAR, fX2, fY2, fZ2, fO2, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(STAR, fX3, fY3, fZ3, fO3, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(STAR, fX4, fY4, fZ4, fO4, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
        }

        void SummonLivingConstellation()
        {
            uint32 random1;
            uint32 random2;
            uint32 random3;

            do
            {
                random1 = urand(0, 9);
                random2 = urand(0, 9);
                random3 = urand(0, 9);
            }
            while
                (random1 == random2
                || random1 == random3
                || random2 == random3);

            float fX1 = Positions[random1][0];
            float fY1 = Positions[random1][1];
            float fZ1 = Positions[random1][2];
            float fO1 = Positions[random1][3];

            float fX2 = Positions[random2][0];
            float fY2 = Positions[random2][1];
            float fZ2 = Positions[random2][2];
            float fO2 = Positions[random2][3];

            float fX3 = Positions[random3][0];
            float fY3 = Positions[random3][1];
            float fZ3 = Positions[random3][2];
            float fO3 = Positions[random3][3];

            GuidsList& list = LivingConstellation_GUID;

            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(CONSTELLATION, fX1, fY1, fZ1+5, fO1, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(CONSTELLATION, fX2, fY2, fZ2+5, fO2, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
            if (list.size() < MAX_ADDS_COUNT)
            {
                if (Creature* pAdd = me->SummonCreature(CONSTELLATION, fX3, fY3, fZ3+5, fO3, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    Unit* target;
                    do{
                        target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    }while (target->GetTypeId() != TYPEID_PLAYER);
                    if (target)
                        pAdd->AI()->AttackStart(target);
                }
            }
            else return;
        }
        void DespawnAll()
        {
            if (!LivingConstellation_GUID.empty())
                AddsDespawn(LivingConstellation_GUID);
            if (!CollapsingStar_GUID.empty())
                AddsDespawn(CollapsingStar_GUID);
            if (!BlackHole_GUID.empty())
                AddsDespawn(BlackHole_GUID);
            if (!DarkMattery_GUID.empty())
                AddsDespawn(DarkMattery_GUID);
        }
        void AddsDespawn(GuidsList& list)
        {
            if (list.empty())
                return;

            for (GuidsList::iterator i = list.begin(); i != list.end(); ++i)
            {
                if (Creature* pAdd = (Creature*)Unit::GetUnit((*me), (*i)))
                    pAdd->ForcedDespawn();
            }
            list.clear();
        }

        void EraseDespawnedAdd(GuidsList& list, uint64 guid)
        {
            if (list.empty())
                return;

            GuidsList::iterator itr = list.begin();
            while (itr != list.end())
            {
                GuidsList::iterator next = itr;
                ++next;

                if (*itr == guid)
                    list.erase(itr);

                itr = next;
            }
        }
    };
};

class mob_collapsing_star : public CreatureScript
{
public:
    mob_collapsing_star() : CreatureScript("mob_collapsing_star") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_collapsing_starAI(pCreature);
    }

    struct mob_collapsing_starAI : public ScriptedAI
    {
        mob_collapsing_starAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            Instance = pCreature->GetInstanceScript();
            pCreature->setFaction(FACTION_HOSTILE);
            Reset();
        }

        //zmienne
        InstanceScript* Instance;
        uint32 LiveTimer; // add loses 1% of his maximum hp every second
        bool Dead;
        uint32 Dead_Timer;

        Position prev_pos;
        Position next_pos;
        bool isMoving;

        void Reset()
        {
            LiveTimer = 1000; // 1s
            Dead = false;
            Dead_Timer = 1000;

            me->SetSpeed(MOVE_RUN, 0.50f);
            me->SetSpeed(MOVE_FLIGHT, 0.50f);
            me->SetFlying(true);

            prev_pos = *me;
            next_pos = *me;
            isMoving = false;
        }

        void DamageTaken(Unit* pBy, uint32& damage)
        {
            if (!isMoving && pBy->GetExactDist2d(&prev_pos) > 20.0f)
            {
                isMoving = true;
                next_pos = *pBy;
                prev_pos = *me;
            }

            if (damage > me->GetHealth())
            {
                Dead = true;
                damage = 0;
            }
        }

        void JustDied(Unit* pKiller)
        {
            Creature* pAlgalon = GET_ALGALON;
            pAlgalon->SummonCreature(BLACK_HOLE, (*me), TEMPSUMMON_DEAD_DESPAWN, 500);
            me->ForcedDespawn();
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE) return;
            if (id == 0)
            {
                isMoving = false;
            }
        }

        //UpdateAI
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            // add always loses hp - no matter what
            if (LiveTimer < diff)
            {
                uint32 OnePercent = me->GetMaxHealth()/100;
                if (OnePercent < me->GetHealth())
                    me->SetHealth(me->GetHealth() - OnePercent);
                else
                    Dead = true;
                LiveTimer = 1000;
            } else LiveTimer -= diff;

            Unit* pAlgalon = GET_ALGALON;

            if (Dead)
            {
                DoCast(pAlgalon->getVictim(), RAID_MODE(CS_EXPLODION, CS_EXPLODION_H));
                DoCast(me, 62003); // explodion visual
                if (Dead_Timer < diff)
                {
                    if (pAlgalon && pAlgalon->isAlive() && pAlgalon->isInCombat())
                        pAlgalon->SummonCreature(BLACK_HOLE, (*me), TEMPSUMMON_DEAD_DESPAWN, 500);
                    me->ForcedDespawn();
                } else Dead_Timer -= diff;
            }

            if (isMoving)
                DoMovement();

            DoMeleeAttackIfReady();
        }


        void DoMovement()
        {
            if (me->GetExactDist2d(&next_pos) <= 5.0f)
            {
                me->StopMoving();
                DoResetThreat();
                isMoving = false;
            }
            else
                me->GetMotionMaster()->MovePoint(0, next_pos);
        }
    };
};

class mob_living_constellation : public CreatureScript
{
public:
    mob_living_constellation() : CreatureScript("mob_living_constellation") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_living_constellationAI(pCreature);
    }

    struct mob_living_constellationAI : public ScriptedAI
    {
        mob_living_constellationAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            Instance = ((InstanceScript*)pCreature->GetInstanceScript());
            pCreature->setFaction(FACTION_HOSTILE);
            Reset();
        }

        //zmienne
        InstanceScript* Instance;

        void Reset()
        {
            me->SetFlying(true);
        }

        //UpdateAI
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_black_hole : public CreatureScript
{
public:
    mob_black_hole() : CreatureScript("mob_black_hole") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_black_holeAI(pCreature);
    }

    struct mob_black_holeAI : public ScriptedAI
    {
        mob_black_holeAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            SetCombatMovement(false);
            Instance = pCreature->GetInstanceScript();
            pCreature->setFaction(FACTION_NEUTRAL); // Algalon faction
            Reset();
        }

        InstanceScript* Instance;
        uint32 Summon_Timer;
        uint32 DarkMattery_Count;
        std::map<uint64, uint32> Timers;

        void Reset()
        {
            Timers.clear();
            me->SetFlag64(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_UNK_16|UNIT_FLAG_UNK_9|UNIT_FLAG_NOT_SELECTABLE);
            Summon_Timer = 5000;
            DarkMattery_Count = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!Instance)
                me->ForcedDespawn();

            Creature* pAlgalon = GET_ALGALON;

            if (!pAlgalon->isAlive())
                me->ForcedDespawn();

            if (dynamic_cast<boss_algalon_the_observer::boss_algalon_the_observerAI*>(pAlgalon->AI())->DespawnStart)
                return;

            if (!dynamic_cast<boss_algalon_the_observer::boss_algalon_the_observerAI*>(pAlgalon->AI())->Phase2)
            {
                ThreatList const& list = pAlgalon->getThreatManager().getThreatList();
                for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
                {
                    Unit* pP = Unit::GetUnit((*me), (*i)->getUnitGuid());
                    std::map<uint64, uint32>::iterator itr = Timers.find(pP->GetGUID()); // lookup for position with player's GUID

                    if (isNearestBlackHole(pP))
                    {
                        //sLog.outBasic("Black Hole %u is nearest black holes for player %s, distance %f", me->GetGUID(), pP->GetName(), me->GetDistance2d(pP));
                        if (me->GetDistance2d(pP) < 5.0f)
                        {
                            if (itr != Timers.end()) // if 'find' find position
                            {
                                if (itr->second >= 2000)
                                {
                                    SpellEntry const* dota = GetSpellStore()->LookupEntry(62169); // Black Hole DoT (~1,5k na sec)
                                    SpellEntry const* debuff = GetSpellStore()->LookupEntry(62168); // debuff - visual "ghost" effect

                                    if (debuff && !pP->HasAura(62168))
                                        pP->AddAura(62168, pP);
                                    if (dota && !pP->HasAura(62169))
                                        pP->AddAura(62169, pP);

                                    pP->ApplySpellImmune(0, IMMUNITY_ID, A_BigBang, true);
                                    pAlgalon->getThreatManager().modifyThreatPercent(pP, -100);

                                    Timers.erase(itr); // erase position
                                }// end if (itr->second >= 2000)
                                else
                                    Timers[pP->GetGUID()] = itr->second+diff; //add 'diff' to timer

                            }// end if (Timers.find(pP->GetGUID()))
                            else
                                Timers.insert(std::make_pair(pP->GetGUID(), diff)); // add position for player with 'diff' time

                        }// end if (me->GetDistance2d(pP) < 5.0f)
                        else if (itr != Timers.end())
                        {
                            Timers.erase(itr);

                            if (!pP->HasAura(62168))
                            {
                                pP->ApplySpellImmune(0, IMMUNITY_ID, A_BigBang, false);
                                pP->RemoveAurasDueToSpell(62168);
                                pP->RemoveAurasDueToSpell(62169);
                            }
                            else if (!pP->HasAura(62169))
                                pP->AddAura(62169, pP);
                        }
                    }
                }//koniec for
            }
            else // if (!Phase2)
            {
                // druga faza
                if (pAlgalon->GetHealth()*100/pAlgalon->GetMaxHealth() <= 20)
                {
                    if (Summon_Timer < diff)
                    {
                        if (DarkMattery_Count < MAX_MATTERY_COUNT)
                        {
                            Creature* DM = pAlgalon->SummonCreature(UNLEASHED_DM, (*me), TEMPSUMMON_DEAD_DESPAWN, 500);

                            if (DM)
                                DM->AI()->AttackStart(pAlgalon->AI()->SelectTarget(SELECT_TARGET_RANDOM));
                            ++DarkMattery_Count;
                        }
                        Summon_Timer = 30000;
                    } else Summon_Timer -= diff;
                }
            }
        }


        bool isNearestBlackHole(Unit* pUnit)
        {
            Creature* pAlgalon = GET_ALGALON;
            float MyDis = me->GetDistance2d(pUnit);

            GuidsList const& list = dynamic_cast<boss_algalon_the_observer::boss_algalon_the_observerAI*>(pAlgalon->AI())->BlackHole_GUID;
            for (GuidsList::const_iterator i = list.begin(); i != list.end(); ++i)
            {
                Creature* pBH = (Creature*)Unit::GetUnit((*me), (*i));
                if (pBH->GetGUID() != me->GetGUID())
                    if (pUnit->GetDistance2d(pBH) < MyDis)
                        return false;
            }
            return true;
        }
    };
};

class mob_cosmic_smash_target : public CreatureScript
{
public:
    mob_cosmic_smash_target() : CreatureScript("mob_cosmic_smash_target") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_cosmic_smash_targetAI(pCreature);
    }

    struct mob_cosmic_smash_targetAI : public ScriptedAI
    {
        mob_cosmic_smash_targetAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            SetCombatMovement(false);
            Instance = (InstanceScript*)pCreature->GetInstanceScript();
            pCreature->SetVisibility(VISIBILITY_OFF);
            Reset();
        }

        InstanceScript* Instance;

        void Reset()
        {
            me->SetDisplayId(DISPLAY_CIRCLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;
        }
    };
};

class mob_dark_mattery : public CreatureScript
{
public:
    mob_dark_mattery() : CreatureScript("mob_dark_mattery") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_dark_matteryAI(pCreature);
    }

    struct mob_dark_matteryAI : public ScriptedAI
    {
        mob_dark_matteryAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            Instance = (InstanceScript*)pCreature->GetInstanceScript();
            Reset();
        }

        InstanceScript* Instance;

        bool Anyone;
        std::vector<uint64> Targets;

        void Reset()
        {
            Anyone = false;
            Targets.clear();
        }

        void UpdateAI(const uint32 diff)
        {
            if (!Instance)
                me->ForcedDespawn();

            Creature* pAlgalon = GET_ALGALON;
            if (!pAlgalon || !pAlgalon->isAlive())
                me->ForcedDespawn();
            if (!pAlgalon->isInCombat())
                me->ForcedDespawn();

            me->AddAura(62168, me);

            ThreatList const& list = pAlgalon->getThreatManager().getThreatList();

            Anyone = false;
            Targets.clear();
            for (ThreatList::const_iterator i = list.begin(); i != list.end(); ++i)
            {
                if (Unit* pP = Unit::GetUnit((*me), (*i)->getUnitGuid()))
                    if (pP->HasAura(62168) && pP->isAlive())
                    {
                        Anyone = true;
                        Targets.push_back(pP->GetGUID());
                    }
            }

            if (Anyone)
            {
                uint32 random = urand(0, Targets.size()-1);
                if (Unit* pT = Unit::GetUnit((*me), Targets[random]))
                    me->AI()->AttackStart(pT);
            }
            else
            {
                me->AttackStop();
                me->CombatStop(true);
                me->GetMotionMaster()->MoveIdle();
            }
        }
    };
};

/******************************/

void AddSC_boss_algalon()
{
    new boss_algalon_the_observer();
    new mob_collapsing_star();
    new mob_living_constellation();
    new mob_black_hole();
    new mob_cosmic_smash_target();
    new mob_dark_mattery();
}
