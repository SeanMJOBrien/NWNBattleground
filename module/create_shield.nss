#include "x2_inc_itemprop"

void main()
{
object oOld = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
DestroyObject(oOld,0.0f);
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////

int iSRoll = d10();
if (d6()<=4) iSRoll = d6();
object oItem;

switch (iSRoll)
        {
        case 1:
        oItem = CreateItemOnObject("lrgshield",OBJECT_SELF);
        break;
        case 2:
        oItem = CreateItemOnObject("lrgshield",OBJECT_SELF);
        break;
        case 3:
        oItem = CreateItemOnObject("lrgshield",OBJECT_SELF);
        break;
        case 4:
        oItem = CreateItemOnObject("lrgshield",OBJECT_SELF);
        break;
        case 5:
        oItem = CreateItemOnObject("towshield",OBJECT_SELF);
        break;
        case 6:
        oItem = CreateItemOnObject("smshield",OBJECT_SELF);
        break;
        case 7:
        oItem = CreateItemOnObject("lrgshield",OBJECT_SELF);
        break;
        case 8:
        oItem = CreateItemOnObject("towshield",OBJECT_SELF);
        break;
        case 9:
        oItem = CreateItemOnObject("towshield",OBJECT_SELF);
        break;
        case 10:
        oItem = CreateItemOnObject("smshield",OBJECT_SELF);
        break;
        }

if (iSRoll>=7)
        {
        string sName = GetName(oItem);
        int iEnch = Random(FloatToInt(iHD/6.0f));
        if (iEnch>20) iEnch=20;
        if (iEnch<=0) return;
        string sEnch = IntToString(iEnch);
        itemproperty ipEnch = ItemPropertyEnhancementBonus(iEnch);
        SetName(oItem,"+"+sEnch+" "+sName);
        IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        DelayCommand(1.6f,ActionEquipItem(oItem,INVENTORY_SLOT_LEFTHAND));
        //SetDroppableFlag(oItem,FALSE);
        DelayCommand(0.2f,ExecuteScript("name_color",oItem));
        return;
        }

int iModel;
    switch(Random(12)+1)
        {
        case 1: iModel=11; break;
        case 2: iModel=12; break;
        case 3: iModel=13; break;
        case 4: iModel=21; break;
        case 5: iModel=22; break;
        case 6: iModel=23; break;
        case 7: iModel=31; break;
        case 8: iModel=32; break;
        case 9: iModel=33; break;
        case 10: iModel=41; break;
        case 11: iModel=42; break;
        case 12: iModel=43; break;
        }
if (iSRoll<=4)//large shields
    {
    switch(Random(33)+1)
        {
        case 1: iModel=11; break;
        case 2: iModel=12; break;
        case 3: iModel=13; break;
        case 4: iModel=21; break;
        case 5: iModel=22; break;
        case 6: iModel=23; break;
        case 7: iModel=31; break;
        case 8: iModel=32; break;
        case 9: iModel=33; break;
        case 10: iModel=41; break;
        case 11: iModel=42; break;
        case 12: iModel=43; break;
        case 13: iModel=51; break;
        case 14: iModel=52; break;
        case 15: iModel=53; break;
        case 16: iModel=54; break;
        case 17: iModel=55; break;
        case 18: iModel=56; break;
        case 19: iModel=61; break;
        case 20: iModel=62; break;
        case 21: iModel=63; break;
        case 22: iModel=64; break;
        case 23: iModel=65; break;
        case 24: iModel=66; break;
        case 25: iModel=67; break;
        case 26: iModel=68; break;
        case 27: iModel=69; break;
        case 28: iModel=70; break;
        case 29: iModel=71; break;
        case 30: iModel=72; break;
        case 31: iModel=73; break;
        case 32: iModel=74; break;
        case 33: iModel=75; break;
        }
     }

if (iSRoll==5)//tower shields
    {
    switch(Random(16)+1)
        {
        case 1: iModel=11; break;
        case 2: iModel=12; break;
        case 3: iModel=13; break;
        case 4: iModel=21; break;
        case 5: iModel=22; break;
        case 6: iModel=23; break;
        case 7: iModel=31; break;
        case 8: iModel=32; break;
        case 9: iModel=33; break;
        case 10: iModel=41; break;
        case 11: iModel=42; break;
        case 12: iModel=43; break;
        case 13: iModel=51; break;
        case 14: iModel=52; break;
        case 15: iModel=53; break;
        case 16: iModel=54; break;
        }
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
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
SetLocalInt(oSimple,"itemlevel",iHD);
DestroyObject(oItem);
DelayCommand(2.6f,ActionEquipItem(oSimple,INVENTORY_SLOT_LEFTHAND));
SetLocalInt(oSimple,"itemlevel",iHD);
//SetDroppableFlag(oSimple,FALSE);
//check for spell resistance
if (iHD>=d20(4))
{
DelayCommand(0.0f,ExecuteScript("add_sr",oSimple));
}
//check for damage resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oSimple));
}
//check for immunities
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_immunity",oSimple));
}
//check for saves
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_saves",oSimple));
}
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_damred",oSimple));
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
