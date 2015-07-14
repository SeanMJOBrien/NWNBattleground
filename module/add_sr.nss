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
int iSRAmt = FloatToInt((iHD*11.0f)/40.0f);
if (iSRAmt<=0) iSRAmt=1;
if (iSRAmt>11) iSRAmt=11;
iSRAmt = Random(iSRAmt)+1;
itemproperty ipACB = ItemPropertyBonusSpellResistance(iSRAmt);
string sSRAmt = "error";
switch (iSRAmt)
    {
    case 1: sSRAmt="12";break;
    case 2: sSRAmt="14";break;
    case 3: sSRAmt="16";break;
    case 4: sSRAmt="18";break;
    case 5: sSRAmt="20";break;
    case 6: sSRAmt="22";break;
    case 7: sSRAmt="24";break;
    case 8: sSRAmt="26";break;
    case 9: sSRAmt="28";break;
    case 10: sSRAmt="30";break;
    case 11: sSRAmt="32";break;
    }
IPSafeAddItemProperty(oItem,ipACB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
SetName(oItem,sName+" (Spell Resistance "+sSRAmt+")");
}
