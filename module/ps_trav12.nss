#include "ps_timestamp"

int StartingConditional()
{
object oPC = GetPCSpeaker();
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
int nHoursHunted;
int nRangerBonus = GetLevelByClass(CLASS_TYPE_RANGER,oPC) + GetLevelByClass(CLASS_TYPE_DRUID,oPC);
string sSay;
int nBreakTravel;
for (nHoursHunted = 1; nHoursHunted < 4; nHoursHunted ++)
    {
    if ((d20() + nRangerBonus + GetAbilityModifier(ABILITY_WISDOM,oPC)) >= 18)
        {
        SetLocalInt(oPC,"Hunting",TRUE);
        sSay = "You spot something after "+IntToString(nHoursHunted)+" hour";
        if (nHoursHunted > 1) sSay = sSay + "s";
        sSay = sSay + " of hunting.";
        SetCustomToken(357,sSay);
        break;
        }
    if (d20() == 1)
        {
        sSay = "After "+IntToString(nHoursHunted)+" hour";
        if (nHoursHunted > 1) sSay = sSay +"s ";
        sSay = sSay +" you spot movement a stone's throw away. ";
        SetLocalInt(oPC,"Encounter",1);
        SetLocalString(oPC,"ActionText",sSay);
        break;
        }
    }
nHoursTraveled += nHoursHunted;
AdvanceTimeStamp(oPC,0,0,0,nHoursHunted,7);
SetLocalInt(oPC,"HoursTraveled",nHoursTraveled);
if ((!GetLocalInt(oPC,"Hunting")) && (!GetLocalInt(oPC,"Encounter")))
    {
    sSay = "After "+IntToString(nHoursHunted)+" hour";
    if (nHoursHunted > 1) sSay = sSay + "s";
    sSay = sSay + " you fail to find any wild game.";
    SetLocalString(oPC,"ActionText",sSay);
    return FALSE;
    }
if (GetLocalInt(oPC,"Hunting")) return TRUE;
return FALSE;
}
