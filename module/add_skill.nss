#include "x2_inc_itemprop"

void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
int iSKroll = Random(26);
int iSB = Random(FloatToInt(iHD/2.0f))+3;
if (iSB<=0) iSB=1;
if (iSB>=40) iSB=30;
itemproperty ipSB = ItemPropertySkillBonus(iSKroll,iSB);
string sName = GetName(oItem);
IPSafeAddItemProperty(oItem,ipSB,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
            switch(iSKroll)
                    {
                    case 0:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Animal Friendship "+sName);
                    break;
                    case 1:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Solitude "+sName);
                    break;
                    case 2:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Tinkerer's "+sName);
                    break;
                    case 3:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Disciplined "+sName);
                    break;
                    case 4:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Healer's "+sName);
                    break;
                    case 5:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Stealthy "+sName);
                    break;
                    case 6:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Clairaudent "+sName);
                    break;
                    case 7:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Arcane "+sName);
                    break;
                    case 8:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Swiftfoot "+sName);
                    break;
                    case 9:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Locksmith's "+sName);
                    break;
                    case 10:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Parrying "+sName);
                    break;
                    case 11:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Minstrel's "+sName);
                    break;
                    case 12:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Persuasive "+sName);
                    break;
                    case 13:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Cutpurse's "+sName);
                    break;
                    case 14:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Clairvoyant "+sName);
                    break;
                    case 15:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Trapper's "+sName);
                    break;
                    case 16:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Spellweaver's "+sName);
                    break;
                    case 17:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Keensight "+sName);
                    break;
                    case 18:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Taunting Visage "+sName);
                    break;
                    case 19:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Arcane Manipulation "+sName);
                    break;
                    case 20:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Appraiser's "+sName);
                    break;
                    case 21:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Acrobat's "+sName);
                    break;
                    case 22:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Artificer's "+sName);
                    break;
                    case 23:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Deciever's "+sName);
                    break;
                    case 24:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Intimidating "+sName);
                    break;
                    case 25:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Dwarven Armorsmith's "+sName);
                    break;
                    case 26:
                    if (GetLocalInt(OBJECT_SELF,"dontrename")!=1)SetName(oItem,"Dwarven Weaponsmith's "+sName);
                    break;
                    }
}
