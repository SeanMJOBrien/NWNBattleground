// Pete Smith's OnRest Module Event function Feb. '05

#include "ps_hench_leave"
#include "ps_timestamp"
#include "ps_mod_data"
#include "spawn_functions"


void main()
{
//SpawnScriptDebugger();
object oPC=GetLastPCRested();
int nRestType=GetLastRestEventType();
string sSay;
int nNumber; // misc number holder for counters and what not
object oScan;
int nFood = 0; // tagged FOOD
// Now some level / HP enumerations.
int nLevel;
float fNumber;
int nHealBonus = GetLocalInt(oPC,"HealBonus");
nLevel = GetLevelByPosition(1,oPC) + GetLevelByPosition(2,oPC) + GetLevelByPosition(3,oPC);
int nHeal = nLevel + (2 * (GetAbilityModifier(ABILITY_CONSTITUTION,oPC)) + nHealBonus);
int nMaxHP = GetMaxHitPoints(oPC);
int nCurrentHP = GetCurrentHitPoints(oPC);
int nTargetHP;
int nDayBuffer;
int nFoodBonus = 0;
effect eHPAdjust;
effect eBlindness = EffectBlindness();
effect eSleep = EffectVisualEffect(VFX_IMP_SLEEP,FALSE);
if (nRestType == REST_EVENTTYPE_REST_STARTED)
    {
    object oLegalRest = GetNearestObjectByTag("LEGALREST",oPC);
    if ((oLegalRest == OBJECT_INVALID)
        || (GetArea(oLegalRest) != GetArea(oPC))
        || (GetDistanceBetween(oLegalRest,oPC) > 5.0)
        || (GetDistanceBetween(oLegalRest,oPC) == 0.0))
        {
        AssignCommand(oPC,ClearAllActions());
        SendMessageToPC(oPC,"You may not legally rest.");
        return;
        }
    int nFoodBonus;
    int nHighestNeeded = nMaxHP - nCurrentHP - nHeal;
    int nFoodPresent = FALSE;
    int nCurrentHighest;
    int nBreakLoop = FALSE;
    int nLoops = 0;
    object oChoose = OBJECT_INVALID;
    while ((nBreakLoop != TRUE) && (nLoops < 500))
        {
        nLoops ++;
        nFoodPresent = FALSE;
        oChoose = OBJECT_INVALID;
        nCurrentHighest = 0;
        oScan = GetFirstItemInInventory(oPC);
            while (oScan != OBJECT_INVALID)
                {
                if ((GetLocalInt(oScan,"FOOD") != 0) && (GetLocalInt(oScan,"DELETE") == FALSE))
                    {
                    nFoodPresent = TRUE;
                    if (((GetLocalInt(oScan,"FOOD") > nCurrentHighest) && ((nCurrentHighest + nFoodBonus) < nHighestNeeded)) ||
                         ((GetLocalInt(oScan,"FOOD") < nCurrentHighest)  && ((GetLocalInt(oScan,"FOOD") + nFoodBonus) >= nHighestNeeded)) ||
                         (nCurrentHighest <= 0))
                    {
                    oChoose = oScan;
                    nCurrentHighest = GetLocalInt(oChoose,"FOOD");
                    }
                    }
                oScan = GetNextItemInInventory(oPC);
                }
             if (nFoodPresent == FALSE)
                {
                if (nFoodBonus == 0)
                    {
                    AssignCommand(oPC,ClearAllActions());
                    SendMessageToPC(oPC,"Food is required to rest.");
                    return;
                    }
                else nBreakLoop = TRUE;
                }
             if (oChoose != OBJECT_INVALID)
                {
                nFoodBonus += GetLocalInt(oChoose,"FOOD");
                if (GetItemCharges(oChoose) > 1)
                    {
                    SetItemCharges(oChoose,(GetItemCharges(oChoose) - 1));
                    }
                else if (GetItemStackSize(oChoose) > 1)
                    SetItemStackSize(oChoose,(GetItemStackSize(oChoose)-1));
                else
                    {
                    SetLocalInt(oChoose,"DELETE",TRUE);
                    DestroyObject(oChoose);
                    }
                }
             if ((nFoodBonus >= nHighestNeeded) ||
                (nFoodBonus >= (2 * (nHeal - nHealBonus))))
                nBreakLoop = TRUE;
        }
    SetLocalInt(oPC,"RestHP",nCurrentHP);
    SetLocalInt(oPC,"FoodBonus",nFoodBonus);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBlindness,oPC,13.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,oPC,6.0);
    } //if (nRestType == REST_EVENTTYPE_REST_STARTED)


