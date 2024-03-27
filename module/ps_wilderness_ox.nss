#include "spawn_functions"

void main()
{
//SendMessageToAllDMs("AreaCleanup Initiated...");
object oArea = OBJECT_SELF;
object oItem;
string sTag;
int nCount;
object oTreasureType;
object oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    if (GetIsPC(oScan)) return;
    oScan = GetNextObjectInArea(oArea);
    }
// No PCs in Area.
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


oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    sTag = GetStringUpperCase(GetSubString(GetTag(oScan),0,4));
//    SendMessageToAllDMs("Processing "+GetName(oScan)+": "+sTag);
    if (GetHasInventory(oScan))
        {
        oTreasureType = GetObjectByTag(sTag+"_TT");
        oItem = GetFirstItemInInventory(oScan);
        while (oItem != OBJECT_INVALID)
            {
            if (((GetLocalInt(oItem,"Unique"))
                || (GetLocalInt(oItem,"QUEST")))
                && (oTreasureType != OBJECT_INVALID))
                    AssignCommand(oTreasureType,ActionTakeItem(oItem,oScan));
            else if ((GetObjectType(oScan) != OBJECT_TYPE_STORE) && (GetMaster(oScan) == OBJECT_INVALID)) DestroyObject(oItem);
            oItem = GetNextItemInInventory(oScan);
            }
        }

    if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
        && (GetMaster(oScan) == OBJECT_INVALID))
        {
        oTreasureType = GetObjectByTag(sTag+"_TT");
        for (nCount = 0; nCount <= 17; nCount ++)
            {
            oItem = GetItemInSlot(nCount, oScan);

            if (oItem != OBJECT_INVALID)
                {
                if (((GetLocalInt(oItem,"Unique"))
                   || (GetLocalInt(oItem,"QUEST")))
                    && (oTreasureType != OBJECT_INVALID))
                        AssignCommand(oTreasureType,ActionTakeItem(oItem,oScan));
                }
            }
        }
    if (GetLocalInt(oScan,"DELETE"))
        {
        SetIsDestroyable(TRUE,FALSE,FALSE);
        DestroyObject(oScan);
        }
     if ((GetObjectType(oScan) == OBJECT_TYPE_WAYPOINT)
        && (GetSubString(GetName(oScan),0,2) == "SP"))
        {
//        SendMessageToAllDMs("Reset "+GetTag(oScan)+"...");
        SetLocalInt(oScan, "SpawnDeactivated", FALSE);
        SetLocalInt(oScan, "ChildrenSpawned", 0);
        SetLocalInt(oScan, "CurrentProcessTick", 0);
        SetLocalInt(oScan, "SpawnAgeTime", 0);
        }
    oScan = GetNextObjectInArea(oArea);
    }
Spawn_OnAreaExit();

}
