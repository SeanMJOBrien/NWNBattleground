#include "ps_timestamp"
void main()
{
object oPC = GetPCSpeaker();
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
string sSay;
int nPartyCount = GetLocalInt(oPC,"PartyCount");

    AdvanceTimeStamp(oPC,0,0,0,4,7);
    nHoursTraveled += 4;
    SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
    if (sSay == "")
        {
        if (nPartyCount == 0) sSay = "You wait for four hours.";
        else sSay = "Your party waits for four hours.";
        }
SetLocalString(oPC,"ActionText",sSay);

}
