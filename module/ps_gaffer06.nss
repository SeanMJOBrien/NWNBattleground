#include "ps_mod_data"

void main()
{
object oPC = GetLastOpenedBy();
SetLocalObject(OBJECT_SELF,"OpenedBy",oPC);
object oBox = OBJECT_SELF;
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
if (GetFirstItemInInventory(oStores) != OBJECT_INVALID)
    {
    object oScan = GetFirstItemInInventory(oStores);
    while (oScan != OBJECT_INVALID)
        {
        if (GetLocalObject(oScan,"Owner") == oPC)
            {
            AssignCommand(oStores,ActionGiveItem(oScan,oBox));
            DeleteLocalObject(oScan,"Ownwer");
            }
        oScan = GetNextItemInInventory(oStores);
        }
    }
else LoadStores(oPC,oBox);
}
