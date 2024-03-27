#include "spawn_functions"
#include "ps_timestamp"
#include "ps_mpop_process"
void main()
{
if (GetIsPC(GetEnteringObject()) == TRUE)
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oScan = GetFirstObjectInArea();
object oMPOP;
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

if (GetLocalInt(oModule,"nStampDay1") == 0) AdvanceTimeStamp(oModule,0,0,1,0);
else if (GetIsLaterThan(oModule))
    {
    MPOP_Process();
    AdvanceTimeStamp(oModule,0,0,1,0);
    }
int nNumber;
if ((GetLocalInt(oArea,"nStampDay1") == 0) || (GetIsLaterThan(oArea)))
    {
    oScan = GetFirstObjectInArea();
    while (oScan != OBJECT_INVALID)
        {
        string sScanTag = GetTag(oScan);
        int nRoll = d100();
        if ((sScanTag == "MPOP_first") && (nUnderAttack))
            {
            if (nRoll <= 80) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_second") && (nUnderAttack))
            {
            if (nRoll <= 60) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if ((sScanTag == "MPOP_third") && (nUnderAttack))
            {
            if (nRoll <= 40) NESS_ActivateSpawn(oScan);
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
        oScan = GetNextObjectInArea();
        }
    AdvanceTimeStamp(oArea,0,0,1,0);
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
    if ((nRaining) && (d100() <= 60)) nRainingNow = FALSE;
    else if ((!nRaining) && (d100() <= 20)) nRainingNow = TRUE;
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
object oPC = GetEnteringObject();
if (!nUnderAttack) SetLocalInt(oPC,"LegalRest",1);

}

  Spawn_OnAreaEnter();
}
