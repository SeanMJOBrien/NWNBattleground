void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_NEUTRAL,100);
AdjustAlignment(oPC,ALIGNMENT_GOOD,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_FAIRY);
SetLocalInt(oPC,"race",16);
SetXP(oPC,0);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(2);
itemproperty ipSTR = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,4);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,8);
itemproperty ipINT = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,6);
itemproperty ipWIS = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4);
itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,6);
itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP);
itemproperty ipSR = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22);
itemproperty ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,4);

effect eFly;
eFly = EffectMovementSpeedIncrease(50);
eFly = SupernaturalEffect(eFly);

AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSave,oHide);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFly,oPC);

object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
AssignCommand(oPC,ActionUnequipItem(oArmor));


CreateItemOnObject("pixierod",oPC);
CreateItemOnObject("pixierod_fly",oPC);
CreateItemOnObject("pixie_sword",oPC);
CreateItemOnObject("pixie_shortbow",oPC);
CreateItemOnObject("pixie_arrows",oPC,99);

}
