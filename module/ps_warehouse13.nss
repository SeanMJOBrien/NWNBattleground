int StartingConditional()
{
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
if (GetFirstItemInInventory(oStores) != OBJECT_INVALID) return TRUE;
return FALSE;
}
