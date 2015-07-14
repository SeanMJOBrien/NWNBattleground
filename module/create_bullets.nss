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

object oItem = CreateItemOnObject("bullets",OBJECT_SELF,40);


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




int iModel;

    switch(d4())
        {
        case 1: iModel=10+d3(); break;
        case 2: iModel=20+d3(); break;
        case 3: iModel=30+d3(); break;
        case 4: iModel=40+d3(); break;
        }

object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
DestroyObject(oItem);

DelayCommand(2.6f,ActionEquipItem(oSimple,INVENTORY_SLOT_BULLETS));
//SetDroppableFlag(oSimple,FALSE);
SetItemStackSize(oSimple,d20()+12);
SetLocalInt(oSimple,"itemlevel",iHD);
ExecuteScript("name_color",oSimple);
}
