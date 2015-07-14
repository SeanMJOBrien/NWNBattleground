void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_GOOD,100);
SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oPC);
SetLocalInt(oPC,"race",3);
SetXP(oPC,0);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(1);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
itemproperty ipINT = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2);
itemproperty ipWIS = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4);
itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,4);
itemproperty ipDisimm = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
itemproperty ipDRa = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10);
itemproperty ipDRc = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10);
itemproperty ipDRe = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_10);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
itemproperty ipSR = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14);
itemproperty ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,4);

effect eFly;
eFly = EffectMovementSpeedIncrease(50);
eFly = SupernaturalEffect(eFly);

AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDisimm,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRa,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRc,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRe,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSave,oHide);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFly,oPC);


CreateItemOnObject("divinerod",oPC);
CreateItemOnObject("rod_fly",oPC);

}
