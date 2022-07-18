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
int iType = Random(3)+1;
string sResref;
int iModel;
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
        }
switch(iType)
        {
        case 1: sResref="thaxe"; break;
        case 2: sResref="basedart"; break;
        case 3: sResref="tstar"; break;
        }
object oItem = CreateItemOnObject(sResref,OBJECT_SELF,20);
string sName = GetName(oItem);

            if (iHD>=d100())
     {
     int iEnch = Random(FloatToInt(iHD/2.0f))+1;
     if (iEnch<=0) iEnch=1;
     if (iEnch>20) iEnch=20;
     string sEnch = IntToString(iEnch);
     itemproperty ipEnch = ItemPropertyEnhancementBonus(iEnch);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     }

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
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     string sName2 = GetName(oItem);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                     SetName(oItem,"Vampiric "+sName2);
                    }

if (iType==1)
{
object oRecolor = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,d4(),TRUE);
DestroyObject(oItem);
object oRecolor2 = CopyItemAndModify(oRecolor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,d4(),TRUE);
DestroyObject(oRecolor);
object oRecolor3 = CopyItemAndModify(oRecolor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,d4(),TRUE);
DestroyObject(oRecolor2);
object oRemake = CopyItemAndModify(oRecolor3,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,iModel,TRUE);
DestroyObject(oRecolor3);
object oRemake2 = CopyItemAndModify(oRemake,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,iModel,TRUE);
DestroyObject(oRemake);
object oFinal = CopyItemAndModify(oRemake2,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,iModel,TRUE);
DestroyObject(oRemake2);
SetLocalInt(oFinal,"itemlevel",iHD);
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
SetItemStackSize(oFinal,20);

}
if (iType==2||iType==3)
{
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
DestroyObject(oItem);
SetItemStackSize(oSimple,20);
SetLocalInt(oSimple,"itemlevel",iHD);
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
}
