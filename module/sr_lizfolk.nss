void main()
{
object oPC = OBJECT_SELF;
object oWidget = GetItemPossessedBy(oPC,"widget");
SetLocalFloat(oWidget,"xpmod",0.8f);
SetLocalInt(oWidget,"subrace",4);
object oHide = GetItemPossessedBy(oPC,"cyberhide");
if (oHide==OBJECT_INVALID)
    {
    oHide = CreateItemOnObject("cyberhide",oPC);
    AssignCommand(oPC,ActionEquipItem(oHide,INVENTORY_SLOT_CARMOUR));
    }

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
int iRand = Random(9)+1;
if (iRand==1)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A);
if (iRand==2)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B);
if (iRand==3)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_A);
if (iRand==4)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_B);
if (iRand==5)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A);
if (iRand==6)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B);
if (iRand==7)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ASABI_CHIEFTAIN);
if (iRand==8)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ASABI_SHAMAN);
if (iRand==9)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ASABI_WARRIOR);
}
