#include "ps_timestamp"
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
  AssignCommand(oClicker,JumpToObject(oTarget));
SetLocalObject(OBJECT_SELF,"oArea1",GetObjectByTag("ps_trogcaves1"));
SetLocalObject(OBJECT_SELF,"oArea2",GetObjectByTag("ps_trogcaves2"));
SetLocalObject(OBJECT_SELF,"oArea3",GetObjectByTag("ps_trogcaves3"));
SetLocalObject(OBJECT_SELF,"oArea4",GetObjectByTag("ps_trogcaves4"));
SetLocalObject(OBJECT_SELF,"oArea5",GetObjectByTag("ps_trogcaves5"));
SetLocalObject(OBJECT_SELF,"oArea6",GetObjectByTag("ps_whistlingraving"));
object oAreaScan;
int nCount;
object oScan;
int nCount2;
int nPCPresent = FALSE;
object oTrapDoor = GetNearestObjectByTag("RavineHatch");
object oItemBin = GetObjectByTag("ps_trogbin");
// Poke the objects in the play area to find any PCs.
for (nCount = 1; nCount < 6; nCount ++)
    {
    oAreaScan = GetLocalObject(OBJECT_SELF,"oArea"+IntToString(nCount));
    oScan = GetFirstObjectInArea(oAreaScan);
    while (oScan != OBJECT_INVALID)
        {
        if ((GetIsPC(oScan)) && (oScan != oClicker))
            {
            nPCPresent = TRUE;
            break;
            }
        oScan = GetNextObjectInArea(oAreaScan);
        }
    if (nPCPresent == TRUE) break;
    }
// If no PCs are present run an item clean-up routine, reset the trapdoor,
// and time stamp the area for possible reset of the spawn points.
if (nPCPresent == FALSE)
    {
    for (nCount = 1; nCount < 6; nCount ++)
        {
        oAreaScan = GetLocalObject(OBJECT_SELF,"oArea"+IntToString(nCount));
        oScan = GetFirstObjectInArea(oAreaScan);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "ps_trogkey001") DestroyObject(oScan);
            if (GetTag(oScan) == "BearDoor") DestroyObject(oScan);
            if ((GetObjectType(oScan) == OBJECT_TYPE_ITEM) && (GetItemPossessor(oScan) == OBJECT_INVALID))
                {
                ActionGiveItem(oScan,oItemBin);
                }
            if ((GetObjectType(oScan) == OBJECT_TYPE_DOOR) && (GetIsOpen(oScan)) && (GetTag(oScan) != "ps_troggate2"))
                AssignCommand(oScan,ActionCloseDoor(oScan));
            if (GetTag(oScan) == "ps_tglv") AssignCommand(oScan,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            oScan = GetNextObjectInArea(oAreaScan);
            } // while loop
        } // for loop
    SetLocalInt(oTrapDoor,"Reset",1);
    if (GetLocalInt(GetArea(OBJECT_SELF),"nStampDay1") != 0) DeleteTimeStamp(GetArea(OBJECT_SELF));
    AdvanceTimeStamp(GetArea(OBJECT_SELF),0,0,0,15);
    } // if PCPresent == FALSE
DeleteLocalObject(OBJECT_SELF,"oArea1");
DeleteLocalObject(OBJECT_SELF,"oArea2");
DeleteLocalObject(OBJECT_SELF,"oArea3");
DeleteLocalObject(OBJECT_SELF,"oArea4");
DeleteLocalObject(OBJECT_SELF,"oArea5");
DeleteLocalObject(OBJECT_SELF,"oArea6");

}
