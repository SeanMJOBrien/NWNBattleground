#include "x2_inc_itemprop"

void main()
{
object oOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
DestroyObject(oOld,0.0f);
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////
object oItem = CreateItemOnObject("mstaff",OBJECT_SELF);
string sName = GetName(oItem);
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
string sEnch = IntToString(iEnch);
int iKeen = d100()+iHD;
if (iKeen>=110)
    {
     itemproperty ipKeen = ItemPropertyKeen();
     IPSafeAddItemProperty(oItem,ipKeen,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     SetName(oItem,"Keen "+sName);
     }
int iLevel = iHD+d20();
int iTimes = iHD+d20();
int iUses;

if (iTimes<=14) iUses = 2;
if (iTimes>=15&&iTimes<=22) iUses = 3;
if (iTimes>=23&&iTimes<=28) iUses = 4;
if (iTimes>=29&&iTimes<=34) iUses = 5;
if (iTimes>=35&&iTimes<=39) iUses = 6;
if (iTimes>=40&&iTimes<=45) iUses = 8;
if (iTimes>=46&&iTimes<=51) iUses = 9;
if (iTimes>=52&&iTimes<=54) iUses = 10;
if (iTimes>=55&&iTimes<=57) iUses = 11;
if (iTimes>=58) iUses = 12;
//if (iTimes==60) iUses = 13;//no unlimited uses

int iSpell;

switch(iLevel)
        {
        case 2: iSpell=163; break;
        case 3: iSpell=1; break;
        case 4: iSpell=172; break;
        case 5: iSpell=11; break;
        case 6: iSpell=147; break;
        case 7: iSpell=167; break;
        case 8: iSpell=66; break;
        case 9: iSpell=76; break;
        case 10: iSpell=67; break;
        case 11: iSpell=263; break;
        case 12: iSpell=251; break;
        case 13: iSpell=154; break;
        case 14: iSpell=18; break;
        case 15: iSpell=49; break;
        case 16: iSpell=140; break;
        case 17: iSpell=265; break;
        case 18: iSpell=474; break;
        case 19: iSpell=75; break;
        case 20: iSpell=108; break;
        case 21: iSpell=69; break;
        case 22: iSpell=70; break;
        case 23: iSpell=281; break;
        case 24: iSpell=464; break;
        case 25: iSpell=77; break;
        case 26: iSpell=16; break;
        case 27: iSpell=26; break;
        case 28: iSpell=96; break;
        case 29: iSpell=289; break;
        case 30: iSpell=292; break;
        case 31: iSpell=295; break;
        case 32: iSpell=477; break;
        case 33: iSpell=193; break;
        case 34: iSpell=174; break;
        case 35: iSpell=186; break;
        case 36: iSpell=7; break;
        case 37: iSpell=28; break;
        case 38: iSpell=196; break;
        case 39: iSpell=275; break;
        case 40: iSpell=205; break;
        case 41: iSpell=390; break;
        case 42: iSpell=270; break;
        case 43: iSpell=312; break;
        case 44: iSpell=297; break;
        case 45: iSpell=298; break;
        case 46: iSpell=299; break;
        case 47: iSpell=300; break;
        case 48: iSpell=301; break;
        case 49: iSpell=302; break;
        case 50: iSpell=391; break;
        case 51: iSpell=378; break;
        case 52: iSpell=282; break;
        case 53: iSpell=392; break;
        case 54: iSpell=310; break;
        case 55: iSpell=393; break;
        case 56: iSpell=394; break;
        case 57: iSpell=394; break;
        case 58: iSpell=308; break;
        case 59: iSpell=379; break;
        case 60: iSpell=530; break;
        }

itemproperty ipSpell = ItemPropertyCastSpell(iSpell,iUses);
IPSafeAddItemProperty(oItem,ipSpell,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
if (iHD>=d100())
    {
     itemproperty ipEnch = ItemPropertyEnhancementBonus(iEnch);
     sName = GetName(oItem);
     SetName(oItem,"+"+sEnch+" "+sName);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     int iDBRoll = d100();
            if (iDBRoll<=iHD)
                {
                int iDamType = Random(8)+5;
                int iDamAmt = FloatToInt((iHD*30.0f)/40.0f);
                if (iDamAmt<=0) iDamAmt=1;
                if (iDamAmt>30) iDamAmt=30;
                itemproperty ipDamBon = ItemPropertyDamageBonus(iDamType,Random(iDamAmt)+1);
                IPSafeAddItemProperty(oItem,ipDamBon,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                string sNewname = GetName(oItem);
                string sSurname;
                switch (iDamType)
                    {
                    case 5:
                    sSurname = " of Forceful Strikes";
                    break;
                    case 6:
                    sSurname = " of Acidic Torment";
                    break;
                    case 7:
                    sSurname = " of Icy Death";
                    break;
                    case 8:
                    sSurname = " of Divine Fury";
                    break;
                    case 9:
                    sSurname = " of Shocking Power";
                    break;
                    case 10:
                    sSurname = " of Flaming Devastation";
                    break;
                    case 11:
                    sSurname = " of Unholy Draining";
                    break;
                    case 12:
                    sSurname = " of Holy Smiting";
                    break;
                    case 13:
                    sSurname = " of Wailing Destruction";
                    break;
                    }
                    SetName(oItem,sNewname+sSurname);
                }
                if (iHD>=d100())
                    {
                     int iRegenAmt = Random(FloatToInt(iHD/2.0f));
                     if (iRegenAmt<=0) iRegenAmt=1;
                     if (iRegenAmt>20) iRegenAmt=20;
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     string sName2 = GetName(oItem);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                     SetName(oItem,"Vampiric "+sName2);
                    }
                if (iHD<=d100())
     {
     itemproperty ipAC = ItemPropertyACBonus(iEnch);
     sName = GetName(oItem);
     SetName(oItem,sName+" : Protector");
     IPSafeAddItemProperty(oItem,ipAC,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     }
    }
object oRecolor = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,d4(),TRUE);
DestroyObject(oItem);
object oRecolor2 = CopyItemAndModify(oRecolor,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,d4(),TRUE);
DestroyObject(oRecolor);
object oRecolor3 = CopyItemAndModify(oRecolor2,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,d4(),TRUE);
DestroyObject(oRecolor2);
object oRemake = CopyItemAndModify(oRecolor3,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,Random(6)+1,TRUE);
DestroyObject(oRecolor3);
object oRemake2 = CopyItemAndModify(oRemake,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,Random(6)+1,TRUE);
DestroyObject(oRemake);
object oFinal = CopyItemAndModify(oRemake2,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,Random(6)+1,TRUE);
DestroyObject(oRemake2);
SetLocalInt(oFinal,"itemlevel",iHD);
SetIdentified(oFinal,TRUE);
DelayCommand(5.9f,ActionEquipItem(oFinal,INVENTORY_SLOT_RIGHTHAND));
SetDroppableFlag(oFinal,TRUE);
DelayCommand(0.2f,ExecuteScript("name_color",oFinal));
}
