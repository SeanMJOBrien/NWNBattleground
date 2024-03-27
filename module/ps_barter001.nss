#include "ps_inc_brtrchst"
int StartingConditional()
{
//SpawnScriptDebugger();
// Declarations
object oPC = GetPCSpeaker();
object oMerchant = OBJECT_SELF;
object oBarterChest = GetNearestObjectByTag("BARTER_CHEST",oMerchant);
//object oStore = GetObjectByTag("STORE_"+GetTag(oMerchant));
object oStore = GetObjectByTag("SOURCE");

object oItemScan;
string sSay;
// End Declarations

int nRemainder = SwapItems(oBarterChest, oStore,oMerchant,8);
sSay = IntToString(nRemainder);
SetCustomToken(777,sSay);

oItemScan = GetFirstItemInInventory(oMerchant);
while (oItemScan != OBJECT_INVALID)
    {
    ActionGiveItem(oItemScan,oStore);
    oItemScan = GetNextItemInInventory(oMerchant);
    }

return TRUE;
}
