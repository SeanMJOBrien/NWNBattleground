#include "ps_merchchange"
#include "ps_hench_leave"
#include "spawn_functions"
#include "ps_timestamp"
#include "ps_mpop_process"
#include "ps_questitems"
void main()
{
if (GetIsPC(GetEnteringObject()) == TRUE)
{
DeleteLocalString(GetEnteringObject(),"NARRATION");
object oPC = GetEnteringObject();
    DeleteLocalInt(oPC,"Topic");
    DeleteLocalInt(oPC,"Entry");
object oHenchman = GetHenchman(oPC);
if ((oHenchman != OBJECT_INVALID)
        && ((GetHoursTill(oHenchman,1) + GetLocalInt(oPC,"DebitHour")) < 1 ))
    {
    SendMessageToPC(oPC,"Your hireling's commissioned time has expired.");
    PS_RemoveHenchman(oHenchman,oPC);
    }
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oScan;
object oMPOP;
int nPCPresent = FALSE;
oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (oScan != oPC)) nPCPresent = TRUE;
    oScan = GetNextObjectInArea(oArea);
    }
oScan = GetFirstObjectInArea(oArea);
DelayCommand(1.0,SendMessageToPC(oPC,"Next MPOP Process in: "+SayHours(GetHoursTill(oModule,1))));

while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "MPOP")
        {
        oMPOP = oScan;
        break;
        }
    oScan = GetNextObjectInArea();
    }
if (oMPOP == OBJECT_INVALID) oMPOP = GetNearestObjectByTag("MPOP",GetWaypointByTag(GetTag(oArea)));
int nCount;
int nUnderAttack = FALSE;
for (nCount = 1; nCount < 5; nCount++)
    {
    if (GetLocalString(oMPOP,"Pop"+IntToString(nCount)) == "") continue;
    if (GetSubString(GetLocalString(oMPOP,"Pop"+IntToString(nCount)),0,4) != "SHLD")
        {
        nUnderAttack = TRUE;
        }
    }
SetLocalInt(oArea,"UnderAttack",nUnderAttack);
if (GetLocalInt(oModule,"nStampDay1") == 0) AdvanceTimeStamp(oModule,0,0,1,0);
else if (GetIsLaterThan(oModule))
    {
    DetermineQuestsItems(TRUE);
    MerchantDaychange(GetObjectByTag("STORE_MERCH1"));
    MerchantDaychange(GetObjectByTag("STORE_MERCH2"));
    MPOP_Process();
    TimeStamp(oModule,1);
    AdvanceTimeStamp(oModule,0,0,1,0,1);
    }
int nNumber;
if  ((!nPCPresent) &&
    ((GetLocalInt(oArea,"nStampDay1") == 0) || (GetIsLaterThan(oArea))))
    {
    oScan = GetFirstObjectInArea();
    while (oScan != OBJECT_INVALID)
        {
        string sScanTag = GetTag(oScan);
        int nRoll = d100();
        if ((sScanTag == "MPOP_first") && (nUnderAttack))
            {
            if (nRoll <= 70) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_second") && (nUnderAttack))
            {
            if (nRoll <= 60) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_third") && (nUnderAttack))
            {
            if (nRoll <= 50) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_first") && (!nUnderAttack))
            {
            NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else if ((sScanTag == "MPOP_second") && (!nUnderAttack))
            {
            NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_third") && (!nUnderAttack))
            {
            NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "carnage") && (!nUnderAttack))
            {
            NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "carnage") && (nUnderAttack))
            {
            NESS_ActivateSpawn(oScan);
            }
        else if ((GetSubString(GetName(oScan),0,2) == "SP") && (nUnderAttack))
            {
            NESS_DeactivateSpawn(oScan);
            }
        else if ((GetSubString(GetName(oScan),0,2) == "SP") && (!nUnderAttack))
            {
            NESS_ActivateSpawn(oScan);
            }
        else if ((GetName(oScan) == "Narration - Day/Night") && (nUnderAttack))
            SetLocalInt(oScan,"Deactivate",1);
        else if ((GetName(oScan) == "Narration - Day/Night") && (!nUnderAttack))
            DeleteLocalInt(oScan,"Deactivate");
        oScan = GetNextObjectInArea();
        }
    AdvanceTimeStamp(oArea,0,0,0,6);
    if (!GetIsAreaInterior(oArea))
        {
        int nSHLDPresent = FALSE;
        for (nCount = 1; nCount <5; nCount++)
            {
            if (GetSubString(GetLocalString(oMPOP,"Pop"+IntToString(nCount)),0,4) == "SHLD")
              nSHLDPresent = TRUE;
            }
        if (!nUnderAttack)
            {
            AmbientSoundChangeDay(OBJECT_SELF,10);
            AmbientSoundChangeNight(OBJECT_SELF,11);
            }
        else if ((nUnderAttack) && (nSHLDPresent))
            {
            AmbientSoundChangeDay(OBJECT_SELF,24);
            AmbientSoundChangeNight(OBJECT_SELF,24);
            }
        else if ((nUnderAttack) && (!nSHLDPresent))
            {
            AmbientSoundChangeDay(OBJECT_SELF,58);
            AmbientSoundChangeNight(OBJECT_SELF,58);
            }
        }
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
}
  Spawn_OnAreaEnter();
}
