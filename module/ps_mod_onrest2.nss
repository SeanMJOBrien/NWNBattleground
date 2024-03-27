// Pete Smith's OnRest Module Event function Feb. '05

#include "ps_hench_leave"
#include "ps_timestamp"
#include "ps_mod_data"
#include "spawn_functions"


void main()
{
object oPC=GetLastPCRested();
int nRestType=GetLastRestEventType();
string sSay;
int nNumber; // misc number holder for counters and what not
object oScan;
int nBestFood = 0; // tagged BESTFOOD
int nGoodFood = 0; // tagged GOODFOOD
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
        nNumber = FALSE; // TRUE if any food present after scanning.
        oScan = GetFirstItemInInventory(oPC);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "BESTFOOD")
                {
                if (GetIsLaterThan(oScan) == 1)
                    {
                    SendMessageToPC(oPC,"Your "+GetName(oScan)+" has spoiled.");
                    DestroyObject(oScan);
                    //CreateItemOnObject("ps_spoiledfood",oPC);
                    }
                    else
                        {
                        nBestFood ++;
                        nNumber = TRUE;
                        }
                }
            oScan = GetNextItemInInventory(oPC);
            } // while ...
        oScan = GetFirstItemInInventory(oPC);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "GOODFOOD")
                {
                if (GetIsLaterThan(oScan) == 1)
                    {
                    SendMessageToPC(oPC,"Your "+GetName(oScan)+" has spoiled.");
                    DestroyObject(oScan);
                    //CreateItemOnObject("ps_spoiledfood",oPC);
                    }
                    else
                        {
                        nGoodFood ++;
                        nNumber = TRUE;
                        }
                }
            oScan = GetNextItemInInventory(oPC);
            } // while ...
        oScan = GetFirstItemInInventory(oPC);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "FOOD")
                {
                nFood ++;
                nNumber = TRUE;
                }
            oScan = GetNextItemInInventory(oPC);
            } // while ...

        if (nNumber == FALSE) // PC has no food!
            {
            AssignCommand(oPC,ClearAllActions());
            SendMessageToPC(oPC,"Food is required to rest.");
            return;
            }
        else if (nBestFood > 0)
            {
            // PC has best food and could use it
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"BESTFOOD"));
            }
        else if (nGoodFood > 0)
            {
            // PC has good food and could use it.
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"GOODFOOD"));
            }
        else if (nFood > 0)
            {
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"FOOD"));
            }
        SetLocalInt(oPC,"RestHP",nCurrentHP);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBlindness,oPC,13.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,oPC,6.0);
    } //if (nRestType == REST_EVENTTYPE_REST_STARTED)


if ((nRestType == REST_EVENTTYPE_REST_CANCELLED) || (nRestType == REST_EVENTTYPE_REST_INVALID))
    {
    DeleteLocalObject(oPC,"RestFood");
    DeleteLocalInt(oPC,"RestHP");
    }


if (nRestType == REST_EVENTTYPE_REST_FINISHED)
    {
    DeleteLocalInt(oPC,"HoursTraveled");
    oScan = GetLocalObject(oPC,"RestFood");
    if (GetTag(oScan) == "BESTFOOD") nHeal *= 4;
    if (GetTag(oScan) == "GOODFOOD") nHeal *= 2;
//    if (GetTag(oScan) == "FOOD") nHeal += nLevel * 2;
//    SendMessageToPC(oPC,"You've consumed "+GetName(oScan)+".");
    DestroyObject(oScan);
    //SpawnScriptDebugger();
    nTargetHP = GetLocalInt(oPC,"RestHP");;
    while (nHeal > 0)
        {
        if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.60)
            {
            nHeal -= 1;
            nTargetHP ++;
            }
        else if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.84)
            {
            if (nHeal > 1)
                {
                nHeal -= 2;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        else if ((IntToFloat(nTargetHP) / IntToFloat(nMaxHP)) <= 0.94)
            {
            if (nHeal > 3)
                {
                nHeal -= 3;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        else
            {
            if (nHeal > 3)
                {
                nHeal -= 4;
                nTargetHP ++;
                }
            else nHeal = 0;
            }
        } //while (nHeal > 0)

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
if (GetLocalInt(GetModule(),"TreasureChange") == TRUE)
    {
    SaveTreasure();
    SetLocalInt(GetModule(),"TreasureChange",FALSE);
    }
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
