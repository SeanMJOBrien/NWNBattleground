#include "ps_timestamp"
#include "spawn_functions"

void SecondaryEffectWipe(object oTarget)
{
effect eScan = GetFirstEffect(oTarget);
while (GetIsEffectValid(eScan))
    {
    if (GetEffectType(eScan) == EFFECT_TYPE_ETHEREAL)
        AssignCommand(oTarget,ActionDoCommand(RemoveEffect(oTarget,eScan)));
    else if (eScan == EffectVisualEffect(VFX_DUR_INVISIBILITY))
    AssignCommand(oTarget,ActionDoCommand(RemoveEffect(oTarget,eScan)));
    eScan = GetNextEffect(oTarget);
    }
}


void main()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
int nProgress = StringToInt(GetSubString(sTravel,5,4));
DeleteLocalInt(oPC,"TrvIni");

int nTravelGoal = GetLocalInt(oPC,"TravelGoal");

string sActionText = GetLocalString(oPC,"ActionText");
string sTravelFrom = GetLocalString(oPC,"TravelFrom");
string sTravelTo = GetLocalString(oPC,"TravelTo");
string sTravelCompass = GetLocalString(oPC,"TravelCompass");
string sTime = SayTimestamp(oPC,7);
int nPartyCount = GetLocalInt(oPC,"PartyCount");
object oJumpTo;

int nArrive = GetLocalInt(oPC,"Arrive");
int nEncounter = GetLocalInt(oPC,"Encounter");
int nCamp = GetLocalInt(oPC,"Camp");
int nHunting = GetLocalInt(oPC,"Hunting");
int nAdvance = 0;
object oScan;
int nCountB;
object oScanB;
int nMatch;
int nNumber;
int nCount;

int nDebitHour = GetLocalInt(oPC,"DebitHour");
int nHour = GetLocalInt(oPC,"nStampHour6");
int nDay = GetLocalInt(oPC,"nStampDay6");
int nMonth = GetLocalInt(oPC,"nStampMonth6");;
int nYear = GetLocalInt(oPC,"nStampYear6");
int nTargetHour = GetLocalInt(oPC,"nStampHour7");
int nTargetDay = GetLocalInt(oPC,"nStampDay7");
int nTargetMonth = GetLocalInt(oPC,"nStampMonth7");
int nTargetYear = GetLocalInt(oPC,"nStampYear7");
nAdvance = ((nTargetYear - nYear) * 8064) + ((nTargetMonth - nMonth) * 672) + ((nTargetDay - nDay) * 24) + (nTargetHour - nHour);

if (nDebitHour < nAdvance)
    {
    nAdvance -= nDebitHour;
    AdvanceTimeInHours(nAdvance);
    oScan = GetFirstPC();
    while (oScan != OBJECT_INVALID)
        {
        nMatch = FALSE;
        if (oScan == oPC) nMatch = TRUE;
        for (nCountB = 1; nCountB <= nPartyCount; nCountB ++)
            {
            oScanB = GetLocalObject(oPC,"PARTY"+IntToString(nCountB));
            if (oScanB == oScan)
                {
                nMatch = TRUE;
                break;
                }
            }
        if (nMatch == TRUE)
            {
            DeleteLocalInt(oScan,"DebitHour");
            oScan = GetNextPC();
            continue;
            }
        AdvanceTimeStamp(oScan,0,0,0,nAdvance,5);
        nNumber = GetLocalInt(oScan,"DebitHour") + nAdvance;
        SetLocalInt(oScan,"DebitHour",nNumber);
        if (nPartyCount == 0) SendMessageToPC(oScan,GetName(oPC)+"'s travel has advanced time "+SayHours(nAdvance)+". You are now debited "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
        else SendMessageToPC(oScan,"Another party's travel has advanced time "+SayHours(nAdvance)+". You are now debited "+SayHours(nNumber)+". "+SayGreyhawkDateTime());
        oScan = GetNextPC();
        }//while (oScan != OBJECT_INVALID)
    for (nCountB = 0; nCountB <= nPartyCount; nCountB ++)
        {
        if (nCountB == 0) oScan = oPC;
        else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCountB));
        SendMessageToPC(oScan,"Your travel has advanced time "+SayHours(nAdvance)+". "+SayGreyhawkDateTime());
        }
    }//if (nDebitHour < nAdvance)