if ((nRestType == REST_EVENTTYPE_REST_CANCELLED) || (nRestType == REST_EVENTTYPE_REST_INVALID))
    {
    DeleteLocalInt(oPC,"RestHP");
    DeleteLocalInt(oPC,"FoodBonus");
    }


if (nRestType == REST_EVENTTYPE_REST_FINISHED)
    {
    DeleteLocalInt(oPC,"HoursTraveled");
    nHeal += GetLocalInt(oPC,"FoodBonus");
    nTargetHP = GetLocalInt(oPC,"RestHP") + nHeal;
    DeleteLocalInt(oPC,"RestHP");
    DeleteLocalInt(oPC,"FoodBonus");

    if (nHealBonus > 0)
        {
        SendMessageToPC(oPC,"You benefit from the healing balm on your wounds.");
        DeleteLocalInt(oPC,"HealBonus");
        }
    nNumber = GetCurrentHitPoints(oPC) - nTargetHP;
    eHPAdjust = EffectDamage(nNumber,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY);
    if (nNumber > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT,eHPAdjust,oPC);
    DeleteLocalObject(oPC,"RestFood");
    DeleteLocalInt(oPC,"RestHP");
    int nDebitHour = GetLocalInt(oPC,"DebitHour");
    int nHoursSince = GetHoursTill(oPC,5);
    int nRestHours = 6 + (abs(nHoursSince)/2);
    if (nRestHours < 6) nRestHours = 6;
    if (nRestHours > 12) nRestHours = 12;
    if ((nDebitHour - nRestHours) > 0)
        {
        nDebitHour -= nRestHours;
        SetLocalInt(oPC,"DebitHour",nDebitHour);
        SendMessageToPC(oPC,"You have not advanced time by resting. You are still debited "+SayHours(nDebitHour)+".");
        }
    else if ((nDebitHour - nRestHours) == 0)
        {
        DeleteLocalInt(oPC,"DebitHour");
        SendMessageToPC(oPC,"You have not advanced time by resting, though you are no longer debited any time.");
        }
    else
        {
        nRestHours -= nDebitHour;
        SetTime((GetTimeHour() + nRestHours),0,0,0);
        object oScan = GetFirstPC();
        while (oScan != OBJECT_INVALID)
            {
            if (oScan == oPC)
                {
                SendMessageToPC(oPC,"Your resting has advanced time "+SayHours(nRestHours)+". "+SayGreyhawkDateTime());
                }
            else
                {
                AdvanceTimeStamp(oScan,0,0,0,nRestHours,5);
                nNumber = GetLocalInt(oScan,"DebitHour") + nRestHours;
                SetLocalInt(oScan,"DebitHour",nNumber);
                SendMessageToPC(oScan,GetName(oPC)+"'s resting has advanced time "+SayHours(nRestHours)+". You are now debited "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
                }
            oScan = GetNextPC();
            }


        }
    TimeStamp(oPC,5);
    SaveTime(oPC);
//if (GetLocalInt(GetModule(),"TreasureChange") == TRUE)
//    {
//    SaveTreasure();
//    SetLocalInt(GetModule(),"TreasureChange",FALSE);
//    }
    SendMessageToAllDMs(GetName(oPC)+"'s resting has advanced time "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
    PrintString(SayLogTime()+" "+GetName(oPC)+" rested.");
object oHenchman = GetHenchman(oPC);
if (((GetHoursTill(oHenchman,1) + GetLocalInt(oPC,"DebitHour")) < 1 )
    && (oHenchman != OBJECT_INVALID))
    {
    SendMessageToPC(oPC,"Your hireling's commissioned time has expired.");
    PS_RemoveHenchman(oHenchman,oPC);
    }

    }
}
