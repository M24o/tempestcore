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
 * Scripts for spells with SPELLFAMILY_PALADIN and SPELLFAMILY_GENERIC spells used by paladin players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_pal_".
 */

#include "ScriptPCH.h"
#include "SpellAuraEffects.h"

enum PaladinSpells
{
    PALADIN_SPELL_DIVINE_PLEA                    = 54428,
    PALADIN_SPELL_BLESSING_OF_SANCTUARY_BUFF     = 67480,

    PALADIN_SPELL_HOLY_SHOCK_R1                  = 20473,
    PALADIN_SPELL_HOLY_SHOCK_R1_DAMAGE           = 25912,
    PALADIN_SPELL_HOLY_SHOCK_R1_HEALING          = 25914,

    SPELL_BLESSING_OF_LOWER_CITY_DRUID           = 37878,
    SPELL_BLESSING_OF_LOWER_CITY_PALADIN         = 37879,
    SPELL_BLESSING_OF_LOWER_CITY_PRIEST          = 37880,
    SPELL_BLESSING_OF_LOWER_CITY_SHAMAN          = 37881,
};

class spell_pal_blessing_of_faith : public SpellScriptLoader
{
public:
    spell_pal_blessing_of_faith() : SpellScriptLoader("spell_pal_blessing_of_faith") { }

    class spell_pal_blessing_of_faith_SpellScript : public SpellScript
    {
        bool Validate(SpellEntry const * /*spellEntry*/)
        {
            if (!sSpellStore.LookupEntry(SPELL_BLESSING_OF_LOWER_CITY_DRUID))
                return false;
            if (!sSpellStore.LookupEntry(SPELL_BLESSING_OF_LOWER_CITY_PALADIN))
                return false;
            if (!sSpellStore.LookupEntry(SPELL_BLESSING_OF_LOWER_CITY_PRIEST))
                return false;
            if (!sSpellStore.LookupEntry(SPELL_BLESSING_OF_LOWER_CITY_SHAMAN))
                return false;
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit *unitTarget = GetHitUnit())
            {
                uint32 spell_id = 0;
                switch(unitTarget->getClass())
                {
                    case CLASS_DRUID:   spell_id = SPELL_BLESSING_OF_LOWER_CITY_DRUID; break;
                    case CLASS_PALADIN: spell_id = SPELL_BLESSING_OF_LOWER_CITY_PALADIN; break;
                    case CLASS_PRIEST:  spell_id = SPELL_BLESSING_OF_LOWER_CITY_PRIEST; break;
                    case CLASS_SHAMAN:  spell_id = SPELL_BLESSING_OF_LOWER_CITY_SHAMAN; break;
                    default: return;                    // ignore for non-healing classes
                }

                GetCaster()->CastSpell(GetCaster(), spell_id, true);
            }
        }

