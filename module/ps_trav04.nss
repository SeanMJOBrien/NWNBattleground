int StartingConditional()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
int nEncounter = GetLocalInt(oPC,"Encounter");
string sActionText = GetLocalString(oPC,"ActionText");
int nPartyCount = GetLocalInt(oPC,"PartyCount");
int nCount;
object oScan;
int nRoomFree;

for (nCount = 1; nCount <= 6; nCount ++)
    {
    oScan = GetWaypointByTag("WILDERNESS"+IntToString(nCount));
    if ((oScan != OBJECT_INVALID) && (!GetLocalInt(GetArea(oScan),"Occupied")))
        {
        nRoomFree = TRUE;
        break;
        }
    }
if (nRoomFree == FALSE)
    {
    DeleteLocalInt(oPC,"Encounter");
    DeleteLocalString(oPC,"ActionText");
    return FALSE;
    }

if ((nPartyCount > 0) && (nEncounter))
    {
    for (nCount = 1; nCount <= nPartyCount;nCount++)
        {
        oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCount));
        if (GetIsPC(oScan))
            {
             SendMessageToPC(oScan,sActionText);
            }
        }
    }
SetCustomToken(364,sActionText);
if (nEncounter) return TRUE;
return FALSE;
}
