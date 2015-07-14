#include "x2_inc_itemprop"

void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
if (iHD<=9) return;
string sName = GetName(oItem);
string sSName;
int iImm;

switch (d10())
        {
        case 1:
        iImm = IP_CONST_IMMUNITYMISC_BACKSTAB;
        sSName = "Awareness ";
        break;
        case 2:
        iImm = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;
        sSName = "Fortification ";
        break;
        case 3:
        iImm = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
        sSName = "Death Ward ";
        break;
        case 4:
        iImm = IP_CONST_IMMUNITYMISC_DISEASE;
        sSName = "Disease Immunity ";
        break;
        case 5:
        iImm = IP_CONST_IMMUNITYMISC_FEAR;
        sSName = "Courageous ";
        break;
        case 6:
        iImm = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
        sSName = "Surefooted ";
        break;
        case 7:
        iImm = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;
        sSName = "Stoic ";
        break;
        case 8:
        iImm = IP_CONST_IMMUNITYMISC_MINDSPELLS;
        sSName = "Clarity ";
        break;
        case 9: IP_CONST_IMMUNITYMISC_PARALYSIS;
        sSName = "Undaunting ";
        break;
        case 10:
        iImm = IP_CONST_IMMUNITYMISC_POISON;
        sSName = "Venomward ";
        break;
        }

itemproperty ipImm = ItemPropertyImmunityMisc(iImm);
IPSafeAddItemProperty(oItem,ipImm,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")==1) return;
SetName(oItem,sSName+sName);
}
