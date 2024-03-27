#include "ps_craftsman"

void main()
{
//SpawnScriptDebugger();
object oContainer = GetLocalObject(GetPCSpeaker(),"Container");
object oItem = GetLocalObject(oContainer,"Item"+IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose")));
int nValue = GetGoldPieceValue(oItem);
if (GetBaseItemType(oItem) == BASE_ITEM_SPELLSCROLL) nValue = nValue / 6;
TakeGoldFromCreature(nValue,GetPCSpeaker(),TRUE);
CreateVoucherOn(GetPCSpeaker(),oItem);
}
