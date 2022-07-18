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
int iRoll = d8();
if (d100()<=iHD) iRoll=90+d6();
object oItem;

switch(iRoll)
        {
        case 1:
        oItem = CreateItemOnObject("plate",OBJECT_SELF);
        break;
        case 2:
        oItem = CreateItemOnObject("chainmail2",OBJECT_SELF);
        break;
        case 3:
        oItem = CreateItemOnObject("splintarmor",OBJECT_SELF);
        break;
        case 4:
        oItem = CreateItemOnObject("halfplate",OBJECT_SELF);
        break;
        case 5:
        oItem = CreateItemOnObject("bandedmail",OBJECT_SELF);
        break;
        case 6:
        oItem = CreateItemOnObject("mwplate",OBJECT_SELF);
        break;
        case 7:
        oItem = CreateItemOnObject("breastplate",OBJECT_SELF);
        break;
        case 8:
        oItem = CreateItemOnObject("chainmail",OBJECT_SELF);
        break;
        case 91:
        oItem = CreateItemOnObject("adam_hplate",OBJECT_SELF);
        break;
        case 92:
        oItem = CreateItemOnObject("adam_plate",OBJECT_SELF);
        break;
        case 93:
        oItem = CreateItemOnObject("mith_plate",OBJECT_SELF);
        break;
        case 94:
        oItem = CreateItemOnObject("adam_splint",OBJECT_SELF);
        break;
        case 95:
        oItem = CreateItemOnObject("adam_band",OBJECT_SELF);
        break;
        case 96:
        oItem = CreateItemOnObject("mith_dplate",OBJECT_SELF);
        break;
        }

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
object oSimple4 = CopyItemAndModify(oSimple3,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL1,Random(175),TRUE);
DestroyObject(oSimple3);
object oSimple5 = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHOULDER,Random(20)+1,TRUE);
DestroyObject(oSimple4);
object oFinal = CopyItemAndModify(oSimple4,ITEM_APPR_TYPE_ARMOR_COLOR ,ITEM_APPR_ARMOR_COLOR_METAL2,Random(175),TRUE);
DestroyObject(oSimple5);
SetLocalInt(oFinal,"itemlevel",iHD);
DelayCommand(2.0f,ActionEquipItem(oFinal,INVENTORY_SLOT_CHEST));
SetDroppableFlag(oFinal,FALSE);


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
itemproperty ipImm1 = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB);
itemproperty ipImm2 = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
sName = GetName(oFinal);
IPSafeAddItemProperty(oFinal,ipImm1,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
IPSafeAddItemProperty(oFinal,ipImm2,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oFinal,"Fortification "+sName);
}
if (iHD>=d100(3))
{
itemproperty ipHaste = ItemPropertyHaste();
sName = GetName(oFinal);
IPSafeAddItemProperty(oFinal,ipHaste,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oFinal,"Temporal "+sName);
}
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
