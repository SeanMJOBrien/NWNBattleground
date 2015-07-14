void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_OGRE_CHIEFTAIN);
SetLocalInt(oPC,"race",2);
SetXP(oPC,6000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(5);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,10);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4);
itemproperty ipDEX = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2);
itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,4);
//itemproperty ipWIS = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2);
itemproperty ipCHA = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,4);
itemproperty ipKD = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN);

//itemproperty ipRegen = ItemPropertyRegeneration(5);
itemproperty ipDark = ItemPropertyDarkvision();
effect eFly;
eFly = EffectMovementSpeedIncrease(25);
eFly = SupernaturalEffect(eFly);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFly,oPC);



AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipRegen,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipKD,oHide);

object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
AssignCommand(oPC,ActionUnequipItem(oArmor));
object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
AssignCommand(oPC,ActionUnequipItem(oWep));
object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
AssignCommand(oPC,ActionUnequipItem(oShield));

object oClaw1 = CreateItemOnObject("ogreclub",oPC);
      SetIdentified(oClaw1,TRUE);
      AssignCommand(oPC,DelayCommand(3.3f,ActionEquipItem(oClaw1,INVENTORY_SLOT_RIGHTHAND)));
}
