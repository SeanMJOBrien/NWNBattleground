#include "x2_inc_itemprop"


void main()
{
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"itemlevel");
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate);
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
int iRoll1 =  Random(37)+1;
int iType;
int iSaveDC;

int iRollS = d100()+iHD;
if (iRollS<=40) iSaveDC = 0;
if (iRollS<=41&&iRollS<=66) iSaveDC = 1;
if (iRollS<=67&&iRollS<=90) iSaveDC = 2;
if (iRollS<=91&&iRollS<=100) iSaveDC = 3;
if (iRollS<=101&&iRollS<=120) iSaveDC = 4;
if (iRollS<=121&&iRollS<=133) iSaveDC = 5;
if (iRollS>=134) iSaveDC = 6;

string sName = GetName(oItem);
string sPname;


switch (iRoll1)
        {
        case 1:
        iType = IP_CONST_ONHIT_ABILITYDRAIN;
        sPname = " (Leech)";
        break;
        case 2:
        iType = IP_CONST_ONHIT_BLINDNESS;
        sPname = " (Nightbringer)";
        break;
        case 3:
        iType = IP_CONST_ONHIT_CONFUSION;
        sPname = " (Mindwhip)";
        break;
        case 4:
        iType = IP_CONST_ONHIT_DAZE;
        sPname = " (Bedazzler)";
        break;
        case 5:
        iType = IP_CONST_ONHIT_DEAFNESS;
        sPname = " (Clamorer)";
        break;
        case 6:
        iType = IP_CONST_ONHIT_DISEASE;
        sPname = " (Befouler)";
        break;
        case 7:
        iType = IP_CONST_ONHIT_DISPELMAGIC;
        sPname = " (Spellstripper)";
        break;
        case 8:
        iType = IP_CONST_ONHIT_DOOM;
        sPname = " of Doom";
        break;
        case 9:
        iType = IP_CONST_ONHIT_FEAR;
        sPname = " (Terrorizer)";
        break;
        case 10:
        iType = IP_CONST_ONHIT_GREATERDISPEL;
        sPname = " (Great Nullifier)";
        break;
        case 11:
        iType = IP_CONST_ONHIT_HOLD;
        sPname = " (Paralyzer)";
        break;
        case 12:
        iType = IP_CONST_ONHIT_ITEMPOISON;
        sPname = " of Venom";
        break;
        case 13:
        iType = IP_CONST_ONHIT_KNOCK;
        sPname = " (Foundation)";
        break;
        case 14:
        iType = IP_CONST_ONHIT_LESSERDISPEL;
        sPname = " (Nullifier)";
        break;
        case 15:
        iType = IP_CONST_ONHIT_LEVELDRAIN;
        sPname = " (Souldrainer)";
        break;
        case 16:
        iType = IP_CONST_ONHIT_MORDSDISJUNCTION;
        sPname = " of Disjunction";
        break;
        case 17:
        iType = IP_CONST_ONHIT_SILENCE;
        sPname = " (Silencer)";
        break;
        case 18:
        iType = IP_CONST_ONHIT_SLAYALIGNMENT;
        sPname = " of Slaying";
        break;
        case 19:
        iType = IP_CONST_ONHIT_SLAYALIGNMENTGROUP;
        sPname = " of Slaying";
        break;
        case 20:
        iType = IP_CONST_ONHIT_SLAYRACE;
        sPname = " of Slaying";
        break;
        case 21:
        iType = IP_CONST_ONHIT_SLEEP;
        sPname = " (Sandman)";
        break;
        case 22:
        iType = IP_CONST_ONHIT_SLOW;
        sPname = " (Congealer)";
        break;
        case 23:
        iType = IP_CONST_ONHIT_STUN;
        sPname = " (Mindhalter)";
        break;
        case 24:
        iType = IP_CONST_ONHIT_VORPAL;
        sPname = " (Vorpal!)";
        break;
        case 25:
        iType = IP_CONST_ONHIT_WOUNDING;
        sPname = " (Wounding)";
        break;
        case 26:
        iType = IP_CONST_ONHIT_CASTSPELL_ACID_SPLASH;
        sPname = " (Digester)";
        break;
        case 27:
        iType = IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE;
        sPname = " (Hexer)";
        break;
        case 28:
        iType = IP_CONST_ONHIT_CASTSPELL_COMBUST;
        sPname = " (Conflagrator)";
        break;
        case 29:
        iType = IP_CONST_ONHIT_CASTSPELL_DESTRUCTION;
        sPname = " (Imploder)";
        break;
        case 30:
        iType = IP_CONST_ONHIT_CASTSPELL_ELECTRIC_JOLT;
        sPname = " (Discharger)";
        break;
        case 31:
        iType = IP_CONST_ONHIT_CASTSPELL_FEEBLEMIND;
        sPname = " (Mindwaster)";
        break;
        case 32:
        iType = IP_CONST_ONHIT_CASTSPELL_FLESH_TO_STONE;
        sPname = " (Petrifier)";
        break;
        case 33:
        iType = IP_CONST_ONHIT_CASTSPELL_INFLICT_SERIOUS_WOUNDS;
        sPname = " (Lacerator)";
        break;
        case 34:
        iType = IP_CONST_ONHIT_CASTSPELL_PHANTASMAL_KILLER;
        sPname = " (Reaper)";
        break;
        case 35:
        iType = IP_CONST_ONHIT_CASTSPELL_SCARE;
        sPname = " (Tormentor)";
        break;
        case 36:
        iType = IP_CONST_ONHIT_CASTSPELL_SOUND_BURST;
        sPname = " (Earsplitter)";
        break;
        case 37:
        iType = IP_CONST_ONHIT_CASTSPELL_ONHIT_PLANARRIFT;
        sPname = " (Planar Rift)";
        break;
        }

