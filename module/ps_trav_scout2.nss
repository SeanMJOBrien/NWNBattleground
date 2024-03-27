#include "ps_timestamp"
void main()
{
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
object oTravelDest = GetWaypointByTag(sRoute+"_TRAVELDEST");
object oMPOP = GetNearestObjectByTag("MPOP",oTravelDest);
string sMPOPName;
int nPopStr;
int nStrongest;

string sSay;
string sScan;
int nCount = 1;
int nSearchDC;
int nPlace;
string sStrength;
int nSearchBonus = GetSkillRank(SKILL_SEARCH,oPC) + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
string sParse;
AdvanceTimeStamp(oPC,0,0,0,1,7);
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled") + 1;
SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
if (oMPOP != OBJECT_INVALID)
    {
    sScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    while (sScan != "")
        {
        nPopStr = StringToInt(GetSubString(sScan,5,4));
        if (nPopStr > nStrongest)
            {
            nPopStr = nStrongest;
                    sMPOPName = GetLocalString(GetModule(),GetSubString(sScan,0,4)+"_NAME");
        nSearchDC = 15 - (StringToInt(GetSubString(sScan,5,3))/10);
        if ((GetLevelByClass(CLASS_TYPE_RANGER,oPC) > 0)
            || (GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 0))
            nSearchDC -= 4;
        if (nSearchDC < 1) nSearchDC = 1;
        if ((d20(1) + nSearchBonus) >= nSearchDC)
            {
            if (StringToInt(GetSubString(sScan,5,3)) < 50) sStrength = "sparse";
            else if (StringToInt(GetSubString(sScan,5,3)) < 100) sStrength = "moderate";
            else if (StringToInt(GetSubString(sScan,5,3)) < 150) sStrength = "strong";
            else if (StringToInt(GetSubString(sScan,5,3)) >= 150) sStrength = "overwhelming";
                switch(d3(1))
                    {
                    case 1:
                    sSay = "You find tell-tale signs of a(n) "+sStrength+" presence of the " + sMPOPName+".";
                    break;
                    case 2:
                    sSay = "You spot some debris from the " + sMPOPName+".";
                    break;
                    case 3:
                    sSay = "Clues suggest a(n) "+sStrength+" presence of the " + sMPOPName+".";
                    break;
                    }
            }
            else sSay = "You find no signs of activity.";
            }
        nCount ++;
        sScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
        }
    }
SetCustomToken(366,sSay);
}
