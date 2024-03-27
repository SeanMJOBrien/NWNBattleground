#include "spawn_functions"
#include "ps_timestamp"
#include "ps_mpop_process"
void main()
{
if (GetIsPC(GetEnteringObject()) == TRUE)
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oScan;
DeleteLocalString(GetEnteringObject(),"NARRATION");
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
        int nRoll = d100();
        if (GetTag(oScan) == "MPOP_first")
            {
            if (nRoll <= 80) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if (GetTag(oScan) == "MPOP_second")
            {
            if (nRoll <= 60) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        else if (GetTag(oScan) == "MPOP_third")
            {
            if (nRoll <= 40) NESS_ActivateSpawn(oScan);
            else NESS_DeactivateSpawn(oScan);
            }
        oScan = GetNextObjectInArea();
        }
    AdvanceTimeStamp(oArea,0,0,1,0);
    }
int nRaining = GetLocalInt(oModule,"Raining");
if ((GetLocalInt(oModule,"nStampDay2") == 0) || (GetIsLaterThan(oModule,2)))
    {
    if ((nRaining) && (d100() <= 50)) nRaining = FALSE;
    else if ((!nRaining) && (d100() <= 20)) nRaining = TRUE;
    SetLocalInt(oModule,"Raining",nRaining);

    AdvanceTimeStamp(oModule,0,0,1,0,2);
    }
int nOnlyPC = TRUE;
oScan = GetFirstObjectInArea();
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (oScan != GetEnteringObject()))
        {
        nOnlyPC = FALSE;
        break;
        }
    oScan = GetNextObjectInArea();
    }
if ((!GetIsAreaInterior(oArea)) && (nOnlyPC))
    {
    int nMonth = GetCalendarMonth();
    int nChooseAmbDay;
    int nChooseAmbNight;
    int nChooseWeather;
    int nChooseSky = SKYBOX_NONE;
    if (((nMonth > 2) && (nMonth != 12)) && (!nRaining))
        {
        nChooseWeather = WEATHER_CLEAR;
        if (GetSkyBox(oArea) != SKYBOX_NONE) nChooseSky = SKYBOX_GRASS_CLEAR;
        switch (d4())
            {
            case 1: nChooseAmbDay = 30; break;
            case 2: nChooseAmbDay = 49; break;
            case 3: nChooseAmbDay = 50; break;
            case 4: nChooseAmbDay = 51; break;
            }
        switch (d2())
            {
            case 1: nChooseAmbNight = 53; break;
            case 2: nChooseAmbNight = 54; break;
            }
        }
    else if (((nMonth > 2) && (nMonth != 12)) && (nRaining))
        {
        nChooseWeather = WEATHER_RAIN;
        if (GetSkyBox(oArea) != SKYBOX_NONE) nChooseSky = SKYBOX_GRASS_STORM;
        switch (d4())
            {
            case 1: nChooseAmbNight = 38; nChooseAmbDay = 38; break;
            case 2: nChooseAmbNight = 39; nChooseAmbDay = 39; break;
            case 3: nChooseAmbNight = 40; nChooseAmbDay = 40; break;
            case 4: nChooseAmbNight = 41; nChooseAmbDay = 41; break;
            }
        }
    else if (((nMonth <= 2) && (nMonth == 12)) && (!nRaining))
        {
        nChooseWeather = WEATHER_CLEAR;
        if (GetSkyBox(oArea) != SKYBOX_NONE) nChooseSky = SKYBOX_WINTER_CLEAR;
        switch (d4())
            {
            case 1: nChooseAmbDay = 30; break;
            case 2: nChooseAmbDay = 49; break;
            case 3: nChooseAmbDay = 50; break;
            case 4: nChooseAmbDay = 51; break;
            }
        switch (d2())
            {
            case 1: nChooseAmbNight = 53; break;
            case 2: nChooseAmbNight = 54; break;
            }
        }
    else if (((nMonth <= 2) && (nMonth == 12)) && (nRaining))
        {
        nChooseWeather = WEATHER_SNOW;
        SetWeather(oArea,WEATHER_CLEAR);
        if (GetSkyBox(oArea) != SKYBOX_NONE) nChooseSky = SKYBOX_ICY;
        switch (d4())
            {
            case 1: nChooseAmbDay = 30; break;
            case 2: nChooseAmbDay = 49; break;
            case 3: nChooseAmbDay = 50; break;
            case 4: nChooseAmbDay = 51; break;
            }
        switch (d2())
            {
            case 1: nChooseAmbNight = 53; break;
            case 2: nChooseAmbNight = 54; break;
            }
        }
    if (!GetLocalInt(oArea,"KeepAmbSound"))
        {
        AmbientSoundChangeDay(oArea,nChooseAmbDay);
        AmbientSoundChangeNight(oArea,nChooseAmbNight);
        }
    SetSkyBox(nChooseSky,oArea);
    SetWeather(oArea,nChooseWeather);
    }
}

  Spawn_OnAreaEnter();

}
