#include "ps_merchchange"
#include "ps_hench_leave"
#include "spawn_functions"
#include "ps_timestamp"
#include "ps_mpop_process"
#include "ps_questitems"
void main()
{
Spawn_OnAreaEnter();

if (GetIsPC(GetEnteringObject()) == TRUE)
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oScan;
object oPC = GetEnteringObject();
object oHenchman = GetHenchman(oPC);
int nPCPresent = FALSE;
oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (oScan != oPC))
        {
        nPCPresent = TRUE;
        break;
        }
    oScan = GetNextObjectInArea(oArea);
    }

//DelayCommand(1.0,SendMessageToPC(oPC,"Next MPOP Process in: "+SayHours(GetHoursTill(oModule,1))));
if ((oHenchman != OBJECT_INVALID)
        && ((GetHoursTill(oHenchman,1) + GetLocalInt(oPC,"DebitHour")) < 1 ))
    {
    SendMessageToPC(oPC,"Your hireling's commissioned time has expired.");
    PS_RemoveHenchman(oHenchman,oPC);
    }
DeleteLocalString(GetEnteringObject(),"NARRATION");
int nNumber;
int nChance;
if ((!nPCPresent) &&
//    ((GetLocalInt(oArea,"nStampDay1") == 0) || (GetIsLaterThan(oArea))))
    (GetLocalInt(oArea,"DenyReset") == FALSE))
    {
    oScan = GetFirstObjectInArea();
    while (oScan != OBJECT_INVALID)
        {
        int nRoll = d100();
        if (GetTag(oScan) == "MPOP_first")
            {
            nChance = 60;
            if (GetLocalInt(oScan,"CHANCE")!= 0) nChance = GetLocalInt(oScan,"CHANCE");
            if (nRoll <= nChance) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else if (GetTag(oScan) == "MPOP_second")
            {
            nChance = 50;
            if (GetLocalInt(oScan,"CHANCE")!= 0) nChance = GetLocalInt(oScan,"CHANCE");
            if (nRoll <= nChance) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else if (GetTag(oScan) == "MPOP_third")
            {
            nChance = 40;
            if (GetLocalInt(oScan,"CHANCE")!= 0) nChance = GetLocalInt(oScan,"CHANCE");
            if (nRoll <= nChance) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else if (GetTag(oScan) == "MPOP_chest")
            {
            nChance = 100;
            if (GetLocalInt(oScan,"CHANCE")!= 0) nChance = GetLocalInt(oScan,"CHANCE");
            if (nRoll <= nChance) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        oScan = GetNextObjectInArea();
        }
//    AdvanceTimeStamp(oArea,0,0,0,6);
    }
int nRaining = GetLocalInt(oModule,"Raining");
int nRainingNow;
int nMonth = GetCalendarMonth();
if ((GetLocalInt(oModule,"nStampDay2") == 0) || (GetIsLaterThan(oModule,2)))
    {
    if ((nRaining) && (d100() <= 50)) nRainingNow = FALSE;
    else if ((!nRaining) && (d100() <= 10)) nRainingNow = TRUE;
    SetLocalInt(oModule,"Raining",nRainingNow);
    AdvanceTimeStamp(oModule,0,0,1,0,2);
    if ((nMonth > 2) && (nMonth != 12))
        {
        if ((!nRainingNow) && (nRaining)) SetWeather(oModule,WEATHER_CLEAR);
        else if ((nRainingNow) && (!nRaining)) SetWeather(oModule,WEATHER_RAIN);
        }
    else
        {
        if ((!nRainingNow) && (nRaining)) SetWeather(oModule,WEATHER_CLEAR);
        else if ((nRainingNow) && (!nRaining))
            {
            SetWeather(oModule,WEATHER_CLEAR);
            SetWeather(oModule,WEATHER_SNOW);
            }
        }
    }
if (GetLocalInt(oModule,"nStampDay1") == 0) AdvanceTimeStamp(oModule,0,0,1,0);
else if (GetIsLaterThan(oModule))
    {
    DetermineQuestsItems(TRUE);
    MerchantDaychange(GetObjectByTag("STORE_MERCH1"));
    MerchantDaychange(GetObjectByTag("STORE_MERCH2"));
    TimeStamp(oModule,1);
    AdvanceTimeStamp(oModule,0,0,1,0,1);
    MPOP_Process();
    }
}


}
