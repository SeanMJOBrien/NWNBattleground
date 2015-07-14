#include "x2_inc_itemprop"


void main()
{
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
int iDamType = Random(8)+5;
int iDamAmt = FloatToInt((iHD*10.0f)/40.0f);
if (iDamAmt<=0) iDamAmt=1;
if (iDamAmt>10) iDamAmt=10;
itemproperty ipDamRes = ItemPropertyDamageResistance(iDamType,Random(iDamAmt)+1);
IPSafeAddItemProperty(OBJECT_SELF,ipDamRes,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
string sNewname = GetName(OBJECT_SELF);
string sSurname;
                switch (iDamType)
                    {
                    case 5:
                    sSurname = "Magicward ";
                    break;
                    case 6:
                    sSurname = "Acidproof ";
                    break;
                    case 7:
                    sSurname = "Insulating ";
                    break;
                    case 8:
                    sSurname = "Profane ";
                    break;
                    case 9:
                    sSurname = "Disrupting ";
                    break;
                    case 10:
                    sSurname = "Flameward ";
                    break;
                    case 11:
                    sSurname = "Blightward ";
                    break;
                    case 12:
                    sSurname = "Lifewarded ";
                    break;
                    case 13:
                    sSurname = "Silencing ";
                    break;
                    }
SetName(OBJECT_SELF,sSurname+sNewname);
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
}
