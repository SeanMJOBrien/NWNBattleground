int StartingConditional()
{
object oStores = GetObjectByTag("ps_warehouse");
object oPC = GetPCSpeaker();
//object oCrate = GetNearestObjectByTag("ps_storagecrate");

object oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
    if (GetLocalString(oScan,"Owner") == GetName(oPC))
        {
        return TRUE;
        }
    oScan = GetNextItemInInventory(oStores);
    }
return FALSE;
}
