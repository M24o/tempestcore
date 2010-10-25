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
SDName: Freya
SDAuthor: PrinceCreed
SD%Complete: 95
SD%Comments: TODO: better Iron roots implementation
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"

enum Yells
{
    SAY_AGGRO                                   = -1603180,
    SAY_AGGRO_WITH_ELDER                        = -1603181,
    SAY_SLAY_1                                  = -1603182,
    SAY_SLAY_2                                  = -1603183,
    SAY_DEATH                                   = -1603184,
    SAY_BERSERK                                 = -1603185,
    SAY_SUMMON_CONSERVATOR                      = -1603186,
    SAY_SUMMON_TRIO                             = -1603187,
    SAY_SUMMON_LASHERS                          = -1603188,
    SAY_YS_HELP                                 = -1603189,

    // Elder Brightleaf
    SAY_BRIGHTLEAF_AGGRO                        = -1603190,
    SAY_BRIGHTLEAF_SLAY_1                       = -1603191,
    SAY_BRIGHTLEAF_SLAY_2                       = -1603192,
    SAY_BRIGHTLEAF_DEATH                        = -1603193,

    // Elder Ironbranch
    SAY_IRONBRANCH_AGGRO                        = -1603194,
    SAY_IRONBRANCH_SLAY_1                       = -1603195,
    SAY_IRONBRANCH_SLAY_2                       = -1603196,
    SAY_IRONBRANCH_DEATH                        = -1603197,

    // Elder Stonebark
    SAY_STONEBARK_AGGRO                         = -1603198,
    SAY_STONEBARK_SLAY_1                        = -1603199,
    SAY_STONEBARK_SLAY_2                        = -1603200,
    SAY_STONEBARK_DEATH                         = -1603201
};

#define EMOTE_GIFT         "A Lifebinder's Gift begins to grow!"
#define EMOTE_ALLIES       "Allies of Nature have appeared!"

#define ACHIEVEMENT_KNOCK_ON_WOOD_1     RAID_MODE(3177, 3185)
#define ACHIEVEMENT_KNOCK_ON_WOOD_2     RAID_MODE(3178, 3186)
#define ACHIEVEMENT_KNOCK_ON_WOOD_3     RAID_MODE(3179, 3187)
#define ACHIEVEMENT_BACK_TO_NATURE      RAID_MODE(2982, 2983)

enum Spells
{
    // Freya
    SPELL_ATTUNED_TO_NATURE                     = 62519,
    RAID_10_SPELL_TOUCH_OF_EONAR                = 62528,
    RAID_25_SPELL_TOUCH_OF_EONAR                = 62892,
    RAID_10_SPELL_SUNBEAM                       = 62623,
    RAID_25_SPELL_SUNBEAM                       = 62872,
    SPELL_SUN_BEAM_SUMMON                       = 62450,
    SPELL_EONAR_GIFT                            = 62572,
    SPELL_NATURE_BOMB                           = 64604,
    SPELL_NATURE_BOMB_VISUAL                    = 64648,
    SPELL_SUMMON_ALLIES                         = 62678,
    SPELL_BERSERK                               = 47008,
    RAID_10_SPELL_FREYA_GROUND_TREMOR           = 62437,
    RAID_25_SPELL_FREYA_GROUND_TREMOR           = 62859,
    RAID_10_SPELL_FREYA_IRON_ROOTS              = 62283,
    RAID_25_SPELL_FREYA_IRON_ROOTS              = 62930,
    RAID_10_SPELL_FREYA_UNSTABLE_ENERGY         = 62451,
    RAID_25_SPELL_FREYA_UNSTABLE_ENERGY         = 62865,
    SPELL_STONEBARKS_ESSENCE                    = 62386,
    SPELL_IRONBRANCHS_ESSENCE                   = 62387,
    SPELL_BRIGHTLEAFS_ESSENCE                   = 62385,
    SPELL_DRAINED_OF_POWER                      = 62467,
    RAID_10_0_SPELL_FREYA_CHEST                 = 62950,
    RAID_10_1_SPELL_FREYA_CHEST                 = 62952,
    RAID_10_2_SPELL_FREYA_CHEST                 = 62953,
    RAID_10_3_SPELL_FREYA_CHEST                 = 62954,
    RAID_25_0_SPELL_FREYA_CHEST                 = 62955,
    RAID_25_1_SPELL_FREYA_CHEST                 = 62956,
    RAID_25_2_SPELL_FREYA_CHEST                 = 62957,
    RAID_25_3_SPELL_FREYA_CHEST                 = 62958,
       
    // Detonating Lasher
    RAID_10_SPELL_DETONATE                      = 62598,
    RAID_25_SPELL_DETONATE                      = 62937,
    SPELL_FLAME_LASH                            = 62608,
        
    // Ancient Conservator
    SPELL_CONSERVATORS_GRIP                     = 62532,
    RAID_10_SPELL_NATURES_FURY                  = 62589,
    RAID_25_SPELL_NATURES_FURY                  = 63571,
    
    // Ancient Water Spirit
    SPELL_TIDAL_WAVE                            = 62935,
    
