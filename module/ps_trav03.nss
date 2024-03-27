#include "ps_timestamp"
void main()
{
//SpawnScriptDebugger();
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

int nHours;
int nEncounter;
int nCount;
int nDump;
object oScan;
int nDamaged;
int nBuffer;
int nHampered;
string sSay;
int nDamage;
string sHampered;
for (nCount = 0; nCount <= nPartyCount; nCount++)
    {
    if (nCount == 0) oScan = oPC;
    else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCount));
    nDamaged = 10 * FloatToInt(1.0 - (IntToFloat(GetCurrentHitPoints(oScan)) / IntToFloat(GetMaxHitPoints(oScan))));
    if (nDamaged > 5)
        {
        nDamaged += 5;
        if (!FortitudeSave(oScan,nDamaged))
            {
            nHampered = TRUE;
            if (nPartyCount == 0) sHampered = "Your poor condition are slowing you down. ";
            else sHampered = "A party member's condition is slowing you down. ";
            nLeastMove = 1;
            break;
            }
        }
    }
//if (nHampered)
//    {
//    AdvanceTimeStamp(oPC,0,0,0,1,7);
//    nHoursTraveled ++;
//    SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
//    if (nPartyCount == 0) SetLocalString(oPC,"ActionText","You make no progress due to your wounds.");
//    else SetLocalString(oPC,"ActionText","Your party is hampered by its wounds.");
//    return;
//    }
int nBreakTravel;
while ((nProgress < nTravelGoal) && (nHours < 4))
    {
    nHours ++;
    nProgress += nLeastMove;
    if ((nHoursTraveled + nHours) > 8)
        {
        for (nCount = 0; nCount <= nPartyCount; nCount++)
            {
            if (nCount == 0) oScan = oPC;
            else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCount));
            if ((oScan != OBJECT_INVALID) && (!FortitudeSave(oScan,2+ ((nHoursTraveled + nHours)))))
                {
                nBreakTravel = TRUE;
                nDamage = d6();
                if (GetCurrentHitPoints(oScan) < (nDamage + 1)) nDamage = GetCurrentHitPoints(oScan) -1;
                if (nDamage < 0) nDamage = 0;
                //AdvanceTimeStamp(oPC,0,0,0,nHours,7);
                //nHoursTraveled += nHours;
                //SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
               // SetLocalString(oPC,"TRAVEL",sRoute+"_"+IntToString(nProgress));
//                if (GetCurrentHitPoints(oScan) > (nDamage + 1))
//                    {
                    AssignCommand(oScan,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage),oScan));
                    if (nPartyCount == 0) sSay = "You press on for "+IntToString(nHours)+" more hour";
                    else sSay = "Your party presses on for "+IntToString(nHours)+" more hour";
                    if (nHours > 1) sSay = sSay + "s";
                    sSay = sSay + ". ";
                    //return;
//                    }
//                else
//                    {
//                    sSay = "After "+IntToString(nHours)+" hour";
//                    if (nHours > 1) sSay = sSay +"s ";
//                    if (nPartyCount == 0) sSay = sSay +"of travel you collapse exhausted. ";
//                    else sSay = sSay +", your party is exhausted. ";
//                    SetLocalString(oPC,"ActionText",sSay);
                    //return;
//                    }
                }//if ((oScan != OBJECT_INVALID) && ((10+ (8 - (nHoursTraveled +...
            }//for (nCount = 0; nCount <= nPartyCount; nCount++)
        }//if ((nHoursTraveled + nHours) > 8)
    if (d20() == 1)
        {
        nBreakTravel = TRUE;
        //AdvanceTimeStamp(oPC,0,0,0,nHours,7);
        //nHoursTraveled += nHours;
       // SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
        sSay = "After "+IntToString(nHours)+" hour";
        if (nHours > 1) sSay = sSay +"s ";
        if (nPartyCount == 0) sSay = sSay +"of travel spot something... ";
        else sSay = sSay +" your party spots movement... ";
        SetLocalString(oPC,"ActionText",sSay);
        //SetLocalString(oPC,"TRAVEL",sRoute+"_"+IntToString(nProgress));
        SetLocalInt(oPC,"Encounter",1);
        //return;
        }
    if (nBreakTravel == TRUE) break;
    }//while ((nProgress < nTravelGoal) && (nHours < 4))

if (nProgress < nTravelGoal)
    {
    AdvanceTimeStamp(oPC,0,0,0,nHours,7);
    nHoursTraveled += nHours;
    SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
    if (sSay == "")
        {
        if (nPartyCount == 0) sSay = "You march for "+IntToString(nHours)+" hour";
        else sSay = "Your party marches for "+IntToString(nHours)+" hour";
        if (nHours > 1) sSay = sSay +"s. " + sHampered;
        else sSay = sSay + ". "+ sHampered;
        }
    SetLocalString(oPC,"TRAVEL",sRoute+"_"+IntToString(nProgress));
    SetLocalString(oPC,"ActionText",sSay);
    }
else if (!GetLocalInt(oPC,"Encounter"))
    {
    AdvanceTimeStamp(oPC,0,0,0,nHours,7);
    nHoursTraveled += nHours;
    SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
    sTime = SayTimestamp(oPC,7);
    sSay = "After "+IntToString(nHours)+" hour";
    if (nHours > 1) sSay = sSay +"s";
    if (nHours < 1) sSay = "After a brief march";
    if (nPartyCount == 0) sSay = sSay + " you arrive at your destination. "+sTime;
    else sSay = sSay + " your party arrives at its destination. "+sTime;
    SetLocalString(oPC,"TRAVEL",sRoute+"_"+IntToString(nTravelGoal));
    SetLocalString(oPC,"ActionText",sSay);
    }
}
