/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
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

#include <string>
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"

bool _SpellScript::_Validate(SpellEntry const * entry, const char * scriptname)
{
    if (!Validate(entry))
    {
        sLog.outError("TSCR: Spell `%u` did not pass Validate() function of script `%s` - script will be not added to the spell", entry->Id, scriptname);
        return false;
    }
    return true;
}

_SpellScript::EffectHook::EffectHook(uint8 _effIndex)
{
    // effect index must be in range <0;2>, allow use of special effindexes
    ASSERT(_effIndex == EFFECT_ALL || _effIndex == EFFECT_FIRST_FOUND || _effIndex < MAX_SPELL_EFFECTS);
    effIndex = _effIndex;
}

uint8 _SpellScript::EffectHook::GetAffectedEffectsMask(SpellEntry const * spellEntry)
{
    uint8 mask = 0;
    if ((effIndex == EFFECT_ALL) || (effIndex == EFFECT_FIRST_FOUND))
    {
        for(uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if ((effIndex == EFFECT_FIRST_FOUND) && mask)
                return mask;
            if (CheckEffect(spellEntry, i))
                mask |= (uint8)1<<i;
        }
    }
    else
    {
        if (CheckEffect(spellEntry, effIndex))
            mask |= (uint8)1<<effIndex;
    }
    return mask;
}

bool _SpellScript::EffectHook::IsEffectAffected(SpellEntry const * spellEntry, uint8 effIndex)
{
    return GetAffectedEffectsMask(spellEntry) & 1<<effIndex;
}

std::string _SpellScript::EffectHook::EffIndexToString()
{
    switch(effIndex)
    {
        case EFFECT_ALL:
            return "EFFECT_ALL";
        case EFFECT_FIRST_FOUND:
            return "EFFECT_FIRST_FOUND";
        case EFFECT_0:
            return "EFFECT_0";
        case EFFECT_1:
            return "EFFECT_1";
        case EFFECT_2:
            return "EFFECT_2";
    }
    return "Invalid Value";
}

bool _SpellScript::EffectNameCheck::Check(SpellEntry const * spellEntry, uint8 effIndex)
{
    if (!spellEntry->Effect[effIndex] && !effName)
        return true;
    if (!spellEntry->Effect[effIndex])
        return false;
    return (effName == SPELL_EFFECT_ANY) || (spellEntry->Effect[effIndex] == effName);
}

std::string _SpellScript::EffectNameCheck::ToString()
{
    switch(effName)
    {
        case SPELL_EFFECT_ANY:
            return "SPELL_EFFECT_ANY";
        default:
            char num[10];
            sprintf (num,"%u",effName);
            return num;
    }
}

bool _SpellScript::EffectAuraNameCheck::Check(SpellEntry const * spellEntry, uint8 effIndex)
{
    if (!spellEntry->EffectApplyAuraName[effIndex] && !effAurName)
        return true;
    if (!spellEntry->EffectApplyAuraName[effIndex])
        return false;
    return (effAurName == SPELL_EFFECT_ANY) || (spellEntry->EffectApplyAuraName[effIndex] == effAurName);
}

std::string _SpellScript::EffectAuraNameCheck::ToString()
{
    switch(effAurName)
    {
        case SPELL_AURA_ANY:
            return "SPELL_AURA_ANY";
        default:
            char num[10];
            sprintf (num,"%u",effAurName);
            return num;
    }
}

SpellScript::EffectHandler::EffectHandler(SpellEffectFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : _SpellScript::EffectNameCheck(_effName), _SpellScript::EffectHook(_effIndex)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

std::string SpellScript::EffectHandler::ToString()
{
    return "Index: " + EffIndexToString() + " Name: " +_SpellScript::EffectNameCheck::ToString();
}

bool SpellScript::EffectHandler::CheckEffect(SpellEntry const * spellEntry, uint8 effIndex)
{
    return _SpellScript::EffectNameCheck::Check(spellEntry, effIndex);
}

void SpellScript::EffectHandler::Call(SpellScript * spellScript, SpellEffIndex effIndex)
{
    (spellScript->*pEffectHandlerScript)(effIndex);
}

bool SpellScript::_Validate(SpellEntry const * entry, const char * scriptname)
{
    for (std::list<EffectHandler>::iterator itr = OnEffect.begin(); itr != OnEffect.end();  ++itr)
    {
        if (!(*itr).GetAffectedEffectsMask(entry))
        {
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);
        }
    }
    return _SpellScript::_Validate(entry, scriptname);
}

bool SpellScript::_Load(Spell * spell)
{
    m_spell = spell;
    return Load();
}

void SpellScript::_InitHit()
{
    m_hitPreventEffectMask = 0;
    m_hitPreventDefaultEffectMask = 0;
}

Unit * SpellScript::GetCaster()
{
     return m_spell->GetCaster();
}

Unit * SpellScript::GetOriginalCaster()
{
     return m_spell->GetOriginalCaster();
}

