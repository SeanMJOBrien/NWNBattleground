#include "ps_timestamp"

void main()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
int nProgress = StringToInt(GetSubString(sTravel,5,4));
int nLeagues = nProgress / 3;
string sActionText = GetLocalString(oPC,"ActionText");
string sTravelFrom = GetLocalString(oPC,"TravelFrom");
string sTravelTo = GetLocalString(oPC,"TravelTo");
string sTravelCompass = GetLocalString(oPC,"TravelCompass");
string sTime = SayTimestamp(oPC,7);
string sSay;
string sNarration;

int nTravelGoal = GetLocalInt(oPC,"TravelGoal");
int nLeastMove = GetLocalInt(oPC,"LeastMove");
int nPartyCount = GetLocalInt(oPC,"PartyCount");
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
int nTraveledMost;
int nCount;
object oScan;
int nBuffer;
string sForced;
object oForced;
float fTraveled = IntToFloat(nProgress) / IntToFloat(nTravelGoal);
for (nCount = 0; nCount <= nPartyCount; nCount ++)
    {
    if (nCount ==0) oScan = oPC;
    else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCount));
    nBuffer = GetLocalInt(oScan,"HoursTraveled");
    if (nBuffer > nTraveledMost)
        {
        nTraveledMost = nBuffer;
        if (oScan != oPC) oForced = oScan;
        }
    }
if (nTraveledMost >= 8)
    {
    if ((nPartyCount == 0) || (oForced == OBJECT_INVALID))
        sForced = "You have traveled "+IntToString(nTraveledMost)+" hours without rest. Further travel will be considered a forced march. ";
    else sForced = GetName(oForced)+" has traveled "+IntToString(nTraveledMost)+" hours without rest. Further travel will be considered a forced march. ";
    }

if (sRoute == "CWRL")
    {
    if (fTraveled < 0.5) sNarration = "Setting out from Critwall you follow the Ritensa River to your left.";
    else sNarration = "Marching is slow going as it is easy to get lost or misdirected in this marshland.";
    }
else if ((sRoute == "RLBH") && (fTraveled > 0.80)) sNarration = "In the distance you can make out Beggarstaff Hill.";
else if ((sRoute == "RLCW") && (fTraveled  > 0.60)) sNarration = "The area around Critwall has seen many sieges. Thus the countryside is littered with derelict wooden towers and sappers' tunnels.";



string sIsAre = "is";
if ((sRoute == "RLCW") || (sRoute == "RLBH")) sIsAre = "are";
sSay = sActionText +"You are traveling "+sTravelCompass+" to "+sTravelTo;
if (nLeagues == 0) sSay = sSay + ". You are a few furlongs away from "+sTravelFrom+".";
else sSay = sSay+", "+sTravelFrom+" "+sIsAre+" "+IntToString(nLeagues)+" leagues behind you.";
sSay = sSay + sNarration+ " " + sForced + sTime;

SetCustomToken(363,sSay);
if (nPartyCount > 0)
    {
    int nCount;
    object oScan;
    for (nCount = 1; nCount <= nPartyCount; nCount ++)
        {
        oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCount));
        if ((oScan != OBJECT_INVALID) && (GetIsPC(oScan)))
            SendMessageToPC(oScan,sSay);
        }
    }

}
