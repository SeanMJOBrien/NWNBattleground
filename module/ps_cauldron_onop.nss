void main()
{
object oPC = GetLastOpenedBy();
object oScan = GetFirstItemInInventory(oPC);
while (oScan != OBJECT_INVALID)
    {
    if ((GetSubString(GetTag(oScan),0,9) == "MATERIAL_") || (GetTag(oScan) == "ARCANE_FOCUS"))
        {
        ActionTakeItem(oScan,oPC);
        }
    oScan = GetNextItemInInventory(oPC);
    }
}