SpellEntry const * SpellScript::GetSpellInfo()
{
    return m_spell->GetSpellInfo();
}

WorldLocation * SpellScript::GetDest()
{
    if (m_spell->m_targets.HasDst())
        return &m_spell->m_targets.m_dstPos;
    return NULL;
}

Unit * SpellScript::GetHitUnit()
{
    return m_spell->unitTarget;
}

Creature * SpellScript::GetHitCreature()
{
    if (m_spell->unitTarget)
        return m_spell->unitTarget->ToCreature();
    else
        return NULL;
}

Player * SpellScript::GetHitPlayer()
{
    if (m_spell->unitTarget)
        return m_spell->unitTarget->ToPlayer();
    else
        return NULL;
}

Item * SpellScript::GetHitItem()
{
    return m_spell->itemTarget;
}

GameObject * SpellScript::GetHitGObj()
{
    return m_spell->gameObjTarget;
}

int32 SpellScript::GetHitDamage()
{
    return m_spell->m_damage;
}

void SpellScript::SetHitDamage(int32 damage)
{
    m_spell->m_damage = damage;
}

int32 SpellScript::GetHitHeal()
{
    return m_spell->m_healing;
}

void SpellScript::SetHitHeal(int32 heal)
{
    m_spell->m_healing = heal;
}

Aura* SpellScript::GetHitAura()
{
    if (!m_spell->m_spellAura)
        return NULL;
    if (m_spell->m_spellAura->IsRemoved())
        return NULL;
    return m_spell->m_spellAura;
}

void SpellScript::PreventHitAura()
{
    if (m_spell->m_spellAura)
        m_spell->m_spellAura->Remove();
}

void SpellScript::PreventHitEffect(SpellEffIndex effIndex)
{
    m_hitPreventEffectMask |= 1 << effIndex;
    PreventHitDefaultEffect(effIndex);
}

void SpellScript::PreventHitDefaultEffect(SpellEffIndex effIndex)
{
    m_hitPreventDefaultEffectMask |= 1 << effIndex;
}

int32 SpellScript::GetEffectValue()
{
    return m_spell->damage;
}

Item * SpellScript::GetCastItem()
{
    return m_spell->m_CastItem;
}

void SpellScript::CreateItem(uint32 effIndex, uint32 itemId)
{
    m_spell->DoCreateItem(effIndex, itemId);
}

