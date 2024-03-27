
#include "spawn_functions"
#include "ps_timestamp"

void main()
{
int nRoll;
location lKey;
object oScan;
object oChestTrap = GetObjectByTag("ps_trogchesttrap");
object oGong = GetObjectByTag("ps_troggong");
int nCounter = 0;
if (GetIsLaterThan(OBJECT_SELF) == TRUE)
    {
    DeleteLocalInt(OBJECT_SELF,"nDeactivated");
    DeleteTimeStamp(OBJECT_SELF);
    }
if (GetLocalInt(OBJECT_SELF,"nDeactivated") == FALSE)
    {
    nRoll = d6();
    lKey = GetLocation(GetObjectByTag("PS_TROGKEY"+IntToString(nRoll)));
    CreateObject(OBJECT_TYPE_ITEM,"ps_trogkey001",lKey);
    oScan = GetObjectByTag("trog_group",nCounter);
    DeleteLocalInt(oGong,"Deactivated");
    DeleteLocalInt(oChestTrap,"Deactivated");
    while (oScan != OBJECT_INVALID)
        {
        if (GetLocalInt(oScan,"SpawnDeactivated") == TRUE)
            DeleteLocalInt(oScan,"SpawnDeactivated");
        nCounter = nCounter + 1;
        oScan = GetObjectByTag("trog_group",nCounter);
        }
    nCounter = 0;
    oScan = GetObjectByTag("trog_kobold_group",nCounter);
    while (oScan != OBJECT_INVALID)
        {
        if (GetLocalInt(oScan,"SpawnDeactivated") == TRUE)
            DeleteLocalInt(oScan,"SpawnDeactivated");
        nCounter = nCounter + 1;
        oScan = GetObjectByTag("trog_kobold_group",nCounter);
        }
    }

Spawn_OnAreaEnter();
SetLocalInt(OBJECT_SELF,"nDeactivated",TRUE);

}
