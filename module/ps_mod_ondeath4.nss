#include "ps_timestamp"

void main()
{
//SpawnScriptDebugger();
object oPC = GetLastPlayerDied();
object oKiller = GetLastHostileActor(oPC);
if (oKiller == OBJECT_INVALID) oKiller = GetLocalObject(oPC,"LastHostile");
DeleteLocalObject(oPC,"LastHostile");
if (GetIsPossessedFamiliar(oPC))
    {
    UnpossessFamiliar(oPC);
    return;
    }
int nKilledByPC = FALSE;
object oScan = GetFirstPC();
while (oScan != OBJECT_INVALID)
    {
    if (GetFactionEqual(oKiller,oScan) == TRUE)
        {
        nKilledByPC = TRUE;
        break;
        }
    oScan = GetNextPC();
    }
if (GetName(oKiller) != "") PrintString(SayLogTime() + " " + GetName(oPC)+" was slain by "+GetName(oKiller)+". ");
else PrintString(SayLogTime() + " " + GetName(oPC)+" died. ");
int nOldXP = GetXP(oPC);
int nHD = GetHitDice(oPC);
int nXP = GetXP(oPC) - ((nHD*nHD*nHD) * 10);
int nPercent = FloatToInt((IntToFloat(((nHD*nHD*nHD) * 10))/IntToFloat(nOldXP)) * 100.0);
//int nXP =  GetXP(oPC) - FloatToInt(IntToFloat(GetXP(oPC)) * 0.20);
if (nXP < 1) nXP = 1;
//if (GetLocalInt(oPC,"XPLossTimer") != 1)
//    {
//    SetXP(oPC, nXP);
//    SendMessageToPC(oPC,"You have lapsed into a coma. In 2 minutes you will regain conciousness. You have been penalized "+IntToString(nPercent)+"% of your experience.");
//    SetLocalInt(oPC,"XPLossTimer",1);
//    DelayCommand(600.0,DeleteLocalInt(oPC,"XPLossTimer"));
//    }
//else
//    {
//    SendMessageToPC(oPC,"You have lapsed into a coma. In 2 minutes you will regain conciousness. No experience was lost as it has not been 10 minutes realtime since last death.");
//    }
if (((GetIsLaterThan(oPC,9) == TRUE) || (GetLocalInt(oPC,"nStampYear9") == 0)) && (nKilledByPC == FALSE))
    {
    SetXP(oPC, nXP);
    SendMessageToPC(oPC,"You have lapsed into a coma. In 2 minutes you will regain conciousness. You have been penalized "+IntToString(nPercent)+"% of your experience. You will be immune to experience loss for 2 game days.");
//    SendMessageToPC(oPC,SayTimestamp(oPC,9));
    TimeStamp(oPC,9);
    AdvanceTimeStamp(oPC,0,0,2,0,9);
//    SendMessageToPC(oPC,SayTimestamp(oPC,9));
    }
else if (nKilledByPC == TRUE)
    {
    SendMessageToPC(oPC,"You have lapsed into a coma. In 2 minutes you will regain conciousness. No experience was lost because you were killed by a player character.");
    }
else
    {
    SendMessageToPC(oPC,"You have lapsed into a coma. In 2 minutes you will regain conciousness. No experience was lost as it has not been 2 game days since your last coma.");
    }
SetLocalInt(oPC,"Dead",1);
DelayCommand(120.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC));
DelayCommand(120.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSanctuary(100),oPC,40.0));
DelayCommand(119.0,DeleteLocalInt(oPC,"Dead"));
int nCount = 1;
oScan = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nCount);
while ((GetDistanceBetween(oPC,oScan) < 10.0)
        && (GetDistanceBetween(oPC,oScan) != 0.0)
        && (oScan != OBJECT_INVALID))
        {
        if (!GetIsInCombat(oScan))
            {
            AssignCommand(oScan,ClearAllActions());
            AssignCommand(oScan,ActionMoveAwayFromObject(oPC,FALSE,IntToFloat(2+d10())));
            }
        nCount ++;
        oScan = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nCount);
        }
}
