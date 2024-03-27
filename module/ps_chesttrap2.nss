#include "NW_I0_GENERIC"

void main()
{
if (GetLocalInt(OBJECT_SELF,"Deactivated") == FALSE)
    {
    object oSpawnE = GetNearestObjectByTag("ps_secretspawn_e");
    object oSpawnW = GetNearestObjectByTag("ps_secretspawn_w");
    location lSpawnE = GetLocation(oSpawnE);
    location lSpawnW = GetLocation(oSpawnW);
    object oExitE = GetNearestObjectByTag("ps_secretexit_e");
    location lExitE = GetLocation(oExitE);
    object oExitW = GetNearestObjectByTag("ps_secretexit_w");
//    object oBear = GetNearestObjectByTag("ps_cavebear");
    object oBear;
    object oGateN = GetNearestObjectByTag("ps_troggate2");
    object oGateE = GetNearestObjectByTag("ps_troggate2",OBJECT_SELF,2);
    object oSDE = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_stonedoor",lSpawnE,FALSE,"BearDoor");
    object oSDW = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_stonedoor",lSpawnW,FALSE,"BearDoor");
    SetLocalString(oSDE,"Destination","ps_secretexit_w");
    SetLocalString(oSDW,"Destination","ps_secretexit_e");
    DelayCommand(2.0,AssignCommand(oSDE,PlayAnimation(ANIMATION_PLACEABLE_OPEN)));
    DelayCommand(2.0,AssignCommand(oSDW,PlayAnimation(ANIMATION_PLACEABLE_OPEN)));
    DelayCommand(1.0,AssignCommand(oGateN,ActionCloseDoor(OBJECT_SELF)));
    DelayCommand(1.0,AssignCommand(oGateE,ActionCloseDoor(OBJECT_SELF)));
    SetLocked(oGateN,TRUE);
    SetLocked(oGateE,TRUE);
    DelayCommand(61.0,AssignCommand(oGateN,ActionOpenDoor(OBJECT_SELF)));
    DelayCommand(61.0,AssignCommand(oGateE,ActionOpenDoor(OBJECT_SELF)));
//    if ((oBear != OBJECT_INVALID) && (GetArea(oBear) == GetArea(OBJECT_SELF)) && (GetLocalInt(oBear,"Freed") == FALSE))
//        {
//        DelayCommand(2.9,AssignCommand(oBear,ClearAllActions()));
//        DelayCommand(3.0,AssignCommand(oBear,JumpToObject(oExitE,FALSE)));
//        FloatingTextStringOnCreature(GetTag(oBear),GetLastOpenedBy());
//        SetLocalInt(oBear,"Freed",TRUE);
//        }
    oBear = CreateObject(OBJECT_TYPE_CREATURE,"ps_cavebear",lExitE);
    AssignCommand(oBear,DetermineCombatRound(GetLastOpenedBy()));
    SetLocalInt(OBJECT_SELF,"Deactivated",TRUE);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }
}
