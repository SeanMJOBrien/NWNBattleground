#include "ps_timestamp"

int StartingConditional()
{
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
int nProgress = StringToInt(GetSubString(sTravel,5,4));

string sActionText;
int nTravelGoal = GetLocalInt(oPC,"TravelGoal");
int nPartyCount = GetLocalInt(oPC,"PartyCount");
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
int nLeastMove = GetLocalInt(oPC,"LeastMove");
string sTime = SayTimestamp(oPC,7);

string sSay;
int nDebitHour = GetLocalInt(oPC,"DebitHour");
if (nDebitHour == 0)
    {
    sSay = "Advancing time in this manner will abort your current travel session."+SayGreyhawkDateTime();
    }
else
    {
    sSay = "Advancing time in this manner will remove the "+SayHours(nDebitHour)+" you have debited, and will abort your current travel session.";
    }
SetCustomToken(367,sSay);
return TRUE;

}
