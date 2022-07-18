#include "x2_inc_itemprop"
//helms 47-75 need to be added and 101-107

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
object oItem = CreateItemOnObject("helmet",OBJECT_SELF);
string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/3.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);

if (iHD>=d100())
    {
     itemproperty ipAC = ItemPropertyACBonus(iEnch);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipAC,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }

object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,0,Random(35)+1,TRUE);
DestroyObject(oItem);
object oSimple2 = CopyItemAndModify(oSimple,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH1,Random(175),TRUE);
DestroyObject(oSimple);
object oSimple3 = CopyItemAndModify(oSimple2,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_CLOTH2,Random(175),TRUE);
DestroyObject(oSimple2);
object oSimple4 = CopyItemAndModify(oSimple3,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL1,Random(175),TRUE);
DestroyObject(oSimple3);
object oFinal = CopyItemAndModify(oSimple4,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL2,Random(175),TRUE);
DestroyObject(oSimple4);
DelayCommand(2.0f,ActionEquipItem(oFinal,INVENTORY_SLOT_HEAD));
SetDroppableFlag(oFinal,FALSE);
SetLocalInt(oFinal,"itemlevel",iHD);

if (iHD>=d100())
{
itemproperty ipDV = ItemPropertyDarkvision();
sName = GetName(oFinal);
IPSafeAddItemProperty(oFinal,ipDV,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oFinal,sName+" (Darkvision)");
}
if (iHD>=d100(4))
{
itemproperty ipTS = ItemPropertyTrueSeeing();
sName = GetName(oFinal);
IPSafeAddItemProperty(oFinal,ipTS,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oFinal,sName+" (True Seeing)");
}
//check for damage reduction
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damred",oFinal));
}
//check for saves
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_saves",oFinal));
}
//check for spell slots
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_spellslots",oFinal));
}
//check for skills
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_skill",oFinal));
}
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
