#include "spawn_functions"

void main()
{
object oScan = GetFirstObjectInArea(OBJECT_SELF);
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "trog_group")
        {
        SetLocalInt(oScan,"SpawnDeactivated",TRUE);
        break;
        }
    oScan = GetNextObjectInArea(OBJECT_SELF);
    }
  Spawn_OnAreaEnter();
}
