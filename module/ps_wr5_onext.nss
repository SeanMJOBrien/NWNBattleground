#include "spawn_functions"

void main()
{
object oPC = GetExitingObject();
int nPCPresent = FALSE;
object oScan = GetFirstObjectInArea(OBJECT_SELF);
while (oScan != OBJECT_INVALID)
    {
    if (GetIsPC(oScan) && (oScan != oPC))
        {
        nPCPresent = TRUE;
        break;
        }
    oScan = GetNextObjectInArea(OBJECT_SELF);
    }
if (!nPCPresent)
    {
    oScan = GetFirstObjectInArea(OBJECT_SELF);
    while (oScan != OBJECT_INVALID)
        {
        if (GetTag(oScan) == "ps_troggate")
            {
            DelayCommand(0.5,SetLocked(oScan,FALSE));
            DelayCommand(1.0,AssignCommand(oScan,ActionCloseDoor(oScan)));
            DelayCommand(1.5,SetLocked(oScan,TRUE));
            }
        oScan = GetNextObjectInArea(OBJECT_SELF);
        }
    }
    Spawn_OnAreaExit();
}
