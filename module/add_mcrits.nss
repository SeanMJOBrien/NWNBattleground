#include "x2_inc_itemprop"

void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
int iDamAmt = FloatToInt((iHD*30.0f)/40.0f);
if (iDamAmt<=0) iDamAmt=1;
if (iDamAmt>30) iDamAmt=30;
itemproperty ipACB = ItemPropertyMassiveCritical(Random(iDamAmt)+1);
IPSafeAddItemProperty(oItem,ipACB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}
