#include "x2_inc_itemprop"


void main()
{
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
int iDamType = Random(8)+5;
int iDamAmt = FloatToInt((iHD*30.0f)/40.0f);
if (iDamAmt<=0) iDamAmt=1;
if (iDamAmt>30) iDamAmt=30;
itemproperty ipDamBon = ItemPropertyDamageBonus(iDamType,Random(iDamAmt)+1);
IPSafeAddItemProperty(OBJECT_SELF,ipDamBon,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
string sNewname = GetName(OBJECT_SELF);
string sSurname;
                switch (iDamType)
                    {
                    case 5:
                    sSurname = "Forceful ";
                    break;
                    case 6:
                    sSurname = "Acidic ";
                    break;
                    case 7:
                    sSurname = "Frostbrand ";
                    break;
                    case 8:
                    sSurname = "Sacred ";
                    break;
                    case 9:
                    sSurname = "Shocking ";
                    break;
                    case 10:
                    sSurname = "Flaming ";
                    break;
                    case 11:
                    sSurname = "Unholy ";
                    break;
                    case 12:
                    sSurname = "Divine ";
                    break;
                    case 13:
                    sSurname = "Screaming ";
                    break;
                    }
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
SetName(OBJECT_SELF,sSurname+sNewname);
}
