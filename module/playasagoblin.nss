void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
//AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GOBLIN_B);
SetLocalInt(oPC,"race",7);
SetXP(oPC,10000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


//itemproperty ipAC = ItemPropertyACBonus(5);
itemproperty ipSTR = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,2);
//itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
//itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2);
//itemproperty ipWIS = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2);
itemproperty ipCHA = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,2);

//itemproperty ipRegen = ItemPropertyRegeneration(5);
itemproperty ipDark = ItemPropertyDarkvision();



//AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);

CreateItemOnObject("worghorn",oPC);
}
