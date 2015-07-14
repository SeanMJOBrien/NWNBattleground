void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_TROLL);
SetLocalInt(oPC,"race",1);
SetXP(oPC,5000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(5);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,12);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,12);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4);
itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,4);
itemproperty ipWIS = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2);
itemproperty ipCHA = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,4);
itemproperty ipKD = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN);

itemproperty ipRegen = ItemPropertyRegeneration(5);
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
AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipRegen,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipKD,oHide);

object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
AssignCommand(oPC,ActionUnequipItem(oArmor));
object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
AssignCommand(oPC,ActionUnequipItem(oWep));
object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
AssignCommand(oPC,ActionUnequipItem(oShield));

object oClaw1 = CreateItemOnObject("trollclaw",oPC);
      SetIdentified(oClaw1,TRUE);
      AssignCommand(oPC,DelayCommand(0.3f,ActionEquipItem(oClaw1,INVENTORY_SLOT_CWEAPON_L)));
object oClaw2 = CreateItemOnObject("trollclaw",oPC);
      SetIdentified(oClaw2,TRUE);
      AssignCommand(oPC,DelayCommand(0.3f,ActionEquipItem(oClaw2,INVENTORY_SLOT_CWEAPON_R)));
object oBite = CreateItemOnObject("trollbite",oPC);
      SetIdentified(oBite,TRUE);
      AssignCommand(oPC,DelayCommand(0.3f,ActionEquipItem(oBite,INVENTORY_SLOT_CWEAPON_B)));
}
