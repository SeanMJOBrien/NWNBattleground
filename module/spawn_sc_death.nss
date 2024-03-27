//
// Death Scripts
//
#include "spawn_functions"
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void main()
{
    // Initialize Variables

    // Retrieve Script Number
    int nDeathScript = GetLocalInt(OBJECT_SELF, "DeathScript");

    // Invalid Script
    if (nDeathScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nDeathScript == 0)
    {
    }
    //
    if (nDeathScript == 1)
    {
//    SendMessageToPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,OBJECT_SELF),"Death Script Name: "+GetName(OBJECT_SELF)+" Tag: "+GetTag(OBJECT_SELF));
    int nCount = 1;
    object oScan = GetNearestObjectByTag(GetResRef(OBJECT_SELF),OBJECT_SELF,nCount);
    while (GetSubString(GetName(oScan),0,2) != "SP")
        {
        nCount ++;
        oScan = GetNearestObjectByTag(GetResRef(OBJECT_SELF),OBJECT_SELF,nCount);
        }
    NESS_DeactivateSpawn(oScan);
    DespawnChildren(oScan);
    }

    // Scared Prey
    if (nDeathScript == 10)
    {
        object oKiller = GetLastKiller();
        if (GetLocalInt(oKiller, "Predator") == TRUE)
        {
            // Feed the Predator
            int nCurrentHungerState = GetLocalInt(oKiller, "CurrentHungerState");
            int nKills = GetLocalInt(oKiller, "Kills");
            nKills++;
            int nFed = 5 + (nKills / 25);
            nCurrentHungerState = nCurrentHungerState + 1 + nFed;
            SendMessageToAllDMs("Predator is Fed (" + IntToString(nFed) + ").");
            AssignCommand(oKiller, SpeakString("That's " + IntToString(nKills) + " prey I've killed!  I get " + IntToString(nFed) + " more food!"));
            SetLocalInt(oKiller, "Kills", nKills);
            SetLocalInt(oKiller, "CurrentHungerState", nCurrentHungerState);
        }
    }
    //
    if (nDeathScript == 2)
        {
        object oMPOP = GetLocalObject(OBJECT_SELF,"MPOP_PARENT");
        if (oMPOP != OBJECT_INVALID)
            {
            string sBasePop = GetSubString(GetTag(OBJECT_SELF),0,4);
            int nSubtract = GetLocalInt(GetModule(),sBasePop+"_DEATH");
            int nCount = 1;
            int nPopStr;
            int nBuffer2; string sBufferD;
            string sSlotScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
            while (sSlotScan != "")
                {
                if (GetSubString(sSlotScan,0,4) == sBasePop)
                    {
                    nPopStr = StringToInt(GetSubString(sSlotScan,5,3));
                    nPopStr -= nSubtract;
                    if (nPopStr <= 0)
                        {
                        DeleteLocalString(oMPOP,"Pop"+IntToString(nCount));
                        for (nBuffer2 = nCount + 1; nBuffer2 < 7; nBuffer2++)
                            {
                            sBufferD = GetLocalString(oMPOP,"Pop"+IntToString(nBuffer2));
                           if (sBufferD != "")
                                {
                                SetLocalString(oMPOP,"Pop"+IntToString(nBuffer2 - 1),sBufferD);
                                DeleteLocalString(oMPOP,"Pop"+IntToString(nBuffer2));
                                break;
                                }
                            }
                        }
                    else
                        {
                        SetLocalString(oMPOP,"Pop"+IntToString(nCount),sBasePop+"_"+IntToString(nPopStr));
                        }
                    object oPCToHear = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,OBJECT_SELF);
                    SendMessageToPC(oPCToHear,"Population "+sBasePop+" at MPOP waypoint "+GetName(oMPOP)+" loses "+IntToString(nSubtract)+".");
                    }
                nCount++;
                sSlotScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
                }
            }
        }

// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Record that we Ran Script
    SetLocalInt(OBJECT_SELF, "DeathScriptRan", TRUE);
}
