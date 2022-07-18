void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
SetCreatureWingType(CREATURE_WING_TYPE_BAT,oPC);
SetLocalInt(oPC,"race",5);
SetXP(oPC,0);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(1);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4);
itemproperty ipINT = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,4);
//itemproperty ipWIS = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4);
itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2);
itemproperty ipDisimm = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
itemproperty ipDRa = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10);
itemproperty ipDRc = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10);
itemproperty ipDRe = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_10);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
itemproperty ipSR = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14);
//itemproperty ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,4);
itemproperty ipDRf = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10);
//itemproperty ipDR5 = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
effect eFly;
eFly = EffectMovementSpeedIncrease(50);
eFly = SupernaturalEffect(eFly);

AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDisimm,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRa,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRc,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRe,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSR,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipSave,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipDR5,oHide);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFly,oPC);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRf,oHide);


CreateItemOnObject("fiendrod",oPC);
CreateItemOnObject("rod_fly",oPC);

}
