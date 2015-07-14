void main()
{
object oPC = OBJECT_SELF;
AdjustAlignment(oPC,ALIGNMENT_EVIL,100);
object oWidget = GetItemPossessedBy(oPC,"widget");
SetLocalFloat(oWidget,"xpmod",0.8f);
SetLocalInt(oWidget,"subrace",18);
object oHide = GetItemPossessedBy(oPC,"cyberhide");
if (oHide==OBJECT_INVALID)
    {
    oHide = CreateItemOnObject("cyberhide",oPC);
    AssignCommand(oPC,ActionEquipItem(oHide,INVENTORY_SLOT_CARMOUR));
    }
itemproperty ipAC = ItemPropertyACBonus(3);
itemproperty ipSTR = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4);
itemproperty ipCON = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2);
itemproperty ipDEX = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2);
itemproperty ipCHA = ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,2);
itemproperty ipMS = ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,4);
itemproperty ipDark = ItemPropertyDarkvision();
AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSTR,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDEX,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCON,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipMS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
int iRoll = d6();
if (iRoll==1) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_A);
if (iRoll==2) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_B);
if (iRoll==3) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_A);
if (iRoll==4) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_B);
if (iRoll==5) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_SHAMAN_A);
if (iRoll==6) SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_SHAMAN_B);

}
