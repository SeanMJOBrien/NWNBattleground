#include "x2_inc_itemprop"

void main()
{
object oOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
DestroyObject(oOld,0.0f);
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////

int iModMax;
string sResref;

switch (d4())
    {
    case 1:
    sResref = "longbow";
    iModMax = 8;
    break;
    case 2:
    sResref = "longbow";
    iModMax = 8;
    break;
    case 3:
    sResref = "longbow";
    iModMax = 8;
    break;
    case 4:
    sResref = "shortbow";
    iModMax = 6;
    break;
    }

object oItem = CreateItemOnObject(sResref,OBJECT_SELF);

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

     if(iHD>=d100())
        {
         int iMight = FloatToInt(iEnch/4.0f);
         if (iMight<=0) iMight=1;
         if (iMight>10) iMight=10;
         itemproperty ipMighty = ItemPropertyMaxRangeStrengthMod(iMight);
         string sNewName = GetName(oItem);
         SetName(oItem,"Composite "+sNewName);
         IPSafeAddItemProperty(oItem,ipMighty,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
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
     int iRandom = Random(iModMax)+1;
     object oRecolor = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,d4(),TRUE);
     DestroyObject(oItem);
     object oRecolor2 = CopyItemAndModify(oRecolor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,d4(),TRUE);
     DestroyObject(oRecolor);
     object oRecolor3 = CopyItemAndModify(oRecolor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,d4(),TRUE);
     DestroyObject(oRecolor2);
     object oRemake = CopyItemAndModify(oRecolor3,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,iRandom,TRUE);
     DestroyObject(oRecolor3);
     object oRemake2 = CopyItemAndModify(oRemake,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,iRandom,TRUE);
     DestroyObject(oRemake);
     object oFinal = CopyItemAndModify(oRemake2,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,iRandom,TRUE);
     DestroyObject(oRemake2);
     DelayCommand(2.7f,ActionEquipItem(oFinal,INVENTORY_SLOT_RIGHTHAND));
     SetDroppableFlag(oFinal,FALSE);
     SetLocalInt(oFinal,"itemlevel",iHD);
     ExecuteScript("name_color",oFinal);
     return;
     }
     }

int iRandom = Random(iModMax)+1;
object oRecolor = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,d4(),TRUE);
DestroyObject(oItem);
object oRecolor2 = CopyItemAndModify(oRecolor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,d4(),TRUE);
DestroyObject(oRecolor);
object oRecolor3 = CopyItemAndModify(oRecolor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,d4(),TRUE);
DestroyObject(oRecolor2);
object oRemake = CopyItemAndModify(oRecolor3,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,iRandom,TRUE);
DestroyObject(oRecolor3);
object oRemake2 = CopyItemAndModify(oRemake,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,iRandom,TRUE);
DestroyObject(oRemake);
object oFinal = CopyItemAndModify(oRemake2,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,iRandom,TRUE);
DestroyObject(oRemake2);
DelayCommand(2.7f,ActionEquipItem(oFinal,INVENTORY_SLOT_RIGHTHAND));
SetLocalInt(oFinal,"itemlevel",iHD);
ExecuteScript("name_color",oFinal);
//SetDroppableFlag(oFinal,FALSE);
ExecuteScript("create_arrows",OBJECT_SELF);
}