    // Storm Lasher
    RAID_10_SPELL_LIGHTNING_LASH                = 62648,
    RAID_25_SPELL_LIGHTNING_LASH                = 62939,
    RAID_10_SPELL_STORMBOLT                     = 62649,
    RAID_25_SPELL_STORMBOLT                     = 62938,
    
    // Snaplasher
    RAID_10_SPELL_HARDENED_BARK                 = 62664,
    RAID_25_SPELL_HARDENED_BARK                 = 64191,
    
    // Nature Bomb
    RAID_10_SPELL_NATURE_BOMB                   = 64587,
    RAID_25_SPELL_NATURE_BOMB                   = 64650,
    
    // Eonars_Gift
    RAID_10_SPELL_LIFEBINDERS_GIFT              = 62584,
    RAID_25_SPELL_LIFEBINDERS_GIFT              = 64185,
    SPELL_PHEROMONES                            = 62619,
    SPELL_EONAR_VISUAL                          = 62579,
    
    // Healthy Spore
    SPELL_HEALTHY_SPORE_VISUAL                  = 62538,
    SPELL_GROW                                  = 62559,
    SPELL_POTENT_PHEROMONES                     = 62541,
    SPELL_POTENT_PHEROMONES_AURA                = 64321,
    
    // Elder Stonebark
    RAID_10_SPELL_PETRIFIED_BARK                = 62337,
    RAID_25_SPELL_PETRIFIED_BARK                = 62933,
    SPELL_FISTS_OF_STONE                        = 62344,
    RAID_10_SPELL_GROUND_TREMOR                 = 62325,
    RAID_25_SPELL_GROUND_TREMOR                 = 62932,
    
    // Elder Ironbranch
    RAID_10_SPELL_IMPALE                        = 62310,
    RAID_25_SPELL_IMPALE                        = 62928,
    RAID_10_SPELL_THORN_SWARM                   = 64060,
    RAID_25_SPELL_THORN_SWARM                   = 64071,
    RAID_10_SPELL_IRON_ROOTS                    = 62438,
    RAID_25_SPELL_IRON_ROOTS                    = 62861,
    
    // Elder Brightleaf
    SPELL_BRIGHTLEAF_FLUX                       = 62239,
    RAID_10_SPELL_UNSTABLE_ENERGY               = 62217,
    RAID_25_SPELL_UNSTABLE_ENERGY               = 62922,
    RAID_10_SPELL_SOLAR_FLARE                   = 62240,
    RAID_25_SPELL_SOLAR_FLARE                   = 62920,
    SPELL_PHOTOSYNTHESIS                        = 62209,
    SPELL_UNSTABLE_SUN_BEAM                     = 62211,
    SPELL_UNSTABLE_SUN_BEAM_SUMMON              = 62450,
    SPELL_UNSTABLE_SUN_BEAM_VISUAL              = 62216
};

enum FreyaNpcs
{
    NPC_SUN_BEAM                                = 33170,
    NPC_DETONATING_LASHER                       = 32918,
    NPC_ANCIENT_CONSERVATOR                     = 33203,
    NPC_ANCIENT_WATER_SPIRIT                    = 33202,
    NPC_STORM_LASHER                            = 32919,
    NPC_SNAPLASHER                              = 32916,
    NPC_NATURE_BOMB                             = 34129,
    OBJECT_NATURE_BOMB                          = 194902,
    NPC_EONARS_GIFT                             = 33228,
    NPC_HEALTHY_SPORE                           = 33215,
    NPC_UNSTABLE_SUN_BEAM                       = 33050
};

enum Events
{
    EVENT_NONE,
    EVENT_SUNBEAM,
    EVENT_EONAR_GIFT,
    EVENT_SUMMON_ALLIES,
    EVENT_NATURE_BOMB,
    EVENT_BRIGHTLEAF,
    EVENT_IRONBRANCH,
    EVENT_STONEBARK,
    EVENT_PHASE_2,
    EVENT_BERSERK
};

enum Actions
{
    ACTION_LASHER                               = 0,
    ACTION_ELEMENTAL                            = 1,
    ACTION_ANCIENT                              = 2,
    ACTION_ELEMENTAL_DEAD                       = 3
};

Unit* pRootTarget;

