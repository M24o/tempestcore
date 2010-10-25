/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptPCH.h"

enum Spells
{
    SPELL_CRUSHING_LEAP                           = 68506,
    SPELL_DAGGER_THROW_1                          = 67280,
    SPELL_DAGGER_THROW_2                          = 67881,
    SPELL_MORTAL_STRIKE                           = 39171
};

enum Yells
{
    YELL_AGGRO                                    = -2100019,
    YELL_EVADE                                    = -2100020
};

class boss_isle_of_conquest : public CreatureScript
{
public:
	boss_isle_of_conquest() : CreatureScript("boss_isle_of_conquest") { }


	struct boss_isle_of_conquestAI : public ScriptedAI
	{
		boss_isle_of_conquestAI(Creature *c) : ScriptedAI(c) {}

		uint32 uiMortalStrikeTimer;
		uint32 uiDaggerThrowTimer;
		uint32 uiCrushingLeapTimer;
		uint32 uiResetTimer;

		void Reset()
		{
			uiMortalStrikeTimer         = 8*IN_MILLISECONDS;
			uiDaggerThrowTimer          = 2*IN_MILLISECONDS;
			uiCrushingLeapTimer         = 6*IN_MILLISECONDS;
			uiResetTimer                = 5*IN_MILLISECONDS;
		}

		void EnterCombat(Unit * who)
		{
			if(!me->IsWithinLOSInMap(who))
			{
				EnterEvadeMode();
			}
			DoScriptText(YELL_AGGRO, me);
		}

		void JustRespawned()
		{
			Reset();
		}

		void UpdateAI(const uint32 diff)
		{
			if (!UpdateVictim())
				return;

			if (uiMortalStrikeTimer < diff)
			{
				DoCast(me->getVictim(), SPELL_MORTAL_STRIKE);
				uiMortalStrikeTimer = urand(10*IN_MILLISECONDS,20*IN_MILLISECONDS);
			} else uiMortalStrikeTimer -= diff;

			if (uiDaggerThrowTimer < diff)
			{
				if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM))
					DoCast(pTarget, RAID_MODE(SPELL_DAGGER_THROW_1, SPELL_DAGGER_THROW_2));
				uiDaggerThrowTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
			} else uiDaggerThrowTimer -= diff;

			if (uiCrushingLeapTimer < diff)
			{
				if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM))
					DoCast(pTarget, SPELL_CRUSHING_LEAP);
				uiCrushingLeapTimer = urand(12*IN_MILLISECONDS,16*IN_MILLISECONDS);
			} else uiCrushingLeapTimer -= diff;

			// check if creature is not outside of building
			if (uiResetTimer < diff)
			{
				float x,y;
				me->GetPosition(x,y);
                if (me->GetEntry()==34922 && (x>1348 || x<1283 || y<-800 || y>-730))
                    EnterEvadeMode();

                if (me->GetEntry()==34924 && (x>288 || x<216 || y<-863 || y>-800))
                    EnterEvadeMode();

				uiResetTimer = 200;
            }
            else uiResetTimer -= diff;

			DoMeleeAttackIfReady();
		}
	};
    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_isle_of_conquestAI(creature);
    }
};

void AddSC_isle_of_conquest()
{
    new boss_isle_of_conquest;
}
