#include "ps_timestamp"

void SaveStores(object oPC)
{
//SpawnScriptDebugger();
object oStores = GetObjectByTag("ps_storagecrate");

int nCount = 1;
object oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
while (oBuffer != OBJECT_INVALID)
    {
    nCount++;
    oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
    DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
    }

nCount = 1;
object oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
    StoreCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),oScan);
    nCount ++;
    DestroyObject(oScan);
    oScan = GetNextItemInInventory(oStores);
    }
}

void LoadStores(object oPC,object oStores)
{
//SpawnScriptDebugger();
int nCount;
object oBuffer;
string sBuffer;
int nBuffer;

    nCount = 1;
    oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
    DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
    while (oBuffer != OBJECT_INVALID)
        {
        nCount++;
        oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
        DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
        }
}

void SaveTime(object oPC)
{
int nDebitHour = GetLocalInt(oPC,"DebitHour");
int nHour = GetTimeHour();
int nDay = GetCalendarDay();
int nMonth = GetCalendarMonth();
int nYear = GetCalendarYear();
if (nDebitHour > 0)
    {
    nHour -= nDebitHour;
    while (nHour < 0)
        {
        nHour += 24;
        nDay -= 1;
        }
    while (nDay < 1)
        {
        nDay += 28;
        nMonth -= 1;
        }
    while (nMonth < 1)
        {
        nMonth += 12;
        nYear -= 1;
        }
    }
SetCampaignInt("SHIELD_LANDS","TH_"+GetName(oPC),nHour);
SetCampaignInt("SHIELD_LANDS","TD_"+GetName(oPC),nDay);
SetCampaignInt("SHIELD_LANDS","TM_"+GetName(oPC),nMonth);
SetCampaignInt("SHIELD_LANDS","TY_"+GetName(oPC),nYear);
SetCampaignInt("SHIELD_LANDS","HP_"+GetName(oPC),GetCurrentHitPoints(oPC));
}


void LoadTime(object oPC)
{
int nAdvanceHours;
int nHour = GetTimeHour();
int nDay = GetCalendarDay();
int nMonth = GetCalendarMonth();
int nYear = GetCalendarYear();
int nSavedHour = GetCampaignInt("SHIELD_LANDS","TH_"+GetName(oPC));
int nSavedDay = GetCampaignInt("SHIELD_LANDS","TD_"+GetName(oPC));
int nSavedMonth = GetCampaignInt("SHIELD_LANDS","TM_"+GetName(oPC));
int nSavedYear = GetCampaignInt("SHIELD_LANDS","TY_"+GetName(oPC));
int nHP = GetCampaignInt("SHIELD_LANDS","HP_"+GetName(oPC));
if ((nHP < GetCurrentHitPoints(oPC)) && (nHP > 0))
    {
    int nDamage = GetCurrentHitPoints(oPC) - nHP;
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage),oPC);
    }
if (nSavedYear == 0) return;
int nNumber;

if (nSavedYear != 0)
    {
    nAdvanceHours = ((nSavedYear - nYear)* 8064)+((nSavedMonth - nMonth) * 672)+((nSavedDay - nDay) * 24)+(nSavedHour - nHour);
    if (nAdvanceHours > 2016) nAdvanceHours = 2016;
    if (nAdvanceHours < 0)
        {
        SetLocalInt(oPC,"DebitHour",abs(nAdvanceHours));
        SendMessageToPC(oPC,"Your saved time is earlier than the current time. You have been debited "+SayHours(abs(nAdvanceHours)));
        }
    else if (nAdvanceHours > 0)
        {
        AdvanceTimeInHours(nAdvanceHours);
        TimeStamp(GetModule(),1);
        AdvanceTimeStamp(GetModule(),0,0,1,0,1);
//        DelayCommand(0.1,AdvanceTimeStamp(GetModule(),0,0,0,nAdvanceHours,1));
        object oScan = GetFirstPC();
        while (oScan != OBJECT_INVALID)
            {
            if (oScan == oPC)
                {
                SendMessageToPC(oPC,"Your entry has advanced time "+SayHours(nAdvanceHours)+". "+SayGreyhawkDateTime());
                }
            else
                {
                AdvanceTimeStamp(oScan,0,0,0,nAdvanceHours,5);
                nNumber = GetLocalInt(oScan,"DebitHour") + nAdvanceHours;
                SetLocalInt(oScan,"DebitHour",nNumber);
                SendMessageToPC(oScan,GetName(oPC)+"'s entry has advanced time "+SayHours(nAdvanceHours)+". You are now debited "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
                }
            oScan = GetNextPC();
            }
        }
    }
}

void SaveTreasure()
{
object oChest;
object oItem;
int nSaveTrue;
int nCounter = 0;
string sMPOPs = GetLocalString(GetModule(),"POPS");
int nPlace = 0;
string sBuffer = GetSubString(sMPOPs,nPlace,4);
while (sBuffer != "")
    {
    oChest = GetObjectByTag(GetStringUpperCase(sBuffer)+"_TT");
    if (oChest != OBJECT_INVALID)
        {
        nCounter = 0;
        oItem = GetFirstItemInInventory(oChest);
        while (oItem != OBJECT_INVALID)
            {
            if (!GetLocalInt(oItem,"QUEST"))
                {
                nSaveTrue = StoreCampaignObject("SHIELD_LANDS",GetStringUpperCase(sBuffer)+"_"+IntToString(nCounter), oItem);
                if (nSaveTrue) nCounter ++;
                }
            oItem = GetNextItemInInventory(oChest);
            }
        nCounter ++;
        DeleteCampaignVariable("SHIELD_LANDS",GetStringUpperCase(sBuffer)+"_"+IntToString(nCounter));
        }
    nPlace = nPlace + 5;
    sBuffer = GetSubString(sMPOPs,nPlace,4);
    }
}

void LoadTreasure()
{
object oChest;
object oItem;
int nSaveTrue;
int nCounter = 0;
string sMPOPs = GetLocalString(GetModule(),"POPS");
int nPlace = 0;
string sBuffer = GetSubString(sMPOPs,nPlace,4);
while (sBuffer != "")
    {
    oChest = GetObjectByTag(GetStringUpperCase(sBuffer)+"_TT");
    if (oChest != OBJECT_INVALID)
        {
        nCounter = 0;
        oItem = RetrieveCampaignObject("SHIELD_LANDS",GetStringUpperCase(sBuffer)+"_"+IntToString(nCounter),GetLocation(oChest),oChest);
        if (oItem != OBJECT_INVALID) SetLocalInt(oItem,"Unique",1);
        while (oItem != OBJECT_INVALID)
            {
            nCounter ++;
            oItem = RetrieveCampaignObject("SHIELD_LANDS",GetStringUpperCase(sBuffer)+"_"+IntToString(nCounter),GetLocation(oChest),oChest);
            if (oItem != OBJECT_INVALID) SetLocalInt(oItem,"Unique",1);
            }
        }
    nPlace = nPlace + 5;
    sBuffer = GetSubString(sMPOPs,nPlace,4);
    }
}