class boss_freya : public CreatureScript
{
public:
    boss_freya() : CreatureScript("boss_freya") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_freyaAI(pCreature);
    }

    struct boss_freyaAI : public BossAI
    {
        boss_freyaAI(Creature* pCreature) : BossAI(pCreature, BOSS_FREYA)
        {
            pInstance = pCreature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
        }

        InstanceScript* pInstance;

        uint8 spawnOrder[3];
        uint8 spawnedAdds;
        uint8 EldersCount;
        int32 uiElemTimer;
        Creature* Elemental[3];
        bool checkElementalAlive;

        void Reset()
        {
            _Reset();
            
            spawnedAdds = 0;
            EldersCount = 0;
            checkElementalAlive = true;
            randomizeSpawnOrder();
        }

        void KilledUnit(Unit *victim)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_DEATH, me);
            _JustDied();
            
            me->setFaction(35);
            
            if (pInstance)
            {
                // Kill credit
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 65074);
                // Knock on Wood
                if (EldersCount == 1)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_KNOCK_ON_WOOD_1);
                // Knock, Knock on Wood 
                if (EldersCount == 2)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_KNOCK_ON_WOOD_2);
                // Knock, Knock, Knock on Wood
                if (EldersCount == 3)
                    pInstance->DoCompleteAchievement(ACHIEVEMENT_KNOCK_ON_WOOD_3);
                // Getting Back to Nature
                if (me->HasAura(SPELL_ATTUNED_TO_NATURE))
                    if (me->GetAura(SPELL_ATTUNED_TO_NATURE, 0)->GetStackAmount() >= 25)
                        pInstance->DoCompleteAchievement(ACHIEVEMENT_BACK_TO_NATURE);
            }
            
            // Hard mode chest
            uint32 chest;
            switch (EldersCount)
            {
                case 0:
                    chest = RAID_MODE(194324, 194328);
                    break;
                case 1:
                    chest = RAID_MODE(194325, 194329);
                    break;
                case 2:
                    chest = RAID_MODE(194326, 194330);
                    break;
                case 3:
                    chest = RAID_MODE(194327, 194331);
                    break;
            }
            // Summon spells not work correctly, chest respawn is infinite
            me->SummonGameObject(chest,(me->GetPositionX()+15*cos(me->GetOrientation())),(me->GetPositionY()+15*sin(me->GetOrientation())),me->GetPositionZ(),me->GetOrientation(),0,0,1,0,0);
        }

        void EnterCombat(Unit* pWho)
        {
            _EnterCombat();
            
            DoCast(me, RAID_MODE(RAID_10_SPELL_TOUCH_OF_EONAR, RAID_25_SPELL_TOUCH_OF_EONAR));
            for (uint32 i = 0; i < 150; ++i)
                DoCast(me, SPELL_ATTUNED_TO_NATURE);

            events.ScheduleEvent(EVENT_SUNBEAM, 20000);
            events.ScheduleEvent(EVENT_EONAR_GIFT, 30000);
            events.ScheduleEvent(EVENT_SUMMON_ALLIES, 10000);
            events.ScheduleEvent(EVENT_NATURE_BOMB, 375000);
            events.ScheduleEvent(EVENT_BERSERK, 600000);
            
            // Freya hard mode can be triggered simply by letting the elders alive
            if(Creature* Brightleaf = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_BRIGHTLEAF) : 0))
                if(Brightleaf->isAlive())
                {
                    EldersCount++;
                    DoCast(SPELL_BRIGHTLEAFS_ESSENCE);
                    me->AddAura(SPELL_BRIGHTLEAFS_ESSENCE, me);
                    events.ScheduleEvent(EVENT_BRIGHTLEAF, urand(15000, 30000));
                }
                
            if(Creature* Ironbranch = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_IRONBRANCH) : 0))
                if(Ironbranch->isAlive())
                {
                    EldersCount++;
                    DoCast(SPELL_IRONBRANCHS_ESSENCE);
                    me->AddAura(SPELL_IRONBRANCHS_ESSENCE, me);
                    events.ScheduleEvent(EVENT_IRONBRANCH, urand(45000, 60000));
                }
                
            if(Creature* Stonebark = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_STONEBARK) : 0))
                if(Stonebark->isAlive())
                {
                    EldersCount++;
                    DoCast(SPELL_STONEBARKS_ESSENCE);
                    me->AddAura(SPELL_STONEBARKS_ESSENCE, me);
                    events.ScheduleEvent(EVENT_STONEBARK, urand(35000, 45000));
                }
                
            if (EldersCount == 0)
                DoScriptText(SAY_AGGRO, me);
            else
                DoScriptText(SAY_AGGRO_WITH_ELDER, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            // Elementals must be killed within 12 seconds of each other, or they will all revive and heal
            if (checkElementalAlive)
                uiElemTimer = 0;
            else
            {
                uiElemTimer += diff;
                if (uiElemTimer > 12000)
                {
                    for (uint32 i = 0; i < 3; i++)
                    {
                        if (Elemental[i]->isAlive())
                            Elemental[i]->SetHealth(Elemental[i]->GetMaxHealth());
                        else
                            Elemental[i]->Respawn();
                    }
                    checkElementalAlive = true;
                }
                else
                {
                    if (Elemental[0]->isDead())
                        if (Elemental[1]->isDead())
                            if (Elemental[2]->isDead())
                            {
                                for (uint32 i = 0; i < 3; i++)
                                    Elemental[i]->ForcedDespawn(3000);
                                    
                                if (Creature* Freya = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_FREYA) : 0))
                                    Freya->AI()->DoAction(ACTION_ELEMENTAL);
                            }
                }
            }
                               
            if (me->getVictim() && !me->getVictim()->GetCharmerOrOwnerPlayerOrPlayerItself())
                me->Kill(me->getVictim());
                
            events.Update(diff);
                            
            if (events.GetTimer() > 360000)
                events.CancelEvent(EVENT_SUMMON_ALLIES);
                
            if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

            while(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_SUNBEAM:
                        if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            if (pTarget->isAlive())
                                DoCast(pTarget, RAID_MODE(RAID_10_SPELL_SUNBEAM, RAID_25_SPELL_SUNBEAM));
                        events.ScheduleEvent(EVENT_SUNBEAM, urand(10000, 15000));
                        break;
                    case EVENT_EONAR_GIFT:
                        me->MonsterTextEmote(EMOTE_GIFT, 0, true);
                        DoCast(SPELL_EONAR_GIFT);
                        events.ScheduleEvent(EVENT_EONAR_GIFT, urand(35000, 45000));
                        break;
                    case EVENT_SUMMON_ALLIES:
                        me->MonsterTextEmote(EMOTE_ALLIES, 0, true);
                        DoCast(me, SPELL_SUMMON_ALLIES);
                        spawnAdd();
                        events.ScheduleEvent(EVENT_SUMMON_ALLIES, 60000);
                        break;
                    case EVENT_NATURE_BOMB:
                        DoCastAOE(SPELL_NATURE_BOMB_VISUAL);
                        DoCastAOE(SPELL_NATURE_BOMB);
                        events.ScheduleEvent(EVENT_NATURE_BOMB, urand(15000, 20000));
                        break;
                    case EVENT_BRIGHTLEAF:
                        for (int8 n = 0; n < 3; n++)
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                                DoCast(pTarget, SPELL_SUN_BEAM_SUMMON);
                        events.ScheduleEvent(EVENT_BRIGHTLEAF, urand(35000, 45000));
                        break;
                    case EVENT_IRONBRANCH:
                        if (pRootTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            pRootTarget->CastSpell(pRootTarget,RAID_MODE(RAID_10_SPELL_IRON_ROOTS, RAID_25_SPELL_IRON_ROOTS),true);
                        events.ScheduleEvent(EVENT_IRONBRANCH, urand(45000, 60000));
                        break;
                    case EVENT_STONEBARK:
                        DoCastAOE(RAID_MODE(RAID_10_SPELL_FREYA_GROUND_TREMOR, RAID_25_SPELL_FREYA_GROUND_TREMOR));
                        events.ScheduleEvent(EVENT_STONEBARK, urand(25000, 30000));
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
        
        void randomizeSpawnOrder()
        {
            //Spawn order algorithm
            spawnOrder[0] = 0; //Detonating Lasher
            spawnOrder[1] = 1; //Elemental Adds 
            spawnOrder[2] = 2; //Ancient Conservator
            
            //Swaps the entire array
            for(uint8 n = 0; n < 3; n++)
            {
                uint8 random = rand() % 2;
                uint8 temp = spawnOrder[random];
                spawnOrder[random] = spawnOrder[n];
                spawnOrder[n] = temp;
            }
        }

        void spawnAdd()
        {
            switch(spawnedAdds)
            {
                case 0: spawnHandler(spawnOrder[0]);break;
                case 1: spawnHandler(spawnOrder[1]);break;
                case 2: spawnHandler(spawnOrder[2]);break;
            }

            spawnedAdds++;
            if(spawnedAdds > 2)
            {
                spawnedAdds = 0;
            }
        }

        void spawnHandler(uint8 add)
        {
            switch(add)
            {
                case 0:
                {
                    DoScriptText(SAY_SUMMON_LASHERS, me);
                    //Spawn 10 Detonating Lashers
                    for(uint8 n = 0; n < 10; n++)
                    {
                        //Make sure that they don't spawn in a pile
                        int8 randomX = -25 + rand() % 50;
                        int8 randomY = -25 + rand() % 50;
                        me->SummonCreature(NPC_DETONATING_LASHER, me->GetPositionX() + randomX, me->GetPositionY() + randomY, me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1500);
                    }
                    break;
                }
                case 1:
                {
                    DoScriptText(SAY_SUMMON_TRIO, me);
                    //Make sure that they don't spawn in a pile
                    int8 randomX = -25 + rand() % 50;
                    int8 randomY = -25 + rand() % 50;
                    Elemental[0] = me->SummonCreature(NPC_SNAPLASHER, me->GetPositionX() + randomX, me->GetPositionY() + randomY, me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
                    randomX = -25 + rand() % 50;
                    randomY = -25 + rand() % 50;
                    Elemental[1] = me->SummonCreature(NPC_ANCIENT_WATER_SPIRIT, me->GetPositionX() + randomX, me->GetPositionY() + randomY, me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
                    randomX = -25 + rand() % 50;
                    randomY = -25 + rand() % 50;
                    Elemental[2] = me->SummonCreature(NPC_STORM_LASHER, me->GetPositionX() + randomX, me->GetPositionY() + randomY, me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                }
                case 2:
                {
                    DoScriptText(SAY_SUMMON_CONSERVATOR, me);
                    int8 randomX = -25 + rand() % 50;
                    int8 randomY = -25 + rand() % 50;
                    me->SummonCreature(NPC_ANCIENT_CONSERVATOR, me->GetPositionX() + randomX, me->GetPositionY() + randomY, me->GetPositionZ()+1, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 7000);
                    break;
                }
            }
        }
        
        void DoAction(const int32 action)
        {
            switch (action)
            {
                case ACTION_LASHER:
                    for (uint32 i = 0; i < 2; ++i)
                        me->RemoveAuraFromStack(SPELL_ATTUNED_TO_NATURE, 0, AURA_REMOVE_BY_DEFAULT);
                    break;
                case ACTION_ELEMENTAL:
                    checkElementalAlive = true;
                    for (uint32 i = 0; i < 30; ++i)
                        me->RemoveAuraFromStack(SPELL_ATTUNED_TO_NATURE, 0, AURA_REMOVE_BY_DEFAULT);
                    break;
                case ACTION_ANCIENT:
                    for (uint32 i = 0; i < 25; ++i)
                        me->RemoveAuraFromStack(SPELL_ATTUNED_TO_NATURE, 0, AURA_REMOVE_BY_DEFAULT);
                    break;
                case ACTION_ELEMENTAL_DEAD:
                    checkElementalAlive = false;
                    break;
            }
        }
    };
};

class boss_elder_brightleaf : public CreatureScript
{
public:
    boss_elder_brightleaf() : CreatureScript("boss_elder_brightleaf") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_elder_brightleafAI(pCreature);
    }

    struct boss_elder_brightleafAI : public ScriptedAI
    {
        boss_elder_brightleafAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }
        
        InstanceScript* m_pInstance;
        int32 uiUnstableSunbeamTimer;
        int32 uiSolarFlareTimer;
        int32 uiUnstableEnergyTimer;
        int32 uiBrightleafFluxTimer;
        
        void EnterCombat(Unit* pWho)
        {
            DoScriptText(SAY_BRIGHTLEAF_AGGRO, me);
        }
        
        void KilledUnit(Unit *victim)
        {
            if (!(rand()%5))
                 DoScriptText(RAND(SAY_BRIGHTLEAF_SLAY_1,SAY_BRIGHTLEAF_SLAY_2), me);
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_BRIGHTLEAF_DEATH, me);
        }


        void Reset()
        {
            uiUnstableSunbeamTimer = 5000;
            uiSolarFlareTimer = 10000;
            uiUnstableEnergyTimer = 20000;
            uiBrightleafFluxTimer = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;
                
            if (GetClosestCreatureWithEntry(me, NPC_SUN_BEAM, 4.0f))
                DoCast(me, SPELL_PHOTOSYNTHESIS, true);

            if(uiUnstableSunbeamTimer <= 0)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    if (pTarget->isAlive())
                        me->SummonCreature(NPC_UNSTABLE_SUN_BEAM, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
                uiUnstableSunbeamTimer = 8000;
            }
            else uiUnstableSunbeamTimer -= diff;

            if(uiSolarFlareTimer <= 0)
            {
                DoCast(RAID_MODE(RAID_10_SPELL_SOLAR_FLARE, RAID_25_SPELL_SOLAR_FLARE));
                uiSolarFlareTimer = urand(10000, 15000);
            }
            else uiSolarFlareTimer -= diff;
                
            if(uiUnstableEnergyTimer <= 0)
            {
                DoCast(RAID_MODE(RAID_10_SPELL_UNSTABLE_ENERGY, RAID_25_SPELL_UNSTABLE_ENERGY));
                uiUnstableEnergyTimer = 15000;
            }
            else uiUnstableEnergyTimer -= diff;
                
            if(uiBrightleafFluxTimer <= 0)
            {
                me->RemoveAurasDueToSpell(SPELL_BRIGHTLEAF_FLUX);
                for (uint32 i = 0; i < urand(1,10); ++i)
                    DoCast(me, SPELL_BRIGHTLEAF_FLUX);
                
                uiBrightleafFluxTimer = 4000;
            }
            else uiBrightleafFluxTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_sun_beam : public CreatureScript
{
public:
    creature_sun_beam() : CreatureScript("creature_sun_beam") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_sun_beamAI(pCreature);
    }

    struct creature_sun_beamAI : public Scripted_NoMovementAI
    {
        creature_sun_beamAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            DoCast(RAID_MODE(RAID_10_SPELL_FREYA_UNSTABLE_ENERGY, RAID_25_SPELL_FREYA_UNSTABLE_ENERGY));
            DoCast(SPELL_UNSTABLE_SUN_BEAM_VISUAL);
        }

        InstanceScript* m_pInstance;
    };
};

class creature_unstable_sun_beam : public CreatureScript
{
public:
    creature_unstable_sun_beam() : CreatureScript("creature_unstable_sun_beam") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_unstable_sun_beamAI(pCreature);
    }

    struct creature_unstable_sun_beamAI : public Scripted_NoMovementAI
    {
        creature_unstable_sun_beamAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            DoCast(SPELL_UNSTABLE_SUN_BEAM);
        }

        InstanceScript* m_pInstance;
    };
};