else
    {
    nDebitHour -= nAdvance;
    for (nCountB = 0; nCountB <= nPartyCount; nCountB ++)
        {
        if (nCountB == 0) oScan = oPC;
        else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCountB));
        SetLocalInt(oScan,"DebitHour",nDebitHour);
        SendMessageToPC(oScan,"Your travel hasn't advanced time due to debited time. You are now debited "+SayHours(nDebitHour)+". "+SayGreyhawkDateTime());

        }
    }
string sTemplate;
string sBlueprint;
int nAppearing = 1;
int nRoll = d100();
int nTable = 1;
//Default to easiest encounter tables.
if (nHunting) nTable = 3;
if (nTable == 1)
    {
    if (nRoll < 40)
        { sTemplate = "firebeetles"; nAppearing = 6; }
    else if (nRoll < 64) sTemplate = "blackbear";
    else if (nRoll < 79) sTemplate = "cougar";
    else if (nRoll < 88)
        { sTemplate = "wolf"; nAppearing = 4; }
    else if (nRoll < 93) sTemplate = "werewolf";
    else if (nRoll < 96)
        { sTemplate = "boar"; nAppearing = 6; }
    else if (nRoll < 98) sTemplate = "brownbear";
    else if (nRoll < 99) sTemplate = "troll";
    else sTemplate = "willowisp";
    }
else if (nTable == 3)
    {
    switch (d4())
        {
        case 1: sTemplate = "deer"; nAppearing = 4; break;
        case 2: sTemplate = "badger"; nAppearing = 1; break;
        case 3: sTemplate = "boar"; nAppearing = 1; break;
        case 4: sTemplate = "ox"; nAppearing = 1; break;
        }
    }

int nChoose;
int nRoomFree;
object oArea;
object oWP;
object oWPSign;
object oSign;
object oPickRoom;
if ((nCamp) || (nHunting) || (nEncounter) || ((nProgress != StringToInt(GetSubString(GetTag(OBJECT_SELF),5,3))&& (nProgress < nTravelGoal))))
    {
    for (nCount = 1; nCount <= 6; nCount ++)
        {
        oScan = GetWaypointByTag("WILDERNESS"+IntToString(nCount));
        if ((oScan != OBJECT_INVALID) && (GetLocalInt(GetArea(oScan),"Occupied") == 0))
            {
            nRoomFree = TRUE;
            break;
            }
        } //for (nCount = 1; nCount <= nWRooms; nCount ++)
    if ((nRoomFree) && (sTravelCompass != ""))
        {
        while (oPickRoom == OBJECT_INVALID)
            {
            oPickRoom = GetWaypointByTag("WILDERNESS"+IntToString(d6()));
            if (GetLocalInt(GetArea(oPickRoom),"Occupied") == 1) oPickRoom = OBJECT_INVALID;
            }
        oScan = oPickRoom;
        oArea = GetArea(oScan);
        if (sTravelCompass == "north") {oWPSign = GetNearestObjectByTag("WP_N",oScan); oJumpTo = GetNearestObjectByTag("WP_S",oScan);}
        else if (sTravelCompass == "northeast") {oWPSign = GetNearestObjectByTag("WP_NE",oScan); oJumpTo = GetNearestObjectByTag("WP_SW",oScan);}
        else if (sTravelCompass == "east") {oWPSign = GetNearestObjectByTag("WP_E",oScan); oJumpTo = GetNearestObjectByTag("WP_W",oScan);}
        else if (sTravelCompass == "southeast") {oWPSign = GetNearestObjectByTag("WP_SE",oScan); oJumpTo = GetNearestObjectByTag("WP_NW",oScan);}
        else if (sTravelCompass == "south") {oWPSign = GetNearestObjectByTag("WP_S",oScan); oJumpTo = GetNearestObjectByTag("WP_N",oScan); }
        else if (sTravelCompass == "southwest") {oWPSign = GetNearestObjectByTag("WP_SW",oScan); oJumpTo = GetNearestObjectByTag("WP_NE",oScan); }
        else if (sTravelCompass == "west") {oWPSign = GetNearestObjectByTag("WP_W",oScan); oJumpTo = GetNearestObjectByTag("WP_E",oScan);  }
        else if (sTravelCompass == "northwest") {oWPSign = GetNearestObjectByTag("WP_NW",oScan); oJumpTo = GetNearestObjectByTag("WP_SE",oScan);}
        else {oWPSign = GetNearestObjectByTag("WP_N",oScan); oJumpTo = GetNearestObjectByTag("WP_S",oScan);}
        } //if ((nRoomFree) && (sTra...
    if ((nEncounter) || (nHunting))
        {
//        SendMessageToPC(oPC,GetName(oArea)+": "+sTemplate+": "+IntToString(nAppearing));
        SetLocalString(oArea,"Encounter",sTemplate);
        SetLocalInt(oArea,"Appearing",nAppearing);
        }
    } //if (nEncounter)
