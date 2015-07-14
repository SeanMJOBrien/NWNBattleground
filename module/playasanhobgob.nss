void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
AdjustAlignment(oPC,ALIGNMENT_LAWFUL,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HOBGOBLIN_WARRIOR);
SetLocalInt(oPC,"race",11);
SetXP(oPC,6000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


//itemproperty ipAC = ItemPropertyACBonus(5);
//itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
//itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2);
//itemproperty ipWIS = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2);
//itemproperty ipCHA = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,2);
itemproperty ipMS = ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,4);

//itemproperty ipRegen = ItemPropertyRegeneration(5);
itemproperty ipDark = ItemPropertyDarkvision();



//AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
//AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipMS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);

CreateItemOnObject("hobgobscim",oPC);
}
