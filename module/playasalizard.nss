void main()
{
object oPC = GetPCSpeaker();
int iRand = d6();
if (iRand==1)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A);
if (iRand==2)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B);
if (iRand==3)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_A);
if (iRand==4)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_B);
if (iRand==5)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A);
if (iRand==5)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B);
SetLocalInt(oPC,"race",4);
SetXP(oPC,6000);
object oHide = GetItemPossessedBy(oPC,"cyberhide");


itemproperty ipAC = ItemPropertyACBonus(5);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
itemproperty ipINT = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2);
itemproperty ipDark = ItemPropertyDarkvision();



AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipINT,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);


}
