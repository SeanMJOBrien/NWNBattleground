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
object oItem = CreateItemOnObject("cloak",OBJECT_SELF);
string sName = GetName(oItem);

if (iHD>=d100())
{
int iProt = FloatToInt((iHD*10.0f)/40.0f);
if (iProt<=0) iProt=1;
if (iProt>10) iProt=10;
string sAmt = IntToString(iProt);
itemproperty ipProt = ItemPropertyACBonus(iProt);
IPSafeAddItemProperty(oItem,ipProt,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,"+"+sAmt+" "+sName);
}
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH1,Random(175),TRUE);
DestroyObject(oItem);
object oSimple2 = CopyItemAndModify(oSimple,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH2,Random(175),TRUE);
DestroyObject(oSimple);
object oSimple3 = CopyItemAndModify(oSimple2,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL1,Random(175),TRUE);
DestroyObject(oSimple2);
object oSimple4 = CopyItemAndModify(oSimple3,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL2,Random(175),TRUE);
DestroyObject(oSimple3);
object oFinal = CopyItemAndModify(oSimple4,ITEM_APPR_TYPE_ARMOR_MODEL,0,Random(45),TRUE);
DestroyObject(oSimple4);
DelayCommand(2.0f,ActionEquipItem(oFinal,INVENTORY_SLOT_CHEST));
SetDroppableFlag(oFinal,FALSE);
SetLocalInt(oFinal,"itemlevel",iHD);

//check for spell resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_sr",oFinal));
}
//check for damage resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oFinal));
}
//check for saves
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_saves",oFinal));
}
//check for skills
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_skill",oFinal));
}
//check for damage reduction
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damred",oFinal));
}
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
