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

object oItem = CreateItemOnObject("belt",OBJECT_SELF);
int iModel = Random(9)+1;
object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,iModel,TRUE);
DestroyObject(oItem);
DelayCommand(2.7f,ActionEquipItem(oSimple,INVENTORY_SLOT_BELT));
SetLocalInt(oSimple,"itemlevel",iHD);
//SetDroppableFlag(oSimple,FALSE);

//check for skill bonuses
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_skill",oSimple));
}
//check for spell resistance
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_sr",oSimple));
}
//check for ability bonus
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_ability",oSimple));
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
return;
}
//check for saves
if (iHD>=d100())
{
DelayCommand(0.0f,ExecuteScript("add_saves",oSimple));
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
return;
}
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
