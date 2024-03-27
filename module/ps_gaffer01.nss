int StartingConditional()
{
object oStores = GetObjectByTag("ps_storagecrate");
if (GetFirstItemInInventory(oStores) != OBJECT_INVALID) return TRUE;
return FALSE;
}
