#include "x2_inc_itemprop"

void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
string sName = GetName(oItem);
int iDR = FloatToInt((iHD*10.0f)/40.0f);
int iSoak = FloatToInt((iHD*10.0f)/40.0f);
if (iDR<=0) iDR=1;
if (iDR>10) iDR=10;
if (iSoak<=0) iSoak=1;
if (iSoak>10) iSoak=10;


itemproperty ipSoak = ItemPropertyDamageReduction(Random(iDR),Random(iSoak)+1);
IPSafeAddItemProperty(oItem,ipSoak,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
SetName(oItem,"Damage Warding "+sName);
}