class boss_elder_ironbranch : public CreatureScript
{
public:
    boss_elder_ironbranch() : CreatureScript("boss_elder_ironbranch") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_elder_ironbranchAI(pCreature);
    }

    struct boss_elder_ironbranchAI : public ScriptedAI
    {
        boss_elder_ironbranchAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            Reset();
        }

        InstanceScript* m_pInstance;
        int32 uiImpaleTimer;
        int32 uiThornSwarmTimer;
        int32 uiIronRootTimer;

        void Reset()
        {
            uiImpaleTimer = 15000;
            uiThornSwarmTimer = 20000;
            uiIronRootTimer = 8000;
        }

        void EnterCombat(Unit* pWho)
        {
            DoScriptText(SAY_IRONBRANCH_AGGRO, me);
        }
        
        void KilledUnit(Unit *victim)
        {
            if (!(rand()%5))
                 DoScriptText(RAND(SAY_IRONBRANCH_SLAY_1,SAY_IRONBRANCH_SLAY_2), me);
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_IRONBRANCH_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(uiImpaleTimer <= 0 && me->IsWithinMeleeRange(me->getVictim()))
            {
                DoCastVictim(RAID_MODE(RAID_10_SPELL_IMPALE, RAID_25_SPELL_IMPALE));
                uiImpaleTimer = urand(15000, 20000);
            }
            else uiImpaleTimer -= diff;

            if(uiThornSwarmTimer <= 0)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM))
                    DoCast(pTarget, RAID_MODE(RAID_10_SPELL_THORN_SWARM, RAID_25_SPELL_THORN_SWARM));
                uiThornSwarmTimer = urand(20000, 24000);
            }
            else uiThornSwarmTimer -= diff;

            if(uiIronRootTimer <= 0)
            {
                pRootTarget = SelectTarget(SELECT_TARGET_RANDOM);
                if(pRootTarget && !pRootTarget->HasAura(RAID_MODE(RAID_10_SPELL_IMPALE, RAID_25_SPELL_IMPALE)))
                    pRootTarget->CastSpell(me, RAID_MODE(RAID_10_SPELL_IRON_ROOTS, RAID_25_SPELL_IRON_ROOTS), false);
                uiIronRootTimer = urand(20000, 25000);
            }
            else uiIronRootTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};


