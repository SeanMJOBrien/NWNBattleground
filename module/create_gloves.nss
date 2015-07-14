#include "x2_inc_itemprop"

void main()
{
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////
object oItem = CreateItemOnObject("gloves",OBJECT_SELF);
int iFeat;
string sPname;
if (d100()<=iHD)
    {
    switch(Random(28)+1)
            {
            case 1: iFeat = IP_CONST_FEAT_ALERTNESS; sPname = "Sentry's ";break;
            case 2: iFeat = IP_CONST_FEAT_AMBIDEXTROUS; sPname = "Ranger's ";break;
            case 3: iFeat = IP_CONST_FEAT_CLEAVE; sPname = "Reaper's ";break;
            case 4: iFeat = IP_CONST_FEAT_COMBAT_CASTING; sPname = "Battlemage's ";break;
            case 5: iFeat = IP_CONST_FEAT_DISARM; sPname = "Duellist's ";break;
            case 6: iFeat = IP_CONST_FEAT_EXTRA_TURNING; sPname = "Cleric's ";break;
            case 7: iFeat = IP_CONST_FEAT_HIDE_IN_PLAIN_SIGHT; sPname = "Shadow's ";break;
            case 8: iFeat = IP_CONST_FEAT_IMPCRITUNARM; sPname = "Brawler's ";break;
            case 9: iFeat = IP_CONST_FEAT_KNOCKDOWN; sPname = "Bull's ";break;
            case 10: iFeat = IP_CONST_FEAT_POINTBLANK; sPname = "Archer's ";break;
            case 11: iFeat = IP_CONST_FEAT_POWERATTACK; sPname = "Fighter's ";break;
            case 12: iFeat = IP_CONST_FEAT_RAPID_SHOT; sPname = "Arrowstorm ";break;
            case 13: iFeat = IP_CONST_FEAT_SNEAK_ATTACK_1D6; sPname = "Blackguard's ";break;
            case 14: iFeat = IP_CONST_FEAT_SNEAK_ATTACK_2D6; sPname = "Rogue's ";break;
            case 15: iFeat = IP_CONST_FEAT_SNEAK_ATTACK_3D6; sPname = "Assassin's ";break;
            case 16: iFeat = IP_CONST_FEAT_SPELLFOCUSABJ; sPname = "Abjurer's ";break;
            case 17: iFeat = IP_CONST_FEAT_SPELLFOCUSCON; sPname = "Conjurer's ";break;
            case 18: iFeat = IP_CONST_FEAT_SPELLFOCUSDIV; sPname = "Diviner's ";break;
            case 19: iFeat = IP_CONST_FEAT_SPELLFOCUSENC; sPname = "Enchanter's ";break;
            case 20: iFeat = IP_CONST_FEAT_SPELLFOCUSEVO; sPname = "Evoker's ";break;
            case 21: iFeat = IP_CONST_FEAT_SPELLFOCUSILL; sPname = "Illusionist's ";break;
            case 22: iFeat = IP_CONST_FEAT_SPELLFOCUSNEC; sPname = "Necromancer's ";break;
            case 23: iFeat = IP_CONST_FEAT_SPELLPENETRATION; sPname = "Archmage's ";break;
            case 24: iFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING; sPname = "Blade Dervish's ";break;
            case 25: iFeat = IP_CONST_FEAT_USE_POISON; sPname = "Defiler's ";break;
            case 26: iFeat = IP_CONST_FEAT_WEAPFINESSE; sPname = "Graceful ";break;
            case 27: iFeat = IP_CONST_FEAT_WEAPSPEUNARM; sPname = "Monk's ";break;
            case 28: iFeat = IP_CONST_FEAT_WHIRLWIND; sPname = "Whirlwind ";break;
            }
itemproperty ipFeat = ItemPropertyBonusFeat(iFeat);
IPSafeAddItemProperty(oItem,ipFeat,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,sPname+GetName(oItem));
    }//end if
int iType=d10();
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iType,TRUE);
DestroyObject(oItem);
DelayCommand(2.7f,ActionEquipItem(oSimple,INVENTORY_SLOT_ARMS));
SetLocalInt(oSimple,"itemlevel",iHD);
//check for skill bonuses
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_skill",oSimple));
}
//check for spell casting
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_spell",oSimple));
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
