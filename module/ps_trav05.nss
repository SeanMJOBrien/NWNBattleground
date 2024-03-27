int StartingConditional()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
int nProgress = StringToInt(GetSubString(sTravel,5,4));
string sTravelTo = GetLocalString(oPC,"TravelTo");

string sActionText = GetLocalString(oPC,"ActionText");;
int nTravelGoal = GetLocalInt(oPC,"TravelGoal");
int nPartyCount = GetLocalInt(oPC,"PartyCount");
int nCount;
object oScan;

if ((nPartyCount > 0) && (nProgress == nTravelGoal))
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

SetCustomToken(362,sActionText);
SetCustomToken(365,sTravelTo);
if (GetLocalInt(oPC,"Flee")) return FALSE;
if (nProgress == nTravelGoal)
    {
    SetLocalInt(oPC,"Arrive",1);
    return TRUE;
    }
return FALSE;
}