class creature_iron_roots : public CreatureScript
{
public:
    creature_iron_roots() : CreatureScript("creature_iron_roots") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_iron_rootsAI(pCreature);
    }

    struct creature_iron_rootsAI : public Scripted_NoMovementAI
    {
        creature_iron_rootsAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            pPlayer = pRootTarget;
        }

        InstanceScript* m_pInstance;
        Unit* pPlayer;

        void JustDied(Unit* victim)
        {
            if (pPlayer)
                pPlayer->RemoveAurasDueToSpell(RAID_MODE(RAID_10_SPELL_IRON_ROOTS, RAID_25_SPELL_IRON_ROOTS));
        }
    };
};


class boss_elder_stonebark : public CreatureScript
{
public:
    boss_elder_stonebark() : CreatureScript("boss_elder_stonebark") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_elder_stonebarkAI(pCreature);
    }

    struct boss_elder_stonebarkAI : public ScriptedAI
    {
        boss_elder_stonebarkAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 uiGroundTremorTimer;
        int32 uiFistsOfStoneTimer;
        int32 uiPetrifiedBarkTimer;

        void Reset()
        {
            uiGroundTremorTimer = urand(5000, 10000);
            uiFistsOfStoneTimer = 25000;
            uiPetrifiedBarkTimer = 35000;
        }

        void EnterCombat(Unit* pWho)
        {
            DoScriptText(SAY_STONEBARK_AGGRO, me);
        }
        
        void KilledUnit(Unit *victim)
        {
            if (!(rand()%5))
                 DoScriptText(RAND(SAY_STONEBARK_SLAY_1,SAY_STONEBARK_SLAY_2), me);
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_STONEBARK_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim() || me->hasUnitState(UNIT_STAT_CASTING))
                return;

            if(uiGroundTremorTimer <= 0)
            {
                DoCastVictim(RAID_MODE(RAID_10_SPELL_GROUND_TREMOR, RAID_25_SPELL_GROUND_TREMOR));
                uiGroundTremorTimer = urand(20000, 25000);
            }
            else uiGroundTremorTimer -= diff;

            if(uiFistsOfStoneTimer <= 0)
            {
                DoCast(me, RAID_MODE(RAID_10_SPELL_PETRIFIED_BARK, RAID_25_SPELL_PETRIFIED_BARK));
                uiFistsOfStoneTimer = 50000;
            }
            else uiFistsOfStoneTimer -= diff;
            
            if(uiPetrifiedBarkTimer <= 0)
            {
                DoCast(me, SPELL_FISTS_OF_STONE);
                uiPetrifiedBarkTimer = 60000;
            }
            else uiPetrifiedBarkTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_eonars_gift : public CreatureScript
{
public:
    creature_eonars_gift() : CreatureScript("creature_eonars_gift") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_eonars_giftAI(pCreature);
    }

    struct creature_eonars_giftAI : public Scripted_NoMovementAI
    {
        creature_eonars_giftAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            uiLifebindersGiftTimer = 12000;
            fScale = 0.2f;
            me->SetFloatValue(OBJECT_FIELD_SCALE_X, fScale);
            uiScaleTimer = 200;
            DoCast(me, SPELL_PHEROMONES, true);
            DoCast(me, SPELL_EONAR_VISUAL, true);
        }

        InstanceScript* m_pInstance;
        int32 uiLifebindersGiftTimer;
        float fScale;
        int32 uiScaleTimer;

        void UpdateAI(const uint32 diff)
        {
            if(uiLifebindersGiftTimer <= 0)
            {
                DoCast(me, RAID_MODE(RAID_10_SPELL_LIFEBINDERS_GIFT, RAID_25_SPELL_LIFEBINDERS_GIFT), true);
                uiLifebindersGiftTimer = 12000;
                me->SetFloatValue(OBJECT_FIELD_SCALE_X, 0);
                me->ForcedDespawn(1000);
            }
            else uiLifebindersGiftTimer -= diff;

            if(uiScaleTimer <= 0)
            {
                fScale += 0.025f;
                me->SetFloatValue(OBJECT_FIELD_SCALE_X, fScale);
            }
            else uiScaleTimer -= diff;
        }
    };
};

