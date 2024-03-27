#include "x2_inc_switches"
void main()
{
SetLocalInt(OBJECT_SELF, "nNormalSpells", 1);  //Set to 1 for normal spells, 0 for the original system with divine/sacrifice and arcane component requirements
if (GetLocalInt(OBJECT_SELF, "nNormalSpells") == 1)
    {
    return; // Disabling the special spell code if nNormalSpells=1
    }
int nSpellID = GetSpellId(); // returns the SPELL_* constant of the spell cast
object oTarget = GetSpellTargetObject(); // returns the targeted object of the spell, if valid
location lTarget = GetSpellTargetLocation(); // returns the targeted location of the spell, if valid
int nClassCastAs = GetLastSpellCastClass(); // gets the class the PC cast the spell as
object oItemCast = GetSpellCastItem(); // if an item cast the spell, this function gets that item
int nSaveDC = GetSpellSaveDC(); // gets the DC required to save against the effects of the spell
int nCasterLevel =  GetCasterLevel(OBJECT_SELF); // gets the level the PC cast the spell as
if ((GetIsPC(OBJECT_SELF)) && (!GetIsPossessedFamiliar(OBJECT_SELF)) && (!GetIsObjectValid(oItemCast)))
    {
    int nAbilityMod;
    switch (nClassCastAs)
        {
        case CLASS_TYPE_BARD: case CLASS_TYPE_SORCERER:
        nAbilityMod = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
        break;
        case CLASS_TYPE_CLERIC: case CLASS_TYPE_DRUID:
        case CLASS_TYPE_PALADIN: case CLASS_TYPE_RANGER:
        nAbilityMod = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        break;
        case CLASS_TYPE_WIZARD:
        nAbilityMod = GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF);
        break;
        }
    int nSpellLevel = nSaveDC - 10 - nAbilityMod;
    int nDebt = nSpellLevel * nSpellLevel;
    if (nDebt < 1) return;
    int nMatStr;
    int nConsumed;
    int nArcaneCaster; // 0 for divine magic, 1 for arcane.
    if ((nClassCastAs == CLASS_TYPE_BARD) || (nClassCastAs == CLASS_TYPE_SORCERER) || (nClassCastAs == IP_CONST_CLASS_WIZARD))
        nArcaneCaster = 1;
    if (nArcaneCaster)
        {
        object oScan = GetFirstItemInInventory(OBJECT_SELF);
        while ((oScan != OBJECT_INVALID) && (nDebt > 0))
            {
            if (((GetSubString(GetTag(oScan),0,9) == "MATERIAL_") || (GetTag(oScan) == "ARCANE_FOCUS")) && (nArcaneCaster))
                {
                if (GetLocalInt(oScan,"Points") != 0)
                    {
                    nMatStr = GetLocalInt(oScan,"Points");
                    }
                else
                    {
                    nMatStr = StringToInt(GetSubString(GetTag(oScan),9,3));
                    }
                if (nDebt >= nMatStr)
                    {
                    nDebt -= nMatStr;
                    DestroyObject(oScan);
                    nConsumed++;
                    }
                else
                    {
                    nMatStr -= nDebt;
                    nDebt = 0;
                    SetLocalInt(oScan,"Points",nMatStr);
                    }
                }
            oScan = GetNextItemInInventory(OBJECT_SELF);
            }
        if (nDebt > 0)
            {
            if (nConsumed == 0) SendMessageToPC(OBJECT_SELF,"You take damage from casting without material components.");
            else SendMessageToPC(OBJECT_SELF,"You didn't have sufficient material components for this spell.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDebt),OBJECT_SELF);
            }
        }
    else if (!nArcaneCaster)
        {
//      SpawnScriptDebugger();
        int nTithe = GetCampaignInt("SHIELD_LANDS","TITHE_"+GetName(OBJECT_SELF));
        nDebt = nDebt * 2;
        object oSymbol = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
//      string sSymbol = GetTag(oSymbol);
//      int nAlignmentGE =GetAlignmentGoodEvil(OBJECT_SELF);
        if (GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF) > 0)
            {
            if ((GetTag(oSymbol) == "HOLYSYMBOL") && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD))
                {
                nDebt -= GetLocalInt(oSymbol,"Points");
                }
            else if ((GetTag(oSymbol) == "UNHOLYSYMBOL") && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL))
                {
                nDebt -= GetLocalInt(oSymbol,"Points");
                }
            else if ((GetTag(oSymbol) == "BALANCESYMBOL") && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_NEUTRAL))
                {
                nDebt -= GetLocalInt(oSymbol,"Points");
                }
            }
        if (nTithe < nDebt)
            {
            SendMessageToPC(OBJECT_SELF,"Your deity does not grant you the spell you have requested.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else
            {
            if (nDebt < 0) nDebt = 0;
            nTithe -= nDebt;
            SetCampaignInt("SHIELD_LANDS","TITHE_"+GetName(OBJECT_SELF),nTithe);
            }
        }
    }
if ((nSpellID == SPELL_CURE_LIGHT_WOUNDS)
    || (nSpellID == SPELL_CURE_MINOR_WOUNDS)
    || (nSpellID == SPELL_CURE_MODERATE_WOUNDS)
    || (nSpellID == SPELL_CURE_SERIOUS_WOUNDS)
    || (nSpellID == SPELL_CURE_CRITICAL_WOUNDS))
    {
    effect eGlimmer;
    int nHeal = nCasterLevel;;
    int nCurrentHP = GetCurrentHitPoints(oTarget);
    int nMaxHP = GetMaxHitPoints(oTarget);
    int nTargetHP = nCurrentHP;
    if (nSpellID == SPELL_CURE_MINOR_WOUNDS)
        {
        eGlimmer = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
        }
    else if (nSpellID == SPELL_CURE_LIGHT_WOUNDS)
        {
        eGlimmer = EffectVisualEffect(VFX_IMP_HEALING_L);
        if (nHeal > 5) nHeal = 5;
        nHeal += 8;
        }
    else if (nSpellID == SPELL_CURE_MODERATE_WOUNDS)
        {
        eGlimmer = EffectVisualEffect(VFX_IMP_HEALING_M);
        if (nHeal > 10) nHeal = 10;
        nHeal += 16;
        }
    else if (nSpellID == SPELL_CURE_SERIOUS_WOUNDS)
        {
        eGlimmer = EffectVisualEffect(VFX_IMP_HEALING_S);
        if (nHeal > 15) nHeal = 15;
        nHeal += 24;
        }
    else if (nSpellID == SPELL_CURE_CRITICAL_WOUNDS)
        {
        eGlimmer = EffectVisualEffect(VFX_IMP_HEALING_G);
        if (nHeal > 20) nHeal = 20;
        nHeal += 32;
        }
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eGlimmer,oTarget);
    while (nHeal > 0)
        {
        if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.60)
            {
            nHeal -= 1;
            nTargetHP ++;
            }
        else if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.84)
            {
            if (nHeal > 1)
                {
                nHeal -= 2;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        else if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.94)
            {
            if (nHeal > 3)
                {
                nHeal -= 3;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        else
            {
            if (nHeal > 3)
                {
                nHeal -= 4;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        } //while (nHeal > 0)
    nHeal = nTargetHP - nCurrentHP;
    if (nHeal > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oTarget);
    SetModuleOverrideSpellScriptFinished();
    }

}
