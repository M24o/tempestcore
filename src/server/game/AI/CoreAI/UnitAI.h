/*
 * Copyright (C) 2005 - 2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
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

#ifndef TRINITY_UNITAI_H
#define TRINITY_UNITAI_H

#include "Define.h"
#include <list>
#include "Unit.h"

class Unit;
class Player;
struct AISpellInfoType;

//Selection method used by SelectTarget
enum SelectAggroTarget
{
    SELECT_TARGET_RANDOM = 0,                               //Just selects a random target
    SELECT_TARGET_TOPAGGRO,                                 //Selects targes from top aggro to bottom
    SELECT_TARGET_BOTTOMAGGRO,                              //Selects targets from bottom aggro to top
    SELECT_TARGET_NEAREST,
    SELECT_TARGET_FARTHEST,
};

class UnitAI
{
    protected:
        Unit * const me;
    public:
        explicit UnitAI(Unit *u) : me(u) {}
        virtual ~UnitAI() {}

        virtual bool CanAIAttack(const Unit * /*who*/) const { return true; }
        virtual void AttackStart(Unit *);
        virtual void UpdateAI(const uint32 diff) = 0;

        virtual void InitializeAI() { if (!me->isDead()) Reset(); }

        virtual void Reset() {};

        // Called when unit is charmed
        virtual void OnCharmed(bool apply) = 0;

        // Pass parameters between AI
        virtual void DoAction(const int32 /*param*/ = 0) {}
        virtual uint32 GetData(uint32 /*id = 0*/) { return 0; }
        virtual void SetData(uint32 /*id*/, uint32 /*value*/) {}
        virtual void SetGUID(const uint64 &/*guid*/, int32 /*id*/ = 0) {}
        virtual uint64 GetGUID(int32 /*id*/ = 0) { return 0; }

        Unit* SelectTarget(SelectAggroTarget targetType, uint32 position = 0, float dist = 0.0f, bool playerOnly = false, int32 aura = 0);
        void SelectTargetList(std::list<Unit*> &targetList, uint32 num, SelectAggroTarget targetType, float dist = 0.0f, bool playerOnly = false, int32 aura = 0);

        // Select the targets satifying the predicate.
        // predicate shall extend std::unary_function<Unit *, bool>
        template<class PREDICATE> Unit* SelectTarget(SelectAggroTarget targetType, uint32 position, PREDICATE predicate)
        {
            const std::list<HostileReference *> &threatlist = me->getThreatManager().getThreatList();
            std::list<Unit*> targetList;

            if (position >= threatlist.size())
                return NULL;

            for (std::list<HostileReference*>::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
            {
                HostileReference* ref = (*itr);
                if (predicate(ref->getTarget()))
                    targetList.push_back(ref->getTarget());
            }

            if (position >= targetList.size())
                return NULL;

            if (targetType == SELECT_TARGET_NEAREST || targetType == SELECT_TARGET_FARTHEST)
                targetList.sort(Trinity::ObjectDistanceOrderPred(me));

            switch(targetType)
            {
                case SELECT_TARGET_NEAREST:
                case SELECT_TARGET_TOPAGGRO:
                    {
                        std::list<Unit*>::iterator itr = targetList.begin();
                        advance(itr, position);
                        return *itr;
                    }
                    break;

                case SELECT_TARGET_FARTHEST:
                case SELECT_TARGET_BOTTOMAGGRO:
                    {
                        std::list<Unit*>::reverse_iterator ritr = targetList.rbegin();
                        advance(ritr, position);
                        return *ritr;
                    }
                    break;

                case SELECT_TARGET_RANDOM:
                    {
                        std::list<Unit*>::iterator itr = targetList.begin();
                        advance(itr, urand(position, targetList.size()-1));
                        return *itr;
                    }
                    break;
            }

            return NULL;
        }

        void AttackStartCaster(Unit *victim, float dist);

        void DoAddAuraToAllHostilePlayers(uint32 spellid);
        void DoCast(uint32 spellId);
        void DoCast(Unit* victim, uint32 spellId, bool triggered = false);
        void DoCastToAllHostilePlayers(uint32 spellid, bool triggered = false);
        void DoCastVictim(uint32 spellId, bool triggered = false);
        void DoCastAOE(uint32 spellId, bool triggered = false);

        float DoGetSpellMaxRange(uint32 spellId, bool positive = false);

        void DoMeleeAttackIfReady();
        bool DoSpellAttackIfReady(uint32 spell);

        static AISpellInfoType *AISpellInfo;
        static void FillAISpellInfo();
};

class PlayerAI : public UnitAI
{
    protected:
        Player* const me;
    public:
        explicit PlayerAI(Player *p) : UnitAI((Unit*)p), me(p) {}

        void OnCharmed(bool apply);
};

class SimpleCharmedAI : public PlayerAI
{
    public:
        void UpdateAI(const uint32 diff);
        SimpleCharmedAI(Player *p): PlayerAI(p) {}
};

#endif
