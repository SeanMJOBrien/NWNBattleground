#include "x2_inc_itemprop"
void main()
{
//prelim code for enchanting
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
//add anhancement bonus
int iEnch = Random(FloatToInt(iHD/2.0f))+1;
if (iEnch<=0) iEnch=1;
if (iEnch>20) iEnch=20;
SetLocalInt(oItem,"itemlevel",iHD);
//adds keen if roll is made
int iKeen = d100()+iHD;
if (iKeen>=100)
    {
     itemproperty ipKeen = ItemPropertyKeen();
     IPSafeAddItemProperty(oItem,ipKeen,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     }
//adds enhancement bonus
if (iHD>=0)
    {
     itemproperty ipEnch = ItemPropertyEnhancementBonus(iEnch);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                if (iHD>=d100(2))//chance to add vamp regen
                    {
                     int iRegenAmt = Random(FloatToInt(iHD/2.0f));
                     if (iRegenAmt<=0) iRegenAmt=1;
                     if (iRegenAmt>20) iRegenAmt=20;
                     itemproperty ipVR = ItemPropertyVampiricRegeneration(iRegenAmt);
                     IPSafeAddItemProperty(oItem,ipVR,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                    }
                 if (d100()<=30)//chance to add light
                    {
                     int iColor = Random(7);
                     itemproperty ipLight = ItemPropertyLight(Random(4),iColor);
                     IPSafeAddItemProperty(oItem,ipLight,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                    }
    }

//check for saves
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_saves",oItem));
}
//check for spell slots
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_spellslots",oItem));
}
if (iHD>=d20(4))
{
DelayCommand(0.0f,ExecuteScript("add_damage",oItem));
}
//check for onhit props
if (iHD>=d100(2))
{
ExecuteScript("add_onhit",oItem);
}
//check for special props
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_ac_wep",oItem));
}
//check for massive crits
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_mcrits",oItem));
}
}
