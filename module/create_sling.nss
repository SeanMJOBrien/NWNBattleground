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
object oItem = CreateItemOnObject("sling",OBJECT_SELF);

string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);
if (iHD>=d100())
    {
     itemproperty ipEnch = ItemPropertyAttackBonus(iEnch);
     sName = GetName(oItem);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

     if (iHD>=d100(2))
     {
     string sDam;
     int iDam;
     switch(d10())
        {
        case 1: sDam=" of Endless Projectiles"; iDam=1; break;
        case 2: sDam=" of Raining Fire"; iDam=2; break;
        case 3: sDam=" of Undaunting Frost"; iDam=3; break;
        case 4: sDam=" of Infinite Thunderbolts"; iDam=4; break;
        case 5: sDam=" of Endless Firing +1"; iDam=11; break;
        case 6: sDam=" of Endless Firing +2"; iDam=12; break;
        case 7: sDam=" of Endless Firing +3"; iDam=13; break;
        case 8: sDam=" of Endless Firing +4"; iDam=14; break;
        case 9: sDam=" of Endless Firing +5"; iDam=15; break;
        case 10: sDam=" of Endless Assault"; iDam=1; break;
        }
     itemproperty ipUA = ItemPropertyUnlimitedAmmo(iDam);
     string sName2 = GetName(oItem);
     SetName(oItem,sName2+sDam);
     IPSafeAddItemProperty(oItem,ipUA,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

     int iModel;
    switch(Random(16)+1)
        {
        case 1: iModel=11; break;
        case 2: iModel=12; break;
        case 3: iModel=13; break;
        case 4: iModel=14; break;
        case 5: iModel=21; break;
        case 6: iModel=22; break;
        case 7: iModel=23; break;
        case 8: iModel=24; break;
        case 9: iModel=31; break;
        case 10: iModel=32; break;
        case 11: iModel=33; break;
        case 12: iModel=34; break;
        case 13: iModel=41; break;
        case 14: iModel=42; break;
        case 15: iModel=43; break;
        case 16: iModel=44; break;
        }
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
DestroyObject(oItem);
SetLocalInt(oSimple,"itemlevel",iHD);
DelayCommand(2.1f,ActionEquipItem(oSimple,INVENTORY_SLOT_RIGHTHAND));
SetDroppableFlag(oSimple,FALSE);
ExecuteScript("name_color",oSimple);
return;
     }
}

int iModel;
    switch(Random(16)+1)
        {
        case 1: iModel=11; break;
        case 2: iModel=12; break;
        case 3: iModel=13; break;
        case 4: iModel=14; break;
        case 5: iModel=21; break;
        case 6: iModel=22; break;
        case 7: iModel=23; break;
        case 8: iModel=24; break;
        case 9: iModel=31; break;
        case 10: iModel=32; break;
        case 11: iModel=33; break;
        case 12: iModel=34; break;
        case 13: iModel=41; break;
        case 14: iModel=42; break;
        case 15: iModel=43; break;
        case 16: iModel=44; break;
        }
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
DestroyObject(oItem);
DelayCommand(2.1f,ActionEquipItem(oSimple,INVENTORY_SLOT_RIGHTHAND));
SetLocalInt(oSimple,"itemlevel",iHD);
//SetDroppableFlag(oSimple,FALSE);
ExecuteScript("name_color",oSimple);
ExecuteScript("create_bullets",OBJECT_SELF);
}
