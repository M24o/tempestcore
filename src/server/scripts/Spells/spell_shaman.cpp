/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 Myth Project <http://mythproject.org/>
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
 * Scripts for spells with SPELLFAMILY_SHAMAN and SPELLFAMILY_GENERIC spells used by shaman players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_sha_".
 */

#include "ScriptPCH.h"
#include "SpellAuraEffects.h"

enum ShamanSpells
{
    SHAMAN_SPELL_GLYPH_OF_MANA_TIDE     = 55441,
    SHAMAN_SPELL_MANA_TIDE_TOTEM        = 39609,
    SHAMAN_SPELL_FIRE_NOVA_R1           = 1535,
    SHAMAN_SPELL_FIRE_NOVA_TRIGGERED_R1 = 8349
};

// 1535 Fire Nova
class spell_sha_fire_nova : public SpellScriptLoader
{
public:
    spell_sha_fire_nova() : SpellScriptLoader("spell_sha_fire_nova") { }

    class spell_sha_fire_nova_SpellScript : public SpellScript
    {
        bool Validate(SpellEntry const * spellEntry)
        {
            if (!sSpellStore.LookupEntry(SHAMAN_SPELL_FIRE_NOVA_R1))
                return false;
            if (sSpellMgr.GetFirstSpellInChain(SHAMAN_SPELL_FIRE_NOVA_R1) != sSpellMgr.GetFirstSpellInChain(spellEntry->Id))
                return false;

            uint8 rank = sSpellMgr.GetSpellRank(spellEntry->Id);
            if (!sSpellMgr.GetSpellWithRank(SHAMAN_SPELL_FIRE_NOVA_TRIGGERED_R1, rank, true))
                return false;
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* caster = GetCaster())
            {
                uint8 rank = sSpellMgr.GetSpellRank(GetSpellInfo()->Id);
                uint32 spellId = sSpellMgr.GetSpellWithRank(SHAMAN_SPELL_FIRE_NOVA_TRIGGERED_R1, rank);
                // fire slot
                if (spellId && caster->m_SummonSlot[1])
                {
                    Creature* totem = caster->GetMap()->GetCreature(caster->m_SummonSlot[1]);
                    if (totem && totem->isTotem())
                        totem->CastSpell(totem, spellId, true);
                }
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_sha_fire_nova_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_sha_fire_nova_SpellScript();
    }
};

// 39610 Mana Tide Totem
class spell_sha_mana_tide_totem : public SpellScriptLoader
{
public:
    spell_sha_mana_tide_totem() : SpellScriptLoader("spell_sha_mana_tide_totem") { }

    class spell_sha_mana_tide_totem_SpellScript : public SpellScript
    {
        bool Validate(SpellEntry const * /*spellEntry*/)
        {
            if (!sSpellStore.LookupEntry(SHAMAN_SPELL_GLYPH_OF_MANA_TIDE))
                return false;
            if (!sSpellStore.LookupEntry(SHAMAN_SPELL_MANA_TIDE_TOTEM))
                return false;
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (Unit* unitTarget = GetHitUnit())
            {
                if (unitTarget->getPowerType() == POWER_MANA)
                {
                    int32 effValue = GetEffectValue();
                    // Glyph of Mana Tide
                    if (Unit *owner = caster->GetOwner())
                        if (AuraEffect *dummy = owner->GetAuraEffect(SHAMAN_SPELL_GLYPH_OF_MANA_TIDE, 0))
                            effValue += dummy->GetAmount();
                    // Regenerate 6% of Total Mana Every 3 secs
                    int32 effBasePoints0 = unitTarget->GetMaxPower(POWER_MANA) * effValue / 100;
                    caster->CastCustomSpell(unitTarget, SHAMAN_SPELL_MANA_TIDE_TOTEM, &effBasePoints0, NULL, NULL, true, NULL, NULL, GetOriginalCaster()->GetGUID());
                }
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_sha_mana_tide_totem_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_sha_mana_tide_totem_SpellScript();
    }
};

void AddSC_shaman_spell_scripts()
{
    new spell_sha_fire_nova();
    new spell_sha_mana_tide_totem();
}
