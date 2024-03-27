#include "spawn_functions"

void main()
{
//SpawnScriptDebugger();
object oPC = GetExitingObject();
int nPCPresent = FALSE;
object oSpawn1; object oSpawn4; object oSpawn6;

object oScan = GetFirstObjectInArea(OBJECT_SELF);
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (oScan != oPC))
        {
        nPCPresent = TRUE;
        }
    else if (GetTag(oScan) == "WILDENC1") oSpawn1 = oScan;
    else if (GetTag(oScan) == "WILDENC4") oSpawn4 = oScan;
    else if (GetTag(oScan) == "WILDENC6") oSpawn6 = oScan;
    oScan = GetNextObjectInArea(OBJECT_SELF);
    }
if (!nPCPresent)
    {
    DespawnChildren(oSpawn1);
    DespawnChildren(oSpawn4);
    DespawnChildren(oSpawn6);
    DeleteLocalInt(OBJECT_SELF,"Occupied");
    string sDest;
    oScan = GetFirstObjectInArea(OBJECT_SELF);
    while (oScan != OBJECT_INVALID)
        {
        if (GetName(oScan) == "Travel")
            {
            sDest = GetSubString(GetTag(oScan),0,4)+"_TRAVELDEST";
            DestroyObject(oScan);
            }
        oScan = GetNextObjectInArea(OBJECT_SELF);
        }
    object oWPDest;
    location lDest;
    object oRemains;
    object oScanB;
    if (sDest != "")
        {
        oWPDest = GetWaypointByTag(sDest);
        lDest = GetLocation(oWPDest);
        }
    //SendMessageToPC(oPC,GetTag(oWPDest));
//    oScan = GetFirstObjectInArea(OBJECT_SELF);
//    while (oScan != OBJECT_INVALID)
//        {
//        if ((GetName(oScan) == "Remains") || (GetTag(oScan) == "ps_remains")) DestroyObject(oScan);
//        if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE) && (!GetIsPC(oScan)) &&  (!GetIsFriend(oScan,oPC))) DestroyObject(oScan);
//        oScan = GetNextObjectInArea(OBJECT_SELF);
//        }
    DeleteLocalString(OBJECT_SELF,"Encounter");
    DeleteLocalInt(OBJECT_SELF,"Appearing");
    DeleteLocalInt(OBJECT_SELF,"DoEncounter");
    }
Spawn_OnAreaExit();

}