        void Register()
        {
            // add dummy effect spell handler to Blessing of Faith
            OnEffect += SpellEffectFn(spell_pal_blessing_of_faith_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript *GetSpellScript() const
    {
        return new spell_pal_blessing_of_faith_SpellScript();
    }
};

// 20911 Blessing of Sanctuary
// 25899 Greater Blessing of Sanctuary
class spell_pal_blessing_of_sanctuary : public SpellScriptLoader
{
public:
    spell_pal_blessing_of_sanctuary() : SpellScriptLoader("spell_pal_blessing_of_sanctuary") { }

    class spell_pal_blessing_of_sanctuary_AuraScript : public AuraScript
    {
        bool Validate(SpellEntry const* /*entry*/)
        {
            if (!sSpellStore.LookupEntry(PALADIN_SPELL_BLESSING_OF_SANCTUARY_BUFF))
                return false;
            return true;
        }

        void HandleEffectApply(AuraEffect const * /*aurEff*/, AuraApplication const * aurApp, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pCaster = GetCaster())
                if (Unit* pTarget = aurApp->GetTarget())
                    pCaster->CastSpell(pTarget, PALADIN_SPELL_BLESSING_OF_SANCTUARY_BUFF, true);
        }

        void HandleEffectRemove(AuraEffect const * /*aurEff*/, AuraApplication const * aurApp, AuraEffectHandleModes /*mode*/)
        {
            if (GetCaster())
                if (Unit* pTarget = aurApp->GetTarget())
                    pTarget->RemoveAura(PALADIN_SPELL_BLESSING_OF_SANCTUARY_BUFF, GetCasterGUID());
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_pal_blessing_of_sanctuary_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_pal_blessing_of_sanctuary_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_pal_blessing_of_sanctuary_AuraScript();
    }
};

// 63521 Guarded by The Light
class spell_pal_guarded_by_the_light : public SpellScriptLoader
{
public:
    spell_pal_guarded_by_the_light() : SpellScriptLoader("spell_pal_guarded_by_the_light") { }

    class spell_pal_guarded_by_the_light_SpellScript : public SpellScript
    {
        bool Validate(SpellEntry const * /*spellEntry*/)
        {
            if (!sSpellStore.LookupEntry(PALADIN_SPELL_DIVINE_PLEA))
                return false;
            return true;
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            // Divine Plea
            if (Aura* aura = GetCaster()->GetAura(PALADIN_SPELL_DIVINE_PLEA))
                aura->RefreshDuration();
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_pal_guarded_by_the_light_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_pal_guarded_by_the_light_SpellScript();
    }
};

class spell_pal_holy_shock : public SpellScriptLoader
{
public:
    spell_pal_holy_shock() : SpellScriptLoader("spell_pal_holy_shock") { }

    class spell_pal_holy_shock_SpellScript : public SpellScript
    {
        bool Validate(SpellEntry const *spellEntry)
        {
            if (!sSpellStore.LookupEntry(PALADIN_SPELL_HOLY_SHOCK_R1))
                return false;

            // can't use other spell than holy shock due to spell_ranks dependency
            if (sSpellMgr.GetFirstSpellInChain(PALADIN_SPELL_HOLY_SHOCK_R1) != sSpellMgr.GetFirstSpellInChain(spellEntry->Id))
                return false;

            uint8 rank = sSpellMgr.GetSpellRank(spellEntry->Id);
            if (!sSpellMgr.GetSpellWithRank(PALADIN_SPELL_HOLY_SHOCK_R1_DAMAGE, rank, true))
                return false;
            if (!sSpellMgr.GetSpellWithRank(PALADIN_SPELL_HOLY_SHOCK_R1_HEALING, rank, true))
                return false;

            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit *unitTarget = GetHitUnit())
            {
                Unit *caster = GetCaster();

                uint8 rank = sSpellMgr.GetSpellRank(GetSpellInfo()->Id);

                if (caster->IsFriendlyTo(unitTarget))
                    caster->CastSpell(unitTarget, sSpellMgr.GetSpellWithRank(PALADIN_SPELL_HOLY_SHOCK_R1_HEALING, rank), true, 0);
                else
                    caster->CastSpell(unitTarget, sSpellMgr.GetSpellWithRank(PALADIN_SPELL_HOLY_SHOCK_R1_DAMAGE, rank), true, 0);
            }
        }

        void Register()
        {
            // add dummy effect spell handler to Holy Shock
            OnEffect += SpellEffectFn(spell_pal_holy_shock_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript *GetSpellScript() const
    {
        return new spell_pal_holy_shock_SpellScript();
    }
};

class spell_pal_judgement_of_command : public SpellScriptLoader
{
public:
    spell_pal_judgement_of_command() : SpellScriptLoader("spell_pal_judgement_of_command") { }

    class spell_pal_judgement_of_command_SpellScript : public SpellScript
    {
        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit *unitTarget = GetHitUnit())
                if (SpellEntry const* spell_proto = sSpellStore.LookupEntry(GetEffectValue()))
                    GetCaster()->CastSpell(unitTarget, spell_proto, true, NULL);
        }

        void Register()
        {
            // add dummy effect spell handler to Judgement of Command
            OnEffect += SpellEffectFn(spell_pal_judgement_of_command_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript *GetSpellScript() const
    {
        return new spell_pal_judgement_of_command_SpellScript();
    }
};

void AddSC_paladin_spell_scripts()
{
    new spell_pal_blessing_of_faith();
    new spell_pal_blessing_of_sanctuary();
    new spell_pal_guarded_by_the_light();
    new spell_pal_holy_shock();
    new spell_pal_judgement_of_command();
}
