//
// NESS V8.1
//
// Spawn sample onExit
//
// If you want to use pseudo-heartbeats and do not already have an area onExit
// script, you can use this one.  Otherwise, just add Spawn_OnAreaExit() to
// your existing onExit handler.  Note that you use this (and
// SpawnOnAreaEnter()) INSTEAD OF Spawn() / spawn_sample_hb.
//

#include "spawn_functions"

void main()
{
object oPC = GetExitingObject();
object oStores = GetNearestObjectByTag("ps_warehouse");
object oCrate = GetNearestObjectByTag("ps_storagecrate");


if (GetLocalInt(oPC,"Storing") == 1)
    {
    DeleteLocalInt(oPC,"Storing");
    object oScan = GetFirstItemInInventory(oCrate);
    while (oScan != OBJECT_INVALID)
        {
            SetLocalString(oScan,"Owner",GetName(oPC));
            AssignCommand(oCrate,ActionGiveItem(oScan,oStores));
        oScan = GetNextItemInInventory(oCrate);
        }
    }

    Spawn_OnAreaExit();
}
