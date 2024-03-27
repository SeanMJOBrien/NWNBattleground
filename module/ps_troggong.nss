#include "spawn_functions"


void main()
{
object oRing = GetNearestObjectByTag("GongRings");
//object oDiners = GetNearestObjectByTag("trog_group");
//object oDoor = GetNearestObjectByTag("ps_trogdoor34");
//if (GetLocalInt(OBJECT_SELF,"Deactivated") == FALSE)
//    {
//    DeleteLocalInt(oDiners,"SpawnDeactivated");
//    NESS_ForceProcess(oDiners);
////    SetLocalInt(OBJECT_SELF,"Deactivated",TRUE);
//    AssignCommand(oDoor,ActionOpenDoor(oDoor));
//    }
SoundObjectPlay(oRing);
}
