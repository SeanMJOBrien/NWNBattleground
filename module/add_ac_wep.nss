#include "x2_inc_itemprop"

void main()
{
int iType = d10();
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(oItem,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;

int iACB = Random(FloatToInt(iHD/(4.0f)))+1;
if (iACB<1) iACB=1;
if (iACB>10) iACB=10;
string sName = GetName(oItem);
if (iType<=8)
{
itemproperty ipACB = ItemPropertyACBonus(iACB);
string sACB = IntToString(iACB);
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sName+": +"+sACB+" Defender");
IPSafeAddItemProperty(oItem,ipACB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}
if (iType==9)
{
itemproperty ipACB = ItemPropertyHaste();
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sName+" : Hastener");
IPSafeAddItemProperty(oItem,ipACB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}
if (iType==10)
{
itemproperty ipACB = ItemPropertyHolyAvenger();
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sName+" : Holy Avenger");
IPSafeAddItemProperty(oItem,ipACB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}
}
