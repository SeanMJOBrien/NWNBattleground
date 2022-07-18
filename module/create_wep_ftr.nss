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


int iMax = 20;
int iKind = Random(iMax)+1;
int iModMax;
string sResref;
int iShld;


switch (iKind)
{
    case 1:
    sResref = "rapier";
    iModMax = 4;
    iShld = 1;
    break;
    case 2:
    sResref = "lsword";
    iModMax = 8;
    iShld = 1;
    break;
    case 3:
    sResref = "katana";
    iModMax = 4;
    iShld = 0;
    break;
    case 4:
    sResref = "gsword";
    iModMax = 6;
    iShld = 0;
    break;
    case 5:
    sResref = "bsword";
    iModMax = 6;
    iShld = 0;
    break;
    case 6:
    sResref = "bsword";
    iModMax = 6;
    iShld = 1;
    break;
    case 7:
    sResref = "lsword";
    iModMax = 8;
    iShld = 1;
    break;
    case 8:
    sResref = "scythe";
    iModMax = 3;
    iShld = 0;
    break;
    case 9:
    sResref = "spear";
    iModMax = 4;
    iShld = 0;
    break;
    case 10:
    sResref = "qstaff";
    iModMax = 4;
    iShld = 0;
    break;
    case 11:
    sResref = "halberd";
    iModMax = 4;
    iShld = 0;
    break;
    case 12:
    sResref = "2sword";
    iModMax = 3;
    iShld = 0;
    break;
    case 13:
    sResref = "scimitar";
    iModMax = 5;
    iShld = 1;
    break;
    case 14:
    sResref = "hflail";
    iModMax = 4;
    iShld = 0;
    break;
    case 15:
    sResref = "greataxe";
    iModMax = 4;
    iShld = 0;
    break;
    case 16:
    sResref = "diremace";
    iModMax = 4;
    iShld = 0;
    break;
    case 17:
    sResref = "warhammer";
    iModMax = 6;
    iShld = 1;
    break;
    case 18:
    sResref = "mstar";
    iModMax = 4;
    iShld = 1;
    break;
    case 19:
    sResref = "battleaxe";
    iModMax = 6;
    iShld = 1;
    break;
    case 20:
    sResref = "dwaraxe";
    iModMax = 6;
    iShld = 0;
    break;
}

if (iShld==1&&GetObjectType(OBJECT_SELF)==OBJECT_TYPE_CREATURE) DelayCommand(0.0f,ExecuteScript("create_shield",OBJECT_SELF));

object oItem = CreateItemOnObject(sResref,OBJECT_SELF);

string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);
//adds keen if roll is made
int iKeen = d100()+iHD;
if (iKeen>=100)
    {
     itemproperty ipKeen = ItemPropertyKeen();
     IPSafeAddItemProperty(oItem,ipKeen,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     SetName(oItem,"Keen "+sName);
     }


//adds enhancement bonus
if (iHD>=d100())
    {
     itemproperty ipEnch = ItemPropertyEnhancementBonus(iEnch);
     sName = GetName(oItem);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                if (iHD>=d100(2))//chance to add vamp regen
                    {
                     int iRegenAmt = Random(FloatToInt(iHD/2.0f));
                     if (iRegenAmt<=0) iRegenAmt=1;
                     if (iRegenAmt>20) iRegenAmt=20;
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     string sName2 = GetName(oItem);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                     SetName(oItem,"Vampiric "+sName2);
                    }
                 if (d100()<=30)//chance to add light
                    {
                     int iColor = Random(7);
                     itemproperty ipLight = ItemPropertyLight(Random(4),iColor);
                     IPSafeAddItemProperty(oItem,ipLight,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
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
SetLocalInt(oFinal,"itemlevel",iHD);
DelayCommand(2.2f,ActionEquipItem(oFinal,INVENTORY_SLOT_RIGHTHAND));

//SetDroppableFlag(oFinal,FALSE);

//check for adding damage bonus
if (iHD>=d20(4))
{
DelayCommand(0.0f,ExecuteScript("add_damage",oFinal));
}
//check for onhit props
if (iHD>=d100(2))
{
ExecuteScript("add_onhit",oFinal);
}
//check for special props
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_ac_wep",oFinal));
}
//check for massive crits
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_mcrits",oFinal));
}
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
