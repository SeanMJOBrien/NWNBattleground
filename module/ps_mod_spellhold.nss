#include "x2_inc_switches"
void main()
{
int nSpellID = GetSpellId(); // returns the SPELL_* constant of the spell cast
object oTarget = GetSpellTargetObject(); // returns the targeted object of the spell, if valid
location lTarget = GetSpellTargetLocation(); // returns the targeted location of the spell, if valid
int nClassCastAs = GetLastSpellCastClass(); // gets the class the PC cast the spell as
object oItemCast = GetSpellCastItem(); // if an item cast the spell, this function gets that item
int nSaveDC = GetSpellSaveDC(); // gets the DC required to save against the effects of the spell
int nCasterLevel =  GetCasterLevel(OBJECT_SELF); // gets the level the PC cast the spell as
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
if ((GetIsPC(OBJECT_SELF)) && (!GetIsObjectValid(oItemCast)))
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
    int nHasSymbol;
    int nConsumed;
    int nArcaneCaster; // 0 for divine magic, 1 for arcane.
    if ((nClassCastAs == CLASS_TYPE_BARD) || (nClassCastAs == CLASS_TYPE_SORCERER) || (nClassCastAs == IP_CONST_CLASS_WIZARD))
        nArcaneCaster = 1;
    object oScan = GetFirstItemInInventory(OBJECT_SELF);
    while ((oScan != OBJECT_INVALID) && (nDebt > 0))
        {
        if ((GetSubString(GetTag(oScan),0,9) == "MATERIAL_") && (nArcaneCaster))
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
        else if ((!nArcaneCaster) && (GetTag(oScan) == "HOLYSYMBOL") && (GetStringLowerCase(GetLocalString(oScan,"Deity")) == GetStringLowerCase(GetDeity(OBJECT_SELF))))
            {
            nHasSymbol = TRUE;
            break;
            }
        oScan = GetNextItemInInventory(OBJECT_SELF);
        }

    if (!nArcaneCaster)
        {
        string sDeity = GetStringLowerCase(GetDeity(OBJECT_SELF));
        if (nHasSymbol == FALSE)
            {
            SendMessageToPC(OBJECT_SELF,"A symbol is required to cast spells.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "pelor") && (GetIsNight()))
            {
            SendMessageToPC(OBJECT_SELF,"Pelor does not grant spells at night.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "heironeous") && (nClassCastAs != CLASS_TYPE_PALADIN))
            {
            SendMessageToPC(OBJECT_SELF,"Heironeous only grants spells to paladins.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "boccob") && (GetLevelByClass(nClassCastAs,OBJECT_SELF) > GetLevelByClass(CLASS_TYPE_WIZARD,OBJECT_SELF)))
            {
            SendMessageToPC(OBJECT_SELF,"You must maintain levels of wizard at least equal to your clerical level for Boccob to grant you spells.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "cuthbert") && (GetLevelByClass(nClassCastAs,OBJECT_SELF) > GetLevelByClass(CLASS_TYPE_FIGHTER,OBJECT_SELF)))
            {
            SendMessageToPC(OBJECT_SELF,"You must maintain levels of fighter at least equal to your clerical level for St. Cuthbert to grant you spells.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "ralishaz") && (d20() > (20 - nSpellLevel)))
            {
            SendMessageToPC(OBJECT_SELF,"It's your turn to be unlucky.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_M),OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage((d4(nSpellLevel)),DAMAGE_TYPE_FIRE),OBJECT_SELF);
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if ((sDeity == "rao") && (GetDistanceBetween(OBJECT_SELF,GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,OBJECT_SELF)) <= 30.0)
            && (GetDistanceBetween(OBJECT_SELF,GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,OBJECT_SELF)) != 0.0))
            {
            SendMessageToPC(OBJECT_SELF,"Rao will not grant spells in the presence of enemies.");
            SetModuleOverrideSpellScriptFinished();
            return;
            }
        else if (sDeity == "zilchus")
            {
            if (GetGold(OBJECT_SELF) < (nSpellLevel * 5))
                {
                SendMessageToPC(OBJECT_SELF,"You do not have sufficient gold to satisfy Zilchus.");
                SetModuleOverrideSpellScriptFinished();
                return;
                }
            else
                {
                TakeGoldFromCreature((nSpellLevel * 5),OBJECT_SELF,TRUE);
                }
            }
        }
    else if ((nDebt > 0) && (nArcaneCaster))
        {
//        if (nConsumed == 0) SendMessageToPC(OBJECT_SELF,"Material components are required to cast spells.");
//        else SendMessageToPC(OBJECT_SELF,"Though you don't have enough material components to cast this spell, reagents have been consumed in the attempt.");
//        SetModuleOverrideSpellScriptFinished();
        if (nConsumed == 0) SendMessageToPC(OBJECT_SELF,"You take damage from casting without material components.");
        else SendMessageToPC(OBJECT_SELF,"You didn't have sufficient material components for this spell.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDebt),OBJECT_SELF);
        }
    }
}
