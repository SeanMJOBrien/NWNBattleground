void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,100);
SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,oPC);
SetLocalInt(oPC,"race",9);
SetXP(oPC,0);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(4);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,8);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
//itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4);
itemproperty ipINT = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2);
//itemproperty ipWIS = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4);
itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipFimm = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
itemproperty ipImmpara = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);
itemproperty ipSleep = ItemPropertySpellImmunitySpecific(IP_CONST_IMMUNITYSPELL_SLEEP);

effect eFly;
eFly = EffectMovementSpeedIncrease(50);
eFly = SupernaturalEffect(eFly);

AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipFimm,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipImmpara,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSleep,oHide);


ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFly,oPC);




CreateItemOnObject("dragonrod",oPC);
CreateItemOnObject("rod_fly",oPC);

}