bool AuraScript::_Validate(SpellEntry const * entry, const char * scriptname)
{
    for (std::list<EffectApplyHandler>::iterator itr = OnEffectApply.begin(); itr != OnEffectApply.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectApplyHandler>::iterator itr = OnEffectRemove.begin(); itr != OnEffectRemove.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectPeriodicHandler>::iterator itr = OnEffectPeriodic.begin(); itr != OnEffectPeriodic.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectUpdatePeriodicHandler>::iterator itr = OnEffectUpdatePeriodic.begin(); itr != OnEffectUpdatePeriodic.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectCalcAmountHandler>::iterator itr = OnEffectCalcAmount.begin(); itr != OnEffectCalcAmount.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectCalcPeriodicHandler>::iterator itr = OnEffectCalcPeriodic.begin(); itr != OnEffectCalcPeriodic.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    for (std::list<EffectCalcSpellModHandler>::iterator itr = OnEffectCalcSpellMod.begin(); itr != OnEffectCalcSpellMod.end();  ++itr)
        if (!(*itr).GetAffectedEffectsMask(entry))
            sLog.outError("TSCR: Spell `%u` Effect `%s` of script`%s` did not match dbc effect data - bound handler won't be executed", entry->Id, (*itr).ToString().c_str(), scriptname);

    return _SpellScript::_Validate(entry, scriptname);
}

AuraScript::EffectBase::EffectBase(uint8 _effIndex, uint16 _effName)
    : _SpellScript::EffectAuraNameCheck(_effName), _SpellScript::EffectHook(_effIndex)
{
}

bool AuraScript::EffectBase::CheckEffect(SpellEntry const * spellEntry, uint8 effIndex)
{
    return _SpellScript::EffectAuraNameCheck::Check(spellEntry, effIndex);
}

std::string AuraScript::EffectBase::ToString()
{
    return "Index: " + EffIndexToString() + " AuraName: " +_SpellScript::EffectAuraNameCheck::ToString();
}

AuraScript::EffectPeriodicHandler::EffectPeriodicHandler(AuraEffectPeriodicFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

void AuraScript::EffectPeriodicHandler::Call(AuraScript * auraScript, AuraEffect const * _aurEff, AuraApplication const * _aurApp)
{
    (auraScript->*pEffectHandlerScript)(_aurEff, _aurApp);
}

AuraScript::EffectUpdatePeriodicHandler::EffectUpdatePeriodicHandler(AuraEffectUpdatePeriodicFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

void AuraScript::EffectUpdatePeriodicHandler::Call(AuraScript * auraScript, AuraEffect * aurEff)
{
    (auraScript->*pEffectHandlerScript)(aurEff);
}

AuraScript::EffectCalcAmountHandler::EffectCalcAmountHandler(AuraEffectCalcAmountFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

void AuraScript::EffectCalcAmountHandler::Call(AuraScript * auraScript, AuraEffect const * aurEff, int32 & amount, bool & canBeRecalculated)
{
    (auraScript->*pEffectHandlerScript)(aurEff, amount, canBeRecalculated);
}

AuraScript::EffectCalcPeriodicHandler::EffectCalcPeriodicHandler(AuraEffectCalcPeriodicFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

void AuraScript::EffectCalcPeriodicHandler::Call(AuraScript * auraScript, AuraEffect const * aurEff, bool & isPeriodic, int32 & periodicTimer)
{
    (auraScript->*pEffectHandlerScript)(aurEff, isPeriodic, periodicTimer);
}

AuraScript::EffectCalcSpellModHandler::EffectCalcSpellModHandler(AuraEffectCalcSpellModFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
}

void AuraScript::EffectCalcSpellModHandler::Call(AuraScript * auraScript, AuraEffect const * aurEff, SpellModifier *& spellMod)
{
    (auraScript->*pEffectHandlerScript)(aurEff, spellMod);
}

AuraScript::EffectApplyHandler::EffectApplyHandler(AuraEffectApplicationModeFnType _pEffectHandlerScript,uint8 _effIndex, uint16 _effName, AuraEffectHandleModes _mode)
    : AuraScript::EffectBase(_effIndex, _effName)
{
    pEffectHandlerScript = _pEffectHandlerScript;
    mode = _mode;
}

void AuraScript::EffectApplyHandler::Call(AuraScript * auraScript, AuraEffect const * _aurEff, AuraApplication const * _aurApp, AuraEffectHandleModes _mode)
{
    if (_mode & mode)
        (auraScript->*pEffectHandlerScript)(_aurEff, _aurApp, _mode);
}

bool AuraScript::_Load(Aura * aura)
{
    m_aura = aura;
    return Load();
}

SpellEntry const* AuraScript::GetSpellProto() const
{
    return m_aura->GetSpellProto();
}

uint32 AuraScript::GetId() const
{
    return m_aura->GetId();
}

uint64 const& AuraScript::GetCasterGUID() const
{
    return m_aura->GetCasterGUID();
}

Unit* AuraScript::GetCaster() const
{
    return m_aura->GetCaster();
}

WorldObject* AuraScript::GetOwner() const
{
    return m_aura->GetOwner();
}

Unit* AuraScript::GetUnitOwner() const
{
    return m_aura->GetUnitOwner();
}

DynamicObject* AuraScript::GetDynobjOwner() const
{
    return m_aura->GetDynobjOwner();
}

void AuraScript::Remove(uint32 removeMode)
{
    m_aura->Remove((AuraRemoveMode)removeMode);
}

Aura* AuraScript::GetAura() const
{
    return m_aura;
}

AuraObjectType AuraScript::GetType() const
{
    return m_aura->GetType();
}

int32 AuraScript::GetDuration() const
{
    return m_aura->GetDuration();
}

void AuraScript::SetDuration(int32 duration, bool withMods)
{
    m_aura->SetDuration(duration, withMods);
}

void AuraScript::RefreshDuration()
{
    m_aura->RefreshDuration();
}

time_t AuraScript::GetApplyTime() const
{
    return m_aura->GetApplyTime();
}

int32 AuraScript::GetMaxDuration() const
{
    return m_aura->GetMaxDuration();
}

void AuraScript::SetMaxDuration(int32 duration)
{
    m_aura->SetMaxDuration(duration);
}

bool AuraScript::IsExpired() const
{
    return m_aura->IsExpired();
}

bool AuraScript::IsPermanent() const
{
    return m_aura->IsPermanent();
}

uint8 AuraScript::GetCharges() const
{
    return m_aura->GetCharges();
}

void AuraScript::SetCharges(uint8 charges)
{
    m_aura->SetCharges(charges);
}

bool AuraScript::DropCharge()
{
    return m_aura->DropCharge();
}

uint8 AuraScript::GetStackAmount() const
{
    return m_aura->GetStackAmount();
}

void AuraScript::SetStackAmount(uint8 num, bool applied)
{
    m_aura->SetStackAmount(num, applied);
}

bool AuraScript::ModStackAmount(int32 num)
{
    return m_aura->ModStackAmount(num);
}

bool AuraScript::IsPassive() const
{
    return m_aura->IsPassive();
}

bool AuraScript::IsDeathPersistent() const
{
    return m_aura->IsDeathPersistent();
}

bool AuraScript::HasEffect(uint8 effIndex) const
{
    return m_aura->HasEffect(effIndex);
}

AuraEffect* AuraScript::GetEffect(uint8 effIndex) const
{
    return m_aura->GetEffect(effIndex);
}

bool AuraScript::HasEffectType(AuraType type) const
{
    return m_aura->HasEffectType(type);
}

