#include "x2_inc_itemprop"

void main()
{
object oOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
DestroyObject(oOld,0.0f);
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////
int iRoll = d4();
if (d100()<=iHD) iRoll=99;

object oItem;

if (iRoll==1||iRoll==2) oItem = CreateItemOnObject("bardarmor1",OBJECT_SELF);
if (iRoll==3||iRoll==4) oItem = CreateItemOnObject("bardarmor2",OBJECT_SELF);
if (iRoll==99) oItem = CreateItemOnObject("mithchain",OBJECT_SELF);

string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);

if (iHD>=d100())
    {
     itemproperty ipAC = ItemPropertyACBonus(iEnch);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipAC,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     sName = GetName(oItem);
    }


object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER,Random(20)+1,TRUE);
DestroyObject(oItem);
object oSimple2 = CopyItemAndModify(oSimple,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH1,Random(175),TRUE);
DestroyObject(oSimple);
object oSimple3 = CopyItemAndModify(oSimple2,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH2,Random(175),TRUE);
DestroyObject(oSimple2);
object oSimple4 = CopyItemAndModify(oSimple3,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_LEATHER1,Random(175),TRUE);
DestroyObject(oSimple3);
object oSimple5 = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER,Random(20)+1,TRUE);
DestroyObject(oSimple4);
object oFinal = CopyItemAndModify(oSimple4,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_LEATHER2,Random(175),TRUE);
DestroyObject(oSimple5);
DelayCommand(2.0f,ActionEquipItem(oFinal,INVENTORY_SLOT_CHEST));
SetDroppableFlag(oFinal,FALSE);
SetLocalInt(oFinal,"itemlevel",iHD);

//check for spell resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_sr",oFinal));
}

//check for damage reduction
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damred",oFinal));
}
//check for damage resistance
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oFinal));
}
if (iHD>=d100(3))
{
itemproperty ipHaste = ItemPropertyHaste();
sName = GetName(oFinal);
IPSafeAddItemProperty(oFinal,ipHaste,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oFinal,"Hasted "+sName);
}
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
