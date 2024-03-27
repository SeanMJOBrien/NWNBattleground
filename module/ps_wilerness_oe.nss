#include "spawn_functions"
void main()
{
object oPC = GetEnteringObject();
if (GetIsPC(oPC)) SetLocalInt(OBJECT_SELF,"Occupied",TRUE);
object oSpawn1; object oSpawn4; object oSpawn6;
int nCamp;
int nPCsPresent;

object oScan = GetFirstObjectInArea(OBJECT_SELF);
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (oScan != oPC))
        {
        nPCsPresent = TRUE;
        }
    if (GetSubString(GetTag(oScan),0,4) == "CAMP")
        {
        nCamp = TRUE;
        }
    else if (GetTag(oScan) == "WILDENC1") oSpawn1 = oScan;
    else if (GetTag(oScan) == "WILDENC4") oSpawn4 = oScan;
    else if (GetTag(oScan) == "WILDENC6") oSpawn6 = oScan;
    oScan = GetNextObjectInArea(OBJECT_SELF);
    }
if (GetIsPC(oPC)) SetLocalInt(OBJECT_SELF,"Occupied",TRUE);
if (!nPCsPresent)
    {
//    DeleteLocalInt(oSpawn1,"SpawnCount");
//    DeleteLocalInt(oSpawn4,"SpawnCount");
//    DeleteLocalInt(oSpawn6,"SpawnCount");
    int nAppearing = GetLocalInt(OBJECT_SELF,"Appearing");
    if (nCamp)
        {
        NESS_DeactivateSpawn(oSpawn1);
        NESS_DeactivateSpawn(oSpawn4);
        NESS_DeactivateSpawn(oSpawn6);
        }
    else if (nAppearing == 1)
        {
        NESS_ActivateSpawn(oSpawn1);
        NESS_DeactivateSpawn(oSpawn4);
        NESS_DeactivateSpawn(oSpawn6);
        }
    else if (nAppearing == 4)
        {
        NESS_ActivateSpawn(oSpawn4);
        NESS_DeactivateSpawn(oSpawn1);
        NESS_DeactivateSpawn(oSpawn6);
        }
    else if (nAppearing == 6)
        {
        NESS_ActivateSpawn(oSpawn6);
        NESS_DeactivateSpawn(oSpawn4);
        NESS_DeactivateSpawn(oSpawn1);
        }

    }

    Spawn_OnAreaEnter();
}
