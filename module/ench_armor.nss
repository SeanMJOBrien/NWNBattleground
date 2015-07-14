#include "x2_inc_itemprop"
void main()
{
//prelim code for enchanting
object oItem = OBJECT_SELF;
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
//add anhancement bonus
int iProt = Random(FloatToInt(iHD/2.0f))+1;
if(iProt<1) iProt=1;
if(iProt>20) iProt=20;
itemproperty ipProt = ItemPropertyACBonus(iProt);
IPSafeAddItemProperty(oItem,ipProt,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetLocalInt(oItem,"itemlevel",iHD);

//check for spell resistance
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_sr",oItem));
}
//check for ability bonus
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_ability",oItem));
}
//check for damage resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oItem));
}
//check for immunities
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_immunity",oItem));
}
//check for regeneration
if (iHD>=d100())
{
int iRegen = FloatToInt(iHD/2.0f);
if (iRegen<=0) iRegen=1;
if (iRegen>20) iRegen=20;
itemproperty ipRegen = ItemPropertyRegeneration(Random(iRegen)+1);
IPSafeAddItemProperty(oItem,ipRegen,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
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
//check for skills
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_skill",oItem));
}
//check for damage reduction
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damred",oItem));
}
}
