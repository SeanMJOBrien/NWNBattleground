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

object oItem = CreateItemOnObject("boots",OBJECT_SELF);

string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/4.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>10) iEnch=10;
string sEnch = IntToString(iEnch);

if (iHD>=d100())
    {
     itemproperty ipAC = ItemPropertyACBonus(iEnch);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipAC,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }

object oModel = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,Random(4)+1,TRUE);
DestroyObject(oItem);
object oModel2 = CopyItemAndModify(oModel,ITEM_APPR_TYPE_SIMPLE_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,Random(4)+1,TRUE);
DestroyObject(oModel);
object oModel3 = CopyItemAndModify(oModel,ITEM_APPR_TYPE_SIMPLE_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,Random(4)+1,TRUE);
DestroyObject(oModel2);
object oColor = CopyItemAndModify(oModel3,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,Random(4)+1,TRUE);
DestroyObject(oModel3);
object oColor2 = CopyItemAndModify(oColor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,Random(4)+1,TRUE);
DestroyObject(oColor);
object oColor3 = CopyItemAndModify(oColor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,Random(3)+1,TRUE);
DestroyObject(oColor2);
DelayCommand(2.1f,ActionEquipItem(oColor3,INVENTORY_SLOT_BOOTS));

//SetDroppableFlag(oColor3,FALSE);
SetLocalInt(oColor3,"itemlevel",iHD);
if (iHD>=d100(2))
{
itemproperty ipHaste = ItemPropertyHaste();
sName = GetName(oColor3);
IPSafeAddItemProperty(oColor3,ipHaste,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oColor3,"Quick "+sName);
}
if (iHD>=d100(2))
{
itemproperty ipFoM = ItemPropertyFreeAction();
sName = GetName(oColor3);
IPSafeAddItemProperty(oColor3,ipFoM,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oColor3,"Freedom "+sName);
}
if (iHD>=d100(2))
{
itemproperty ipIE = ItemPropertyImprovedEvasion();
sName = GetName(oColor3);
IPSafeAddItemProperty(oColor3,ipIE,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oColor3,"Nimble "+sName);
}
ExecuteScript("name_color",oColor3);
}
