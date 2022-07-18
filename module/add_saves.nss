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
int iSaveAmt = FloatToInt((iHD*10.0f)/40.0f);
if (iSaveAmt<=0) iSaveAmt=1;
if (iSaveAmt>10) iSaveAmt=10;
int iType;
string sSname;
itemproperty ipSave;

switch(d20())
        {
        case 1:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,Random(iSaveAmt)+1);
        sSname = "Resilient ";
        break;
        case 2:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,Random(iSaveAmt)+1);
        sSname = "Agile ";
        break;
        case 3:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,Random(iSaveAmt)+1);
        sSname = "Ironwill ";
        break;
        case 4:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,Random(iSaveAmt)+1);
        sSname = "Acid Protection ";
        break;
        case 5:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,Random(iSaveAmt)+1);
        sSname = "Frost Protection ";
        break;
        case 6:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,Random(iSaveAmt)+1);
        sSname = "Lifekeeper ";
        break;
        case 7:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE,Random(iSaveAmt)+1);
        sSname = "Medicinal ";
        break;
        case 8:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,Random(iSaveAmt)+1);
        sSname = "Unholy ";
        break;
        case 9:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,Random(iSaveAmt)+1);
        sSname = "Grounded ";
        break;
        case 10:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,Random(iSaveAmt)+1);
        sSname = "Braveheart ";
        break;
        case 11:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,Random(iSaveAmt)+1);
        sSname = "Fireshield ";
        break;
        case 12:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,Random(iSaveAmt)+1);
        sSname = "Freewill ";
        break;
        case 13:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,Random(iSaveAmt)+1);
        sSname = "Holy ";
        break;
        case 14:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,Random(iSaveAmt)+1);
        sSname = "Antivenin ";
        break;
        case 15:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,Random(iSaveAmt)+1);
        sSname = "Dampening ";
        break;
        case 16:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,Random(iSaveAmt)+1);
        sSname = "Universal Protection ";
        break;
        case 17:
        ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,Random(iSaveAmt)+1);
        sSname = "Proof Against Poison ";
        break;
        case 18:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,Random(iSaveAmt)+1);
        sSname = "Great Fortitude ";
        break;
        case 19:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,Random(iSaveAmt)+1);
        sSname = "Great Reflexes ";
        break;
        case 20:
        ipSave = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,Random(iSaveAmt)+1);
        sSname = "Great Willpower ";
        break;
        }



IPSafeAddItemProperty(oItem,ipSave,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sSname+sName);
}
