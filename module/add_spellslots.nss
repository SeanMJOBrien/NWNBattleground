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
int iBSAmt = FloatToInt((iHD*9.0f)/40.0f);
if (iBSAmt<0) iBSAmt=0;
if (iBSAmt>9) iBSAmt=9;
int iClass;
string sPname;

switch(d10())
        {
        case 1:
        iClass = IP_CONST_CLASS_BARD;
        sPname = "Bardic ";
        break;
        case 2:
        iClass = IP_CONST_CLASS_CLERIC;
        sPname = "Cleric's ";
        break;
        case 3:
        iClass = IP_CONST_CLASS_DRUID;
        sPname = "Druidic ";
        break;
        case 4:
        iClass = IP_CONST_CLASS_PALADIN;
        sPname = "Righteous ";
        break;
        case 5:
        iClass = IP_CONST_CLASS_RANGER;
        sPname = "Ranger's ";
        break;
        case 6:
        iClass = IP_CONST_CLASS_SORCERER;
        sPname = "Sorcerer's ";
        break;
        case 7:
        iClass = IP_CONST_CLASS_SORCERER;
        sPname = "Sorcerer's ";
        break;
        case 8:
        iClass = IP_CONST_CLASS_WIZARD;
        sPname = "Wizard's ";
        break;
        case 9:
        iClass = IP_CONST_CLASS_WIZARD;
        sPname = "Wizard's ";
        break;
        case 10:
        iClass = IP_CONST_CLASS_WIZARD;
        sPname = "Wizard's ";
        break;
        }


itemproperty ipBS = ItemPropertyBonusLevelSpell(iClass,Random(iBSAmt));
IPSafeAddItemProperty(oItem,ipBS,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sPname+sName);
}
