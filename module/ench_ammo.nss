#include "x2_inc_itemprop"
void main()
{
//prelim code for enchanting
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
if (iHD<=0) iHD=1;
if (iHD>=40) iHD=40;
int iDamType = Random(9)+5;
if (iDamType==14) iDamType = 1;
int iDamAmt = FloatToInt((iHD*30.0f)/40.0f);
if (iDamAmt<=0) iDamAmt=1;
if (iDamAmt>30) iDamAmt=30;
itemproperty ipDamBon = ItemPropertyDamageBonus(iDamType,Random(iDamAmt)+1);
IPSafeAddItemProperty(oItem,ipDamBon,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                if (d100()<=iHD)//add onhit if necessary
                    {
                     ExecuteScript("add_onhit",oItem);
                    }
                if (iHD>=d100())
                    {
                     int iRegenAmt = Random(FloatToInt(iHD/2.0f));
                     if (iRegenAmt<=0) iRegenAmt=1;
                     if (iRegenAmt>20) iRegenAmt=20;
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                     //SetName(oItem,"Vampiric "+sName2);
                    }
}
