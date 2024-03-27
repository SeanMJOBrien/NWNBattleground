#include "ps_timestamp"

void main()
{
object oScan = GetFirstItemInInventory(OBJECT_SELF);
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "GOODFOOD") AdvanceTimeStamp(oScan,0,0,2,0,1);
    oScan = GetNextItemInInventory(OBJECT_SELF);
    }
}
