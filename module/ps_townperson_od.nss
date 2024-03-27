//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "spawn_functions"

void main()
{
        int nCount = 1;
    object oScan = GetNearestObjectByTag(GetResRef(OBJECT_SELF),OBJECT_SELF,nCount);
    while (GetSubString(GetName(oScan),0,2) != "SP")
        {
        nCount ++;
        oScan = GetNearestObjectByTag(GetResRef(OBJECT_SELF),OBJECT_SELF,nCount);
        }
    NESS_DeactivateSpawn(oScan);
    DespawnChildren(oScan);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);

}
