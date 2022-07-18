#include "x2_inc_itemprop"

void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(oItem,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
string sName = GetName(oItem);
int iAbilAmt = FloatToInt((iHD*12.0f)/40.0f);
if (iAbilAmt<1) iAbilAmt = 1;
if (iAbilAmt>12) iAbilAmt = 12;
int iAbil;
string sSName;

switch (d6())
        {
        case 1:
        iAbil = IP_CONST_ABILITY_CHA;
        sSName = " of Charisma";
        break;
        case 2:
        iAbil = IP_CONST_ABILITY_WIS;
        sSName = " of Wisdom";
        break;
        case 3:
        iAbil = IP_CONST_ABILITY_INT;
        sSName = " of Intelligence";
        break;
        case 4:
        iAbil = IP_CONST_ABILITY_DEX;
        sSName = " of Dexterity";
        break;
        case 5:
        iAbil = IP_CONST_ABILITY_STR;
        sSName = " of Strength";
        break;
        case 6:
        iAbil = IP_CONST_ABILITY_CON;
        sSName = " of Constitution";
        break;
        }

itemproperty ipAbil = ItemPropertyAbilityBonus(iAbil,Random(iAbilAmt)+1);
IPSafeAddItemProperty(oItem,ipAbil,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
SetName(oItem,sName+sSName);
}
