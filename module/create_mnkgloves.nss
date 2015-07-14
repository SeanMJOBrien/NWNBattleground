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

object oItem = CreateItemOnObject("mnkgloves",OBJECT_SELF);
string sName = GetName(oItem);


if (iHD<=d20(3))
{
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);
itemproperty ipAtt = ItemPropertyAttackBonus(iEnch);
IPSafeAddItemProperty(oItem,ipAtt,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,"+"+sEnch+" "+sName);
}


object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(10)+1,TRUE);
DestroyObject(oItem);
DelayCommand(2.0f,ActionEquipItem(oSimple,INVENTORY_SLOT_ARMS));
SetLocalInt(oSimple,"itemlevel",iHD);
//SetDroppableFlag(oSimple,FALSE);

//check for damage bonus
if ((iHD+5)>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damage",oSimple));
}
//check for skills
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_skill",oSimple));
}
//check for on hit
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_onhit",oSimple));
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
