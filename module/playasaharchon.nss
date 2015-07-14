void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_GOOD,100);
AdjustAlignment(oPC,ALIGNMENT_LAWFUL,100);
SetCreatureAppearanceType(oPC,295);
SetLocalInt(oPC,"race",8);
SetXP(oPC,0);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(9);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
//itemproperty ipDEX = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2);
//itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2);
//itemproperty ipWIS = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2);
itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2);
itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
//itemproperty ipRegen = ItemPropertyRegeneration(5);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipElimm = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
itemproperty ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,4);
itemproperty ipSR = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24);

AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipElimm,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSave,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSR,oHide);

CreateItemOnObject("harconabil",oPC);
}
