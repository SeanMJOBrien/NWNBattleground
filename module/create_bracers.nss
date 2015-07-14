#include "x2_inc_itemprop"

void main()
{

/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////

object oItem = CreateItemOnObject("bracers",OBJECT_SELF);
string sName = GetName(oItem);
itemproperty ipBracer;
string sSName;
int iAbilAmt = FloatToInt((iHD*12.0f)/40.0f);
if (iAbilAmt<=0) iAbilAmt=1;
if (iAbilAmt>12) iAbilAmt=12;
string sAmt = "";
string sValue;
int iProt = FloatToInt((iHD*10.0f)/40.0f);
if(iProt<1) iProt=1;
if(iProt>20) iProt=20;
string sPAmt = IntToString(iProt);

if (d100()<=iHD)
    {
switch(d10())
        {
        case 1:
        ipBracer = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,Random(iAbilAmt)+1);
        sSName = " of Dexterity";
        break;
        case 2:
        ipBracer = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,Random(iAbilAmt)+1);
        sSName = " of Great Strength";
        break;
        case 3:
        ipBracer = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,Random(iAbilAmt)+1);
        sSName = " of Health";
        break;
        case 4:
        ipBracer = ItemPropertyBonusFeat(IP_CONST_FEAT_POINTBLANK);
        sSName = " of Archery";
        break;
        case 5:
        ipBracer = ItemPropertyBonusFeat(IP_CONST_FEAT_RAPID_SHOT);
        sSName = " of Swift Archery";
        break;
        case 6:
        ipBracer = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPFINESSE);
        sSName = " of Finesse";
        break;
        case 7:
        ipBracer = ItemPropertyACBonus(Random(iProt)+1);
        sSName = " of Armor";
        sValue = sPAmt;
        sAmt = " +"+sValue;
        break;
        case 8:
        ipBracer = ItemPropertyACBonus(Random(iProt)+1);
        sSName = " of Armor";
        sValue = sPAmt;
        sAmt = " +"+sValue;
        break;
        case 9:
        ipBracer = ItemPropertyACBonus(Random(iProt)+1);
        sSName = " of Armor";
        sValue = sPAmt;
        sAmt = " +"+sValue;
        break;
        case 10:
        ipBracer = ItemPropertyBonusFeat(IP_CONST_FEAT_SNEAK_ATTACK_1D6);
        sSName = " of Backstabbing";
        break;
        }

IPSafeAddItemProperty(oItem,ipBracer,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,sName+sSName+sAmt);
    }//end if
int iModel=d12();
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,0,iModel,TRUE);
DestroyObject(oItem);
SetLocalInt(oSimple,"itemlevel",iHD);
DelayCommand(2.3f,ActionEquipItem(oSimple,INVENTORY_SLOT_ARMS));
//SetDroppableFlag(oSimple,FALSE);

//check for spell resistance
if (iHD>=d20(4))
{
DelayCommand(0.0f,ExecuteScript("add_sr",oSimple));
}
//check for spell casting
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_spell",oSimple));
}
//check for ability bonus
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_ability",oSimple));
}
//check for damage resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oSimple));
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
