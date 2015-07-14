#include "_include_main"
void main()
{
object oPC = GetPCSpeaker();
object oItem = GetFirstItemInInventory(OBJECT_SELF);
//make sure there is an item in there
if (oItem==OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("<cþ  >The forge is empty.</c>",oPC,0);
    return;
    }
//make sure they have enough mana
int iMana = GetLocalInt(oPC,"mana");
if (iMana<20)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough mana to enchant that item. You need 20.</c>",oPC,0);
    return;
    }
//make sure the item isnt too powerful already
int iValue = GetGoldPieceValue(oItem);
int iLimit = GetHitDice(oPC)*2000;
if (iValue>iLimit)
    {
    FloatingTextStringOnCreature("<cþ  >This item is too potent for you to enchant.</c>",oPC,0);
    return;
    }
SetLocalInt(oItem,"dontrename",1);
int iKind = GetBaseItemType(oItem);
int iType = 0;
//1=melee
//2=ranged
//3=thrown
if (GetIsWeapon(oItem)==TRUE)
    {
    if (GetIsMeleeWeapon(oItem)==TRUE) iType = 1;
    else if (iKind==BASE_ITEM_DART||iKind==BASE_ITEM_SHURIKEN||iKind==BASE_ITEM_THROWINGAXE) iType = 3;
    else iType = 2;
    }
//4=jewelry
//5=armor
//6=accessory
//7=ammunition
//8=mage staff
//9=spellcast item
if (iKind==BASE_ITEM_AMULET) iType = 4;
if (iKind==BASE_ITEM_ARMOR) iType = 5;
if (iKind==BASE_ITEM_BELT) iType = 6;
if (iKind==BASE_ITEM_ARROW) iType = 7;
if (iKind==BASE_ITEM_BOLT) iType = 7;
if (iKind==BASE_ITEM_BOOTS) iType = 6;
if (iKind==BASE_ITEM_BRACER) iType = 6;
if (iKind==BASE_ITEM_BULLET) iType = 7;
if (iKind==BASE_ITEM_CLOAK) iType = 6;
if (iKind==BASE_ITEM_GLOVES) iType = 6;
if (iKind==BASE_ITEM_HELMET) iType = 5;
if (iKind==BASE_ITEM_LARGESHIELD) iType = 5;
if (iKind==BASE_ITEM_MAGICROD) iType = 9;
if (iKind==BASE_ITEM_MAGICSTAFF) iType = 8;
if (iKind==BASE_ITEM_MAGICWAND) iType = 9;
if (iKind==BASE_ITEM_RING) iType = 4;
if (iKind==BASE_ITEM_SMALLSHIELD) iType = 5;
if (iKind==BASE_ITEM_TOWERSHIELD) iType = 5;
//kick out ineligible items
if (iType==0)
    {
    FloatingTextStringOnCreature("<cþ  >This item cannot be enchanted.</c>",oPC,0);
    return;
    }
//calculate the item enchant level
int iHD = GetHitDice(oPC);
int iWiz = GetLevelByClass(CLASS_TYPE_WIZARD,oPC);
int iSor = GetLevelByClass(CLASS_TYPE_SORCERER,oPC);
int iBard = GetLevelByClass(CLASS_TYPE_BARD,oPC);
int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
int iDruid = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
int iAA = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
int iBG = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
int iCoT = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC);
int iRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
int iHS = GetLevelByClass(CLASS_TYPE_HARPER,oPC);
int iPally = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
int iPM = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC);
int iRgr = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
int iShft = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
int iESorc = GetHasFeat(FEAT_EPIC_SORCERER,oPC);
int iEWiz = GetHasFeat(FEAT_EPIC_WIZARD,oPC);
int iEEnch = GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT,oPC);
int iGEnch = GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT,oPC);
int iEnch = GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT,oPC);
int iInt = GetAbilityScore(oPC,ABILITY_INTELLIGENCE);
int iMD = GetHasFeat(FEAT_MAGIC_DOMAIN_POWER,oPC);
int iSCRank = GetSkillRank(SKILL_SPELLCRAFT,oPC);
int iTotal;
iTotal = (iWiz*3)+(iSor*2)+(iBard*2)+iCleric+iDruid+(iAA*2)+iBG+iCoT+iRDD+(iHS*2)
+iPally+(iPM*2)+iRgr+iShft+iSCRank+iInt+iHD+1;
if (iESorc==1) iTotal+=3;
if (iEWiz==1) iTotal+=10;
if (iEnch==1) iTotal+=3;
if (iGEnch==1) iTotal+=6;
if (iEEnch==1) iTotal+=9;
if (iMD==1) iTotal+=5;
int iResult = iTotal/10;
if (iResult<=0) iResult=1;
SetLocalInt(oItem,"mylevel",iResult);
SpeakString("Item level will be approximately "+IntToString(iResult)+".");
//enchant the item scripts
if (iType==1) ExecuteScript("ench_melee",oItem);
if (iType==2) ExecuteScript("ench_ranged",oItem);
if (iType==3) ExecuteScript("ench_ammo",oItem);
if (iType==4) ExecuteScript("ench_jewelry",oItem);
if (iType==5) ExecuteScript("ench_armor",oItem);
if (iType==6) ExecuteScript("ench_armor",oItem);
if (iType==7) ExecuteScript("ench_ammo",oItem);
if (iType==8) ExecuteScript("ench_staff",oItem);
if (iType==9) ExecuteScript("ench_spells",oItem);
//charge the mana for enchanting
SetLocalInt(oPC,"mana",iMana-20);
FloatingTextStringOnCreature("<cþ þ>You successfully enchant the item.</c>",oPC,0);
ActionGiveItem(oItem,oPC);
}