class creature_nature_bomb : public CreatureScript
{
public:
    creature_nature_bomb() : CreatureScript("creature_nature_bomb") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_nature_bombAI(pCreature);
    }

    struct creature_nature_bombAI : public Scripted_NoMovementAI
    {
        creature_nature_bombAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            uiExplosionTimer = 10000;
            float x = me->GetPositionX();
            float y = me->GetPositionY();
            float z = me->GetPositionZ();
            pGo = me->SummonGameObject(OBJECT_NATURE_BOMB, x, y, z, 0, 0, 0, 0, 0, 0);
        }

        InstanceScript* m_pInstance;
        int32 uiExplosionTimer;
        GameObject* pGo;

        void UpdateAI(const uint32 diff)
        {
            if(uiExplosionTimer <= 0)
            {
                DoCast(me, RAID_MODE(RAID_10_SPELL_NATURE_BOMB, RAID_25_SPELL_NATURE_BOMB));
                uiExplosionTimer = 10000;
                me->ForcedDespawn(1000);
                pGo->Use(me);
            }
            else uiExplosionTimer -= diff;
        }
    };
};

class creature_detonating_lasher : public CreatureScript
{
public:
    creature_detonating_lasher() : CreatureScript("creature_detonating_lasher") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_detonating_lasherAI(pCreature);
    }

    struct creature_detonating_lasherAI : public ScriptedAI
    {
        creature_detonating_lasherAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 uiFlameLashTimer;
        int32 uiSwitchTargetTimer;

        void JustDied(Unit* victim)
        {
            DoCast(me, RAID_MODE(RAID_10_SPELL_DETONATE, RAID_25_SPELL_DETONATE));

            if(Creature* Freya = Unit::GetCreature(*me, m_pInstance ? m_pInstance->GetData64(DATA_FREYA) : 0))
                Freya->AI()->DoAction(ACTION_LASHER);
        }

        void Reset()
        {
            uiFlameLashTimer = urand(5000, 10000);
            uiSwitchTargetTimer = urand(2000, 4000);
        }

        void updateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(uiFlameLashTimer <= 0)
            {
                DoCastVictim(SPELL_FLAME_LASH);
                uiFlameLashTimer = urand(5000, 10000);
            }
            else uiFlameLashTimer -= diff;

            if(uiSwitchTargetTimer <= 0)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    if (pTarget->isAlive())
                        me->Attack(pTarget, true);
                uiSwitchTargetTimer = urand(2000, 4000);
            }
            else uiSwitchTargetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_ancient_conservator : public CreatureScript
{
public:
    creature_ancient_conservator() : CreatureScript("creature_ancient_conservator") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_ancient_conservatorAI(pCreature);
    }

    struct creature_ancient_conservatorAI : public ScriptedAI
    {
        creature_ancient_conservatorAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 uiNaturesFuryTimer;
        int32 uiSpawnHealthySporeTimer;
        uint8 healthySporesSpawned;
        int32 uiSpawnPauseTimer;
        
        void EnterCombat(Unit* pWho)
        {
            DoCast(me, SPELL_CONSERVATORS_GRIP);
        }

        void Reset()
        {
            uiNaturesFuryTimer = 5000;
            uiSpawnHealthySporeTimer = 0;
            healthySporesSpawned = 0;
            uiSpawnPauseTimer = 20000;
        }

        void JustDied(Unit* victim)
        {
            if(Creature* Freya = Unit::GetCreature(*me, m_pInstance ? m_pInstance->GetData64(DATA_FREYA) : 0))
                Freya->AI()->DoAction(ACTION_ANCIENT);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim() || (me->hasUnitState(UNIT_STAT_CASTING)))
                return;

            if(uiNaturesFuryTimer <= 0)
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true);
                //Prevent casting natures fury on a target that is already affected
                if(pTarget && !pTarget->HasAura(RAID_MODE(RAID_10_SPELL_NATURES_FURY, RAID_25_SPELL_NATURES_FURY)))
                    DoCast(pTarget, RAID_MODE(RAID_10_SPELL_NATURES_FURY, RAID_25_SPELL_NATURES_FURY));
                me->AddAura(SPELL_CONSERVATORS_GRIP, me);
                uiNaturesFuryTimer = 5000;
            }
            else uiNaturesFuryTimer -= diff;

            if(uiSpawnHealthySporeTimer <= 0 && healthySporesSpawned < 10)
            {
                for (uint32 i = 0; i < 2; ++i)
                {
                    Position pos;
                    me->GetRandomNearPosition(pos, 25);
                    me->SummonCreature(NPC_HEALTHY_SPORE, pos, TEMPSUMMON_TIMED_DESPAWN, 20000);
                }
                healthySporesSpawned += 2;
                uiSpawnHealthySporeTimer = 2000;
            }
            else uiSpawnHealthySporeTimer -= diff;

            if(uiSpawnPauseTimer <= 0)
            {
                healthySporesSpawned = 0;
                uiSpawnPauseTimer = 20000;
                uiSpawnHealthySporeTimer = 0;
            }
            else uiSpawnPauseTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_healthy_spore : public CreatureScript
{
public:
    creature_healthy_spore() : CreatureScript("creature_healthy_spore") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_healthy_sporeAI(pCreature);
    }

    struct creature_healthy_sporeAI : public Scripted_NoMovementAI
    {
        creature_healthy_sporeAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            DoCast(me, SPELL_HEALTHY_SPORE_VISUAL);
            DoCast(me, SPELL_POTENT_PHEROMONES);
            DoCast(me, SPELL_GROW);
        }

        InstanceScript* m_pInstance;
    };
};