if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(oItem,sName+sPname);

if (iType==1)
    {
    int iAbil = Random(6);
    itemproperty ipAbDrain = ItemPropertyOnHitProps(iType,iSaveDC,iAbil);
    IPSafeAddItemProperty(oItem,ipAbDrain,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==2||iType==3||iType==4||iType==5||iType==8||iType==9||iType==11||iType==17||
iType==21||iType==22||iType==23)
    {
    int iDur = Random(5);
    itemproperty ipBang = ItemPropertyOnHitProps(iType,iSaveDC,iDur);
    IPSafeAddItemProperty(oItem,ipBang,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==6)
    {
    int iDis = Random(17);
    itemproperty ipDisease = ItemPropertyOnHitProps(iType,iSaveDC,iDis);
    IPSafeAddItemProperty(oItem,ipDisease,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==12)
    {
    int iPois = Random(6);
    itemproperty ipPoison = ItemPropertyOnHitProps(iType,iSaveDC,iPois);
    IPSafeAddItemProperty(oItem,ipPoison,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==13||iType==7||iType==10||iType==14||iType==15||iType==16||iType==24||iType==25)
    {
    itemproperty ipBoom = ItemPropertyOnHitProps(iType,iSaveDC);
    IPSafeAddItemProperty(oItem,ipBoom,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==18)
    {
    int iAlign = Random(9);
    itemproperty ipSlayA = ItemPropertyOnHitProps(iType,iSaveDC,iAlign);
    IPSafeAddItemProperty(oItem,ipSlayA,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==19)
    {
    int iAlignGrp = Random(5)+1;
    itemproperty ipSlayAG = ItemPropertyOnHitProps(iType,iSaveDC,iAlignGrp);
    IPSafeAddItemProperty(oItem,ipSlayAG,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType==20)
    {
    int iRaceRoll = Random(24);
    int iRace;
        switch (iRaceRoll)
                {
                case 0:
                iRace = IP_CONST_RACIALTYPE_UNDEAD;
                break;
                case 1:
                iRace = IP_CONST_RACIALTYPE_UNDEAD;
                break;
                case 2:
                iRace = IP_CONST_RACIALTYPE_CONSTRUCT;
                break;
                case 3:
                iRace = IP_CONST_RACIALTYPE_DRAGON;
                break;
                case 4:
                iRace = IP_CONST_RACIALTYPE_DWARF;
                break;
                case 5:
                iRace = IP_CONST_RACIALTYPE_ELEMENTAL;
                break;
                case 6:
                iRace = IP_CONST_RACIALTYPE_ELF;
                break;
                case 7:
                iRace = IP_CONST_RACIALTYPE_FEY;
                break;
                case 8:
                iRace = IP_CONST_RACIALTYPE_GIANT;
                break;
                case 9:
                iRace = IP_CONST_RACIALTYPE_GNOME;
                break;
                case 10:
                iRace = IP_CONST_RACIALTYPE_HALFELF;
                break;
                case 11:
                iRace = IP_CONST_RACIALTYPE_HALFLING;
                break;
                case 12:
                iRace = IP_CONST_RACIALTYPE_HALFORC;
                break;
                case 13:
                iRace = IP_CONST_RACIALTYPE_HUMAN;
                break;
                case 14:
                iRace = IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID;
                break;
                case 15:
                iRace = IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS;
                break;
                case 16:
                iRace = IP_CONST_RACIALTYPE_HUMANOID_ORC;
                break;
                case 17:
                iRace = IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN;
                break;
                case 18:
                iRace = IP_CONST_RACIALTYPE_MAGICAL_BEAST;
                break;
                case 19:
                iRace = IP_CONST_RACIALTYPE_ABERRATION;
                break;
                case 20:
                iRace = IP_CONST_RACIALTYPE_OUTSIDER;
                break;
                case 21:
                iRace = IP_CONST_RACIALTYPE_SHAPECHANGER;
                break;
                case 22:
                iRace = IP_CONST_RACIALTYPE_UNDEAD;
                break;
                case 23:
                iRace = IP_CONST_RACIALTYPE_VERMIN;
                break;
                }
    itemproperty ipSlayRace = ItemPropertyOnHitProps(iType,iSaveDC,iRace);
    IPSafeAddItemProperty(oItem,ipSlayRace,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    }
if (iType>=26)
     {
     itemproperty ipOHCS = ItemPropertyOnHitCastSpell(iType,d10());
     IPSafeAddItemProperty(oItem,ipOHCS,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     }
}
