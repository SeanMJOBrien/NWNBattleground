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
object oItem = CreateItemOnObject("mring",OBJECT_SELF);
string sName = GetName(oItem);

if ((iHD+10)>=d100())
{
int iProt = FloatToInt((iHD*10.0f)/40.0f);
if (iProt<=0) iProt=1;
if (iProt>20) iProt=20;
string sAmt = IntToString(iProt);
itemproperty ipProt = ItemPropertyACBonus(iProt);
IPSafeAddItemProperty(oItem,ipProt,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,"+"+sAmt+" "+sName);
}
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(37)+1,TRUE);
DestroyObject(oItem);
DelayCommand(2.3f,ActionEquipItem(oSimple,INVENTORY_SLOT_RIGHTRING));
SetLocalInt(oSimple,"itemlevel",iHD);
//SetDroppableFlag(oSimple,FALSE);

//check for spell resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_sr",oSimple));
}
//check for ability bonus
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_ability",oSimple));
}
//check for spell casting
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_spell",oSimple));
}
//check for damage resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damageres",oSimple));
}
//check for immunities
if (iHD>=d100(2))
{
DelayCommand(0.0f,ExecuteScript("add_immunity",oSimple));
}
//check for regeneration
if (iHD>=d100())
{
int iRegen = FloatToInt(iHD/2.0f);
itemproperty ipRegen = ItemPropertyRegeneration(Random(iRegen)+1);
IPSafeAddItemProperty(oItem,ipRegen,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
SetName(oItem,"Regeneration "+sName);
}
//check for saves
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_saves",oSimple));
}
//check for spell slots
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_spellslots",oSimple));
}
//check for skills
if (iHD>=d20(3))
{
DelayCommand(0.0f,ExecuteScript("add_skill",oSimple));
}
//check for damage reduction
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_damred",oSimple));
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}