// Pete Smith's OnRest Module Event function Dec. '04

#include "ps_hench_leave"
#include "ps_timestamp"
#include "ps_mod_data"
#include "spawn_functions"
// PCs heal (LVL + Con bonus) per rest period.
// Good food doubles this, and the best foods triple this.
// The drawback of these better foods is that they spoil and are pricey.


void main()
{
object oPC=GetLastPCRested();
int nRestType=GetLastRestEventType();
//int nHoursBetweenRest = 4; // Self-explanatory, tweak this to change the rest times.
string sSay;
int nNumber; // misc number holder for counters and what not
object oScan;
int nBestFood = 0; // tagged BESTFOOD
int nGoodFood = 0; // tagged GOODFOOD
int nFood = 0; // tagged FOOD
// Now some level / HP enumerations.
int nLevel;
float fNumber;
nLevel = GetLevelByPosition(1,oPC) + GetLevelByPosition(2,oPC) + GetLevelByPosition(3,oPC);
int nHeal = nLevel + GetAbilityModifier(ABILITY_CONSTITUTION,oPC);
int nMaxHP = GetMaxHitPoints(oPC);
int nCurrentHP = GetCurrentHitPoints(oPC);
int nTargetHP;
int nDayBuffer;

effect eHPAdjust;
effect eBlindness = EffectBlindness();
effect eSleep = EffectVisualEffect(VFX_IMP_SLEEP,FALSE);
if (nRestType == REST_EVENTTYPE_REST_STARTED)
    {
// First check to see if the PC has waited their alotted time to rest.
// This is always a timestamp on the PC in slot 5.
// Also, check if there is a LocalInt on the PC called "InnRest".
// If this is so the PC is in an Inn room and may bypass the time restriction.
    if (GetLocalInt(oPC,"LegalRest") == 0)
        {
        AssignCommand(oPC,ClearAllActions());
        SendMessageToPC(oPC,"You are not in a legal rest area.");
        return;
        }
//    oScan = GetFirstPC();
//    while (oScan != OBJECT_INVALID)
//        {
//        fNumber = GetDistanceBetween(oPC,oScan);
//        if (((fNumber >= 20.0f) || (fNumber == 0.0)) && (oScan != oPC) && (GetLocalInt(oScan,"Comatose") != TRUE))
//            {
//            AssignCommand(oPC,ClearAllActions());
//            SendMessageToPC(oPC,"All active PCs must be within 20 meters for you to rest.");
//            return;
//            }
//        oScan = GetNextPC();
//        }

    if  (GetLocalInt(oPC,"LegalRest") == TRUE)
        {
// Check to see if the PC has food to rest. Select the food and write it on
// the PC as a local object, which will be consumed if the PC completes their rest.
// Player will always eat the food which will maximize their healing.
// Food has a timestamp which is its expiration date.
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
        else if (((nMaxHP - nCurrentHP) > (nHeal * 2)) && (nBestFood > 0))
            {
            // PC has best food and could use it
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"BESTFOOD"));
            }
        else if (((nMaxHP - nCurrentHP) > (nHeal)) && (nGoodFood > 0))
            {
            // PC has good food and could use it.
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"GOODFOOD"));
            }
        else if (nFood > 0)
            {
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"FOOD"));
            }
        else if (nGoodFood > 0)
            { // PC doesn't need good food but that's what is available
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"GOODFOOD"));
            }
        else if (nBestFood > 0)
            { // PC doesn't need best food but that's what's available
            SetLocalObject(oPC,"RestFood",GetItemPossessedBy(oPC,"BESTFOOD"));
            }
        SetLocalInt(oPC,"RestHP",nCurrentHP);
        } //if (GetIsLaterThan(oPC,5) == TRUE)
