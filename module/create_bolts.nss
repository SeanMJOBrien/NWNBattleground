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
int iOnhitRoll = d100(2);

object oItem = CreateItemOnObject("bolt1",OBJECT_SELF,50);


            if (iHD>=d100())
                {
                int iDamType = Random(9)+5;
                if (iDamType==14) iDamType = 1;
                int iDamAmt = FloatToInt((iHD*30.0f)/40.0f);
                if (iDamAmt<=0) iDamAmt=1;
                if (iDamAmt>30) iDamAmt=30;
                itemproperty ipDamBon = ItemPropertyDamageBonus(iDamType,Random(iDamAmt)+1);
                IPSafeAddItemProperty(oItem,ipDamBon,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                string sNewname = GetName(oItem);
                string sSurname;
                switch (iDamType)
                    {
                    case 5:
                    sSurname = "Arcane Destruction ";
                    break;
                    case 6:
                    sSurname = "Acidity ";
                    break;
                    case 7:
                    sSurname = "Frost ";
                    break;
                    case 8:
                    sSurname = "Smiting ";
                    break;
                    case 9:
                    sSurname = "Lightning ";
                    break;
                    case 10:
                    sSurname = "Fire ";
                    break;
                    case 11:
                    sSurname = "Death ";
                    break;
                    case 12:
                    sSurname = "Pure Energy ";
                    break;
                    case 13:
                    sSurname = "Shrieking ";
                    break;
                    case 14:
                    sSurname = "Armor Piercing ";
                    break;
                    }
                    SetName(oItem,sSurname+sNewname);
                }
                if (iOnhitRoll<=iHD)
                    {
                     ExecuteScript("add_onhit",oItem);
                    }
                if (iHD>=d100())
                    {
                     int iRegenAmt = Random(FloatToInt(iHD/2.0f));
                     if (iRegenAmt<=0) iRegenAmt=1;
                     if (iRegenAmt>20) iRegenAmt=20;
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     string sName2 = GetName(oItem);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                     SetName(oItem,"Vampiric "+sName2);
                    }




int iRandom = Random(3)+1;
object oRecolor = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,d3(),TRUE);
DestroyObject(oItem);
object oRecolor2 = CopyItemAndModify(oRecolor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,d3(),TRUE);
DestroyObject(oRecolor);
object oRecolor3 = CopyItemAndModify(oRecolor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,d3(),TRUE);
DestroyObject(oRecolor2);
object oRemake = CopyItemAndModify(oRecolor3,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,iRandom,TRUE);
DestroyObject(oRecolor3);
object oRemake2 = CopyItemAndModify(oRemake,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,iRandom,TRUE);
DestroyObject(oRemake);
object oFinal = CopyItemAndModify(oRemake2,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,iRandom,TRUE);
DestroyObject(oRemake2);
SetLocalInt(oFinal,"itemlevel",iHD);
SetItemStackSize(oFinal,d20()+5);
ExecuteScript("name_color",oFinal);
DelayCommand(2.9f,ActionEquipItem(oFinal,INVENTORY_SLOT_BOLTS));
//SetDroppableFlag(oFinal,FALSE);
SetLocalInt(oFinal,"itemlevel",iHD);
}
