#include "spawn_functions"
void AreaCleanup(object oArea)
{
//SendMessageToAllDMs("AreaCleanup Initiated...");
DeleteLocalInt(oArea,"DenyReset");
object oItem;
string sTag;
string sParse;
string sPops = GetLocalString(GetModule(),"POPS");
int nCount;
object oTreasureType;
object oItemScan;
object oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    if (GetIsPC(oScan)) return;
    oScan = GetNextObjectInArea(oArea);
    }
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
//            else if ((GetObjectType(oScan) != OBJECT_TYPE_CREATURE) ||
//            (GetObjectType(oScan) != OBJECT_TYPE_STORE)) DestroyObject(oItem);
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
//    if (GetLocalInt(oScan,"DELETE"))
//        {
//        SetIsDestroyable(TRUE,FALSE,FALSE);
//        DelayCommand(5.0,DestroyObject(oScan));
//        }
     if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
            || (GetObjectType(oScan) == OBJECT_TYPE_PLACEABLE))
        {
        nCount = 0;
        sParse = GetSubString(sPops,nCount,4);
        while (sParse != "")
            {
//            SendMessageToAllDMs("sParse= "+sParse);
            if ((sTag == sParse) || (GetLocalInt(oScan,"CLEANUP") == TRUE))
                {
//                SendMessageToAllDMs("Deleting "+sTag+"...");
                SetPlotFlag(oScan, FALSE);
                SetIsDestroyable(TRUE,FALSE,FALSE);
                DelayCommand(5.0,DestroyObject(oScan));
                break;
                }
            nCount = nCount + 5;
            sParse = GetSubString(sPops,nCount,4);
            }
        }
    if ((GetObjectType(oScan) == OBJECT_TYPE_WAYPOINT)
        && (GetSubString(GetName(oScan),0,2) == "SP"))
        {
//        SendMessageToAllDMs("Reset "+GetTag(oScan)+"...");
//        SetLocalInt(oScan, "SpawnDeactivated", FALSE);
        SetLocalInt(oScan, "ChildrenSpawned", 0);
        SetLocalInt(oScan, "CurrentProcessTick", 0);
        SetLocalInt(oScan, "SpawnAgeTime", 0);
        }

 if( GetTag( oScan) == "BodyBag")
    { oItem = GetFirstItemInInventory( oScan);
      while( GetIsObjectValid( oItem))
      { SetPlotFlag( oItem, FALSE);
        DestroyObject( oItem);
        oItem = GetNextItemInInventory( oScan);
      }
      // Just to be sure:
      DestroyObject( oScan);
    }

    if ((GetObjectType(oScan) == OBJECT_TYPE_ITEM) && (!GetLocalInt(oScan,"Unique")) && (!GetLocalInt(oScan,"QUEST")))
        {
        DestroyObject(oScan);
        }
    oScan = GetNextObjectInArea(oArea);
    }
}


void main()
{
int nPCPresent = FALSE;
object oScan;
object oArea = OBJECT_SELF;
object oPC;
if ((GetIsPC(GetExitingObject()))
        || (GetIsDM(GetExitingObject())))
//        DelayCommand(120.0,AreaCleanup(GetArea(OBJECT_SELF)));
        {
        oScan = GetFirstObjectInArea(oArea);
        while (oScan != OBJECT_INVALID)
            {
            if ((GetIsPC(oScan)) && (oScan != oPC))
                {
                nPCPresent = TRUE;
                break;
                }
            oScan = GetNextObjectInArea(oArea);
            }
        if (nPCPresent == FALSE)
            {
            SetLocalInt(oArea,"DenyReset",TRUE);
            DelayCommand(300.0,AreaCleanup(OBJECT_SELF));
            }
        }


    Spawn_OnAreaExit();
}