class creature_storm_lasher : public CreatureScript
{
public:
    creature_storm_lasher() : CreatureScript("creature_storm_lasher") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_storm_lasherAI(pCreature);
    }

    struct creature_storm_lasherAI : public ScriptedAI
    {
        creature_storm_lasherAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 uiLightningLashTimer;
        int32 uiStormboltTimer;

        void Reset()
        {
            uiLightningLashTimer = 4000;
            uiStormboltTimer = 15000;
        }

        void JustDied(Unit* victim)
        {
            if(Creature* Freya = Unit::GetCreature(*me, m_pInstance ? m_pInstance->GetData64(DATA_FREYA) : 0))
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim() || (me->hasUnitState(UNIT_STAT_CASTING)))
                return;
                
            if(uiLightningLashTimer <= 0)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM))
                    DoCast(pTarget, RAID_MODE(RAID_10_SPELL_LIGHTNING_LASH, RAID_25_SPELL_LIGHTNING_LASH));
                uiLightningLashTimer = urand(3000, 6000);
            }
            else uiLightningLashTimer -= diff;

            if(uiStormboltTimer <= 0)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM))
                    DoCast(pTarget, RAID_MODE(RAID_10_SPELL_STORMBOLT, RAID_25_SPELL_STORMBOLT));
                uiStormboltTimer = 15000;
            }
            else uiStormboltTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_snaplasher : public CreatureScript
{
public:
    creature_snaplasher() : CreatureScript("creature_snaplasher") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_snaplasherAI(pCreature);
    }

    struct creature_snaplasherAI : public ScriptedAI
    {
        creature_snaplasherAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            //DoCast(me, 62664);
        }

        InstanceScript* m_pInstance;
        uint32 health;

        void JustDied(Unit* victim)
        {
            if(Creature* Freya = Unit::GetCreature(*me, m_pInstance ? m_pInstance->GetData64(DATA_FREYA) : 0))
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

class creature_ancient_water_spirit : public CreatureScript
{
public:
    creature_ancient_water_spirit() : CreatureScript("creature_ancient_water_spirit") {}


    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new creature_ancient_water_spiritAI(pCreature);
    }

    struct creature_ancient_water_spiritAI : public ScriptedAI
    {
        creature_ancient_water_spiritAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        int32 uiTidalWaveTimer;

        void Reset()
        {
            uiTidalWaveTimer = 10000;
        }

        void JustDied(Unit* victim)
        {
            if(Creature* Freya = Unit::GetCreature(*me, m_pInstance ? m_pInstance->GetData64(DATA_FREYA) : 0))
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(uiTidalWaveTimer <= 0)
            {
                DoCastVictim(SPELL_TIDAL_WAVE);
                uiTidalWaveTimer = 15000;
            }
            else uiTidalWaveTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_freya()
{
    new boss_freya();
    new boss_elder_brightleaf();
    new creature_sun_beam();
    new creature_unstable_sun_beam();
    new creature_iron_roots();
    new boss_elder_ironbranch();
    new creature_eonars_gift();
    new boss_elder_stonebark();
    new creature_nature_bomb();
    new creature_detonating_lasher();
    new creature_ancient_conservator();
    new creature_healthy_spore();
    new creature_storm_lasher();
    new creature_snaplasher();
    new creature_ancient_water_spirit();
};