else if (nProgress >= nTravelGoal) oJumpTo = GetWaypointByTag(sRoute+"_TRAVELDEST");

if (oWPSign != OBJECT_INVALID) CreateObject(OBJECT_TYPE_PLACEABLE,"ps_travelsign",GetLocation(oWPSign),FALSE,sTravel);
//SendMessageToPC(oPC,"oJumpTo: "+GetTag(oJumpTo)+"oWPSign: "+GetTag(oWPSign));
effect eScan;
for (nCountB = 0; nCountB <= nPartyCount; nCountB ++)
    {
    if (nCountB == 0) oScan = oPC;
    else oScan = GetLocalObject(oPC,"PARTY"+IntToString(nCountB));
//    SetCommandable(TRUE,oScan);
    AssignCommand(oScan,ClearAllActions(TRUE));
    if (oJumpTo != OBJECT_INVALID) AssignCommand(oScan,ActionJumpToObject(oJumpTo));
//    AssignCommand(oScan,ActionWait(0.5));
//    eScan = GetFirstEffect(oScan);
//    while (GetIsEffectValid(eScan))
//        {
//        if (GetEffectType(eScan) == EFFECT_TYPE_ETHEREAL)
//            AssignCommand(oScan,ActionDoCommand(RemoveEffect(oScan,eScan)));
//        else if (eScan == EffectVisualEffect(VFX_DUR_INVISIBILITY))
//        AssignCommand(oScan,ActionDoCommand(RemoveEffect(oScan,eScan)));
//        eScan = GetNextEffect(oScan);
//        }
//    DelayCommand(40.0,SecondaryEffectWipe(oScan));
    //AssignCommand(oScan,ActionDoCommand(SetCommandable(TRUE,OBJECT_SELF)));
    //SetCommandable(FALSE,oScan);
    }
string sPrint = SayLogTime()+" <"+sTravel+"> ";
if (nEncounter) sPrint = sPrint + "<encounter> ";
else if (nCamp) sPrint = sPrint + "<camp> ";
else if (nHunting) sPrint = sPrint + "<hunting> ";
if (nProgress >= nTravelGoal) sPrint = sPrint + "<arrive> ";
sPrint = sPrint + GetName(oPC)+" ";
for (nCountB = 1; nCountB <= nPartyCount; nCountB ++)
    {
    sPrint = sPrint + GetName(GetLocalObject(oPC,"PARTY"+IntToString(nCountB))) + " ";
    }
PrintString(sPrint);

DeleteLocalString(oPC,"ActionText");
DeleteLocalString(oPC,"TravelFrom");
DeleteLocalString(oPC,"TravelTo");
DeleteLocalString(oPC,"TravelCompass");
DeleteLocalInt(oPC,"TravelGoal");
DeleteLocalInt(oPC,"LeastMove");
DeleteLocalInt(oPC,"PartyCount");
DeleteLocalInt(oPC,"Arrive");
DeleteLocalInt(oPC,"Encounter");
DeleteLocalInt(oPC,"Camp");
DeleteLocalInt(oPC,"Hunting");
for (nCountB = 1; nCountB <= nPartyCount; nCountB ++)
    {
    DeleteLocalObject(oPC,"PARTY"+IntToString(nCountB));
    }
}
