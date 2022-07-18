void main()
{
object oPC = GetPCSpeaker();
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
AdjustAlignment(oPC,ALIGNMENT_LAWFUL,100);
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_KOBOLD_CHIEF_A);
SetLocalInt(oPC,"race",15);
SetXP(oPC,10000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(1);
itemproperty ipSTR = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,4);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
itemproperty ipCON = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,2);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipCT = ItemPropertySkillBonus(SKILL_CRAFT_TRAP,4);



AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCT,oHide);

CreateItemOnObject("koboldsling",oPC);
CreateItemOnObject("koboldbullets",oPC,99);
CreateItemOnObject("craft_trap",oPC);

}
