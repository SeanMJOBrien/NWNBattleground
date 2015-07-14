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

if (iHD>=0)
    {
     itemproperty ipEnch = ItemPropertyAttackBonus(iEnch);
     IPSafeAddItemProperty(oItem,ipEnch,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
     if(iHD>=d100())
        {
         int iMight = FloatToInt(iEnch/4.0f);
         if (iMight<=0) iMight=1;
         if (iMight>10) iMight=10;
         itemproperty ipMighty = ItemPropertyMaxRangeStrengthMod(iMight);
         IPSafeAddItemProperty(oItem,ipMighty,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
     if (iHD>=d100(2))
     {
     int iDam = d10();
     itemproperty ipUA = ItemPropertyUnlimitedAmmo(iDam);
     IPSafeAddItemProperty(oItem,ipUA,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
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
}