//    FadeToBlack(oPC,FADE_SPEED_SLOW);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBlindness,oPC,13.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,oPC,6.0);
// Some debugging messages:
//    SendMessageToPC(oPC,IntToString(nFood)+" food, "+IntToString(nGoodFood)+" good food, "+IntToString(nBestFood)+" best food enumerated.");
//    SendMessageToPC(oPC,GetTag(GetLocalObject(oPC,"RestFood"))+" stored.");
//    SendMessageToPC(oPC,"TimeStamp reads: "+IntToString(GetLocalInt(oPC,"nStampYear5"))+", "+IntToString(GetLocalInt(oPC,"nStampMonth5"))+", "+IntToString(GetLocalInt(oPC,"nStampDay5"))+", "+IntToString(GetLocalInt(oPC,"nStampHour5"))+".");
//    SendMessageToPC(oPC,"GetIsLaterThan returns "+IntToString(GetIsLaterThan(oPC,5)));
    } //if (nRestType == REST_EVENTTYPE_REST_STARTED)


if ((nRestType == REST_EVENTTYPE_REST_CANCELLED) || (nRestType == REST_EVENTTYPE_REST_INVALID))
    {
//    FadeFromBlack(oPC,FADE_SPEED_SLOW);
    DeleteLocalObject(oPC,"RestFood");
    DeleteLocalInt(oPC,"RestHP");
//    RemoveEffect(oPC,eBlindness);
    }


if (nRestType == REST_EVENTTYPE_REST_FINISHED)
    {
    DeleteLocalInt(oPC,"HoursTraveled");
    oScan = GetLocalObject(oPC,"RestFood");
    if (GetTag(oScan) == "BESTFOOD") nNumber = nHeal * 3;
    if (GetTag(oScan) == "GOODFOOD") nNumber = nHeal * 2;
    if (GetTag(oScan) == "FOOD") nNumber = nHeal;
//    SendMessageToPC(oPC,"You've consumed "+GetName(oScan)+".");
    DestroyObject(oScan);
    nTargetHP = GetLocalInt(oPC,"RestHP") + nNumber;
    int nHealBonus = GetLocalInt(oPC,"HealBonus");
    if (nHealBonus > 0)
        {
        SendMessageToPC(oPC,"You benefit from the healing balm on your wounds.");
        nTargetHP += nHealBonus;
        DeleteLocalInt(oPC,"HealBonus");
        }
    nNumber = GetCurrentHitPoints(oPC) - nTargetHP;
    eHPAdjust = EffectDamage(nNumber,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY);
    if (nNumber > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT,eHPAdjust,oPC);
//    FadeFromBlack(oPC,FADE_SPEED_SLOW);
    DeleteLocalObject(oPC,"RestFood");
    DeleteLocalInt(oPC,"RestHP");
//    DeleteTimeStamp(oPC,5);
//    AdvanceTimeStamp(oPC,0,0,0,nHoursBetweenRest,5);
//    RemoveEffect(oPC,eBlindness);
    int nDebitHour = GetLocalInt(oPC,"DebitHour");
    int nHoursSince = GetHoursTill(oPC,5);
    int nRestHours = 12 + nHoursSince;
    if (nRestHours < 6) nRestHours = 6;
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
    SendMessageToAllDMs(GetName(oPC)+"'s resting has advanced time "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
    PrintString(SayLogTime()+" "+GetName(oPC)+" rested.");
object oHenchman = GetHenchman(oPC);
if (((GetHoursTill(oHenchman,1) + GetLocalInt(oPC,"DebitHour")) < 1 )
    && (oHenchman != OBJECT_INVALID))
    {
    SendMessageToPC(oPC,"Your hireling's commissioned time has expired.");
    PS_RemoveHenchman(oHenchman,oPC);
    }
    if ((GetName(GetArea(oPC)) == "Wilderness")
        && (GetLocalString(GetArea(oPC),"Encounter") != "")
        && (GetLocalInt(GetArea(oPC),"DoEncounter") == FALSE)
        && (d10() == 1))
            {
            int nAppearing = GetLocalInt(GetArea(oPC),"Appearing");
            object oSpawnWP = GetNearestObjectByTag(("WILDENC" + IntToString(nAppearing)),oPC);
            if (oSpawnWP != OBJECT_INVALID)
                {
                NESS_ActivateSpawn(oSpawnWP);
                SetLocalInt(GetArea(oPC),"DoEncounter",1);
                }
            }

    }
}
