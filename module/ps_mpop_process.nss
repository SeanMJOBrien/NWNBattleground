#include "ps_timestamp"

int CompareForHostile(string sPopA, string sPopB)
{
if (sPopA == sPopB)
    {
   return FALSE;
    }
string sFriend = GetLocalString(GetModule(),sPopA+"_FRIEND");
int nCount = 0;
string sScan = GetSubString(sFriend,nCount,4);
while (sScan != "")
    {
   if (sScan == sPopB)
        {
        return FALSE;
        }
   nCount += 5;
    sScan = GetSubString(sFriend,nCount,4);
    }
    sFriend = GetLocalString(GetModule(),sPopB+"_FRIEND");
    nCount = 0;
    sScan = GetSubString(sFriend,nCount,4);
   while (sScan != "")
        {
        if (sScan == sPopA)
            {
           return FALSE;
            }
        nCount += 5;
        sScan = GetSubString(sFriend,nCount,4);
        }
return TRUE;
}

int GetPopHostile(object oAreaWPG,string sBasePopG,int nBSlot = FALSE)
// returns the slot # of the strongest hostile population in an area
{

int nStrG = 0;
int nPlaceG= 0;
int nCountG= 1;
string sScanPopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),0,4);
if ((nBSlot == TRUE) && (GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)+"_B"),0,4) != ""))
    sScanPopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)+"_B"),0,4);
while (sScanPopG != "")
    {
    if ((sScanPopG != "DELETE") && (sBasePopG != sScanPopG) && (CompareForHostile(sBasePopG,sScanPopG) == TRUE))
        {
        if ((StringToInt(GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),5,3)) * GetLocalInt(GetModule(),GetSubString(sScanPopG,0,4)+"_CR"))  > nStrG)
            {
            nStrG = StringToInt(GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),5,3)) * GetLocalInt(GetModule(),GetSubString(sScanPopG,0,4)+"_CR");
            nPlaceG= nCountG;
            }
        }
    nCountG++;
    sScanPopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),0,4);
    }
return nPlaceG;
}

// Variables which build a table upon which moving decisions are
// based; to be written to home MPOP:
// int Choices (total # of choices)
// int ChoiceSUM (sum of points assigned to each choice.)
//      Some choices are more or less desirable, this is expressed by
//      building a table of all possible choices and assigning point
//      values to each.
int CheckForMove(object oFromWP, object oToWP, string sPopCode,int nChoiceSlot)
// returns TRUE if points were assigned.
{
// Declarations.
int nSlotCount =1;
string sSlotScan;
string sSamePopHere;
string sPopHostile;
int nHostileSlot;
int nChoicePoints;
int nChoiceSum = GetLocalInt(oFromWP,"ChoiceSUM");
int nFriendlyStr;
int nHostileStr;
// End Declarations.
sSlotScan = GetLocalString(oToWP,"Pop"+IntToString(nSlotCount));
//if (GetLocalString(oToWP,"Pop"+IntToString(nSlotCount)+"_B") != "")
//    sSlotScan = GetLocalString(oToWP,"Pop"+IntToString(nSlotCount)+"_B");
while (sSlotScan != "")
    {
    if (GetSubString(sSlotScan,0,4) == GetSubString(sPopCode,0,4))
        {
        sSamePopHere = sSlotScan;
        break;
        }
    nSlotCount ++;
    sSlotScan = GetLocalString(oToWP,"Pop"+IntToString(nSlotCount));
    }
nHostileSlot = GetPopHostile(oToWP,GetSubString(sPopCode,0,4),TRUE);
if (nHostileSlot != 0) sPopHostile = GetLocalString(oToWP,"Pop"+IntToString(nHostileSlot));
if ((sSamePopHere != "") && (nHostileSlot != 0))
    {
    nFriendlyStr = ((StringToInt(GetSubString(sSamePopHere,5,3)) + (StringToInt(GetSubString(sPopCode,5,3))))* GetLocalInt(GetModule(),GetSubString(sSamePopHere,0,4)+"_CR"));
    nHostileStr = (StringToInt(GetSubString(sPopHostile,5,3)) * GetLocalInt(GetModule(),GetSubString(sPopHostile,0,4)+"_CR"));
//    WriteTimestampedLogEntry(GetSubString(sSamePopHere,0,4)+"_"+IntToString(nFriendlyStr)+" VS. "+GetSubString(sPopHostile,0,4)+"_"+IntToString(nHostileStr));
    if (nFriendlyStr >= nHostileStr)
        {
        WriteTimestampedLogEntry("Fight Type A");
        nChoicePoints = 3;
        }
     }
if ((!nChoicePoints) && (nHostileSlot != 0))
        {
        nFriendlyStr = (StringToInt(GetSubString(sPopCode,5,3)))* GetLocalInt(GetModule(),GetSubString(sPopCode,0,4)+"_CR");
        nHostileStr = (StringToInt(GetSubString(sPopHostile,5,3)) * GetLocalInt(GetModule(),GetSubString(sPopHostile,0,4)+"_CR"));
//        WriteTimestampedLogEntry(GetSubString(sPopCode,0,4)+"_"+IntToString(nFriendlyStr)+" VS. "+GetSubString(sPopHostile,0,4)+"_"+IntToString(nHostileStr));
        if (nFriendlyStr >= nHostileStr)
            {
            WriteTimestampedLogEntry("Fight Type A");
            nChoicePoints = 1;
            }
        }
if ((!nChoicePoints) && (sSamePopHere != "") && (nHostileSlot == 0) && (StringToInt(GetSubString(sSamePopHere,5,3)) < 100))
    {
    nChoicePoints = 4;
    }
if ((!nChoicePoints) && (sSamePopHere == "") && (nHostileSlot == 0))
    {
    nChoicePoints = 3;
    }
if ((!nChoicePoints) && (sSamePopHere != "") && (StringToInt(GetSubString(sSamePopHere,5,3)) < 600))
    {
    nChoicePoints = 1;
    }
if (nChoicePoints > 0)
    {
//    SetLocalInt(oFromWP,"Choices",nChoiceSlot);
    SetLocalInt(oFromWP,"ChoiceSUM",(nChoiceSum+nChoicePoints));
    SetLocalInt(oFromWP,"Choice"+IntToString(nChoiceSlot)+"PTS",nChoicePoints);
    SetLocalObject(oFromWP,"Choice"+IntToString(nChoiceSlot)+"WP",oToWP);
    return TRUE;
    }
return FALSE;
}

void PopMove(object oAreaWP, int nSlot, int nOverflow = FALSE)
{
//SpawnScriptDebugger();
if (GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B") == "DELETE") return;
// Declarations
int nCount;
string sHomePop = GetLocalString(oAreaWP,"Pop"+IntToString(nSlot));
object oMPOPScan;
object oTransitionObject;
object oTransitionTarget;
int nChoiceSlot = 1;
int nChoiceSum;
int nChoiceScan;
int nChoiceRoll;
int nChoiceCount;
int nPoints;
object oChooseWP;
string sPopToMove;
int nPopToMoveStr;
int nBaseStr;
int nSlotScan;
string sSlotScan;
int nBuffer;
int nChoices;
// End declarations.

if ((GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B") != "")
    && (GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B") != "DELETE"))
        {
        sHomePop = GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B");
        }

DeleteLocalInt(oAreaWP,"Choices");
DeleteLocalInt(oAreaWP,"ChoiceSUM");

// MPOP linking rules:
// 1. All MPOP points in an area automatically link to one another.
// 2. Doors, triggers & travel signs with a transition trigger will link
//    the MPOP point nearest to them with the MPOP point nearest the
//    destination point.

// Cycle through MPOP points in area.
nCount = 1;
oMPOPScan = GetNearestObjectByTag("MPOP",oAreaWP,nCount);
while (oMPOPScan != OBJECT_INVALID)
    {
    if  ((oAreaWP != oMPOPScan) && (GetObjectType(oMPOPScan) == OBJECT_TYPE_WAYPOINT))
        {
        if (CheckForMove(oAreaWP,oMPOPScan,sHomePop,nChoiceSlot) == TRUE)
            {
//            WriteTimestampedLogEntry(GetName(oAreaWP)+" by proximity to "+GetName(oMPOPScan)+", nChoiceSlot : "+IntToString(nChoiceSlot));
            nChoiceSlot += 1;
            }
        }
    nCount ++;
    oMPOPScan = GetNearestObjectByTag("MPOP",oAreaWP,nCount);
    }
// Cycle through transition targets available.
nCount = 1;
oTransitionObject = GetNearestObject(OBJECT_TYPE_DOOR|OBJECT_TYPE_TRIGGER,oAreaWP,nCount);
while (oTransitionObject != OBJECT_INVALID)
    {
    oTransitionTarget = GetTransitionTarget(oTransitionObject);
    if ((oTransitionTarget != OBJECT_INVALID)
        && (GetNearestObjectByTag("MPOP",oTransitionObject) == oAreaWP))
        {
        oMPOPScan = GetNearestObjectByTag("MPOP",oTransitionTarget);
        if ((oMPOPScan != OBJECT_INVALID) && (GetObjectType(oMPOPScan) == OBJECT_TYPE_WAYPOINT)
            && (oAreaWP != oMPOPScan))
            {
            if (CheckForMove(oAreaWP,oMPOPScan,sHomePop,nChoiceSlot) == TRUE)
                {
//                WriteTimestampedLogEntry(GetName(oAreaWP)+" by door/trigger to "+GetName(oMPOPScan)+", nChoiceSlot : "+IntToString(nChoiceSlot));
                nChoiceSlot += 1;
                }
            }
        }
    nCount ++;
    oTransitionObject = GetNearestObject(OBJECT_TYPE_DOOR|OBJECT_TYPE_TRIGGER, oAreaWP,nCount);
    }
// Cycle through travel signs available.
nCount = 1;
oTransitionObject = GetNearestObjectByTag("TRAVEL",oAreaWP,nCount);
while (oTransitionObject != OBJECT_INVALID)
    {
    oTransitionTarget = GetWaypointByTag(GetLocalString(oTransitionObject,"CODE")+"_TRAVELDEST");;
    if ((oTransitionTarget != OBJECT_INVALID)
        && (GetNearestObjectByTag("MPOP",oTransitionObject) == oAreaWP))
        {
        oMPOPScan = GetNearestObjectByTag("MPOP",oTransitionTarget);
        if ((oMPOPScan != OBJECT_INVALID) && (GetObjectType(oMPOPScan) == OBJECT_TYPE_WAYPOINT)
            && (oAreaWP != oMPOPScan))
            {
            if (CheckForMove(oAreaWP,oMPOPScan,sHomePop,nChoiceSlot) == TRUE)
                {
//                WriteTimestampedLogEntry(GetName(oAreaWP)+" by sign to "+GetName(oMPOPScan)+", nChoiceSlot : "+IntToString(nChoiceSlot));
                nChoiceSlot += 1;
                }
            }
        }
    nCount ++;
    oTransitionObject = GetNearestObjectByTag("TRAVEL",oAreaWP,nCount);
    }
nChoiceSum = GetLocalInt(oAreaWP,"ChoiceSUM");
nChoices = nChoiceSlot;
if ((nChoiceSlot > 1) && (nChoiceSum > 0))
    {
    nChoiceSlot = nChoiceSlot - 1;
    nChoiceRoll = Random(nChoiceSum) + 1;
    nChoiceCount = 0;
//    WriteTimestampedLogEntry("oFromWP = "+GetName(oAreaWP));
//    WriteTimestampedLogEntry("nChoiceRoll ="+IntToString(nChoiceRoll)+"nChoiceSum ="+IntToString(nChoiceSum)+"nChoices ="+IntToString(nChoices));
    for(nChoiceScan = 1;nChoiceScan <= nChoiceSlot; nChoiceScan ++)
        {
        nPoints = GetLocalInt(oAreaWP,"Choice"+IntToString(nChoiceScan)+"PTS");
//        WriteTimestampedLogEntry("nChoiceScan = "+IntToString(nChoiceScan)+", nPoints = "+IntToString(nPoints)+" for "+GetName(GetLocalObject(oAreaWP,"Choice"+IntToString(nChoiceScan)+"WP")));
        if ((nChoiceRoll >= nChoiceCount) && (nChoiceRoll <= (nChoiceCount + nPoints)))
            {
            oChooseWP = GetLocalObject(oAreaWP,"Choice"+IntToString(nChoiceScan)+"WP");
//            WriteTimestampedLogEntry("Selected "+GetName(GetLocalObject(oAreaWP,"Choice"+IntToString(nChoiceScan)+"WP")));
            break;
            }
//        WriteTimestampedLogEntry("nChoiceCount = "+IntToString(nChoiceCount));
        nChoiceCount += nPoints;
        }
//    WriteTimestampedLogEntry("end For Loop");
    if (oChooseWP != OBJECT_INVALID)
        {
        sPopToMove = GetSubString(sHomePop,0,4);
        nBaseStr = StringToInt(GetSubString(sHomePop,5,3));
        if (nOverflow == TRUE)
            {
            if (nBaseStr > 100)
                {
                nPopToMoveStr = nBaseStr - 100;
                nBaseStr -= 100;
                }
            else nPopToMoveStr = nBaseStr;
            if (nBaseStr > 0)
                SetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B",sPopToMove+"_"+IntToString(nBaseStr));
            else
                SetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B","DELETE");
            }
        else if (nOverflow != TRUE)
            {
            nPopToMoveStr = nBaseStr;
            SetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B","DELETE");
            }
        nSlotScan = 1;
        sSlotScan = GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan));
        if ((GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") != "")
           && (GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") != "DELETE"))
                {
                sSlotScan = GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B");
                }
        else if (GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") == "DELETE")
                {
                sSlotScan = GetSubString(sSlotScan,0,4)+"_000";
                }
        while (sSlotScan != "")
            {
            if (GetSubString(sSlotScan,0,4) == sPopToMove)
                {
                nBuffer = StringToInt(GetSubString(sSlotScan,5,3))+ nPopToMoveStr;
                if (nBuffer > 999) nBuffer = 999;
                SetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B",sPopToMove+"_"+IntToString(nBuffer));
//                WriteTimestampedLogEntry("Moved "+sPopToMove+"_"+IntToString(nBuffer)+" from "+GetName(oAreaWP)+" to "+GetName(oChooseWP)+", Slot "+IntToString(nSlotScan)+", appending.");
                break;
                }
            else if (sSlotScan == "")
                {
                SetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B",sPopToMove+"_"+IntToString(nPopToMoveStr));
//                WriteTimestampedLogEntry("Moved "+sPopToMove+"_"+IntToString(nPopToMoveStr)+" from "+GetName(oAreaWP)+" to "+GetName(oChooseWP)+", Slot "+IntToString(nSlotScan)+", new Pop.");
                break;
                }
            nSlotScan ++;
            sSlotScan = GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan));
            if ((GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") != "")
               && (GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") != "DELETE"))
                    {
                    sSlotScan = GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B");
                    }
            else if (GetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B") == "DELETE")
                    {
                    sSlotScan = GetSubString(sSlotScan,0,4)+"_000";
                    }
            if (sSlotScan == "")
                {
                SetLocalString(oChooseWP,"Pop"+IntToString(nSlotScan)+"_B",sPopToMove+"_"+IntToString(nPopToMoveStr));
//                WriteTimestampedLogEntry("Moved "+sPopToMove+"_"+IntToString(nPopToMoveStr)+" from "+GetName(oAreaWP)+" to "+GetName(oChooseWP)+", Slot "+IntToString(nSlotScan)+", new Pop.");
                break;
                }
            } // end while (sSlotScan != "")
        }// end if (oChooseWP != OBJECT_INVALID)

    }//end if ((nChoiceSlot > 1) && (nChoiceSum > 0))

}


void MPOP_Cleanup()
{
int nNumber;
object oScan;
int nBuffer;
int nBuffer2;
string sBuffer;
string sBufferB;
string sBufferD;
string sBufferV;
int nBuffer3;

    nNumber = 0;
    oScan = GetObjectByTag("MPOP",nNumber);
    while (oScan != OBJECT_INVALID)
        {
        nBuffer = 1;
        sBuffer = GetLocalString(oScan,"Pop"+IntToString(nBuffer));
        sBufferD = GetLocalString(oScan,"Pop"+IntToString(nBuffer)+"_B");
        while ((sBuffer != "") || (sBufferD != ""))
            {
            if (sBufferD == "DELETE")
                {
                DeleteLocalString(oScan,"Pop"+IntToString(nBuffer)+"_B");
                DeleteLocalString(oScan,"Pop"+IntToString(nBuffer));
                }
            else if (sBufferD != "")
                {
                SetLocalString(oScan,"Pop"+IntToString(nBuffer),sBufferD);
                DeleteLocalString(oScan,"Pop"+IntToString(nBuffer)+"_B");
                }
            nBuffer++;
            sBuffer = GetLocalString(oScan,"Pop"+IntToString(nBuffer));
            sBufferD = GetLocalString(oScan,"Pop"+IntToString(nBuffer)+"_B");
            }
        nBuffer2 = 0;
        for (nBuffer = 1; (nBuffer < 7); nBuffer++)
            {
            sBuffer = GetLocalString(oScan,"Pop"+IntToString(nBuffer));
            if (sBuffer == "")
                {
                nBuffer3 = FALSE;
                for (nBuffer2 = nBuffer + 1; nBuffer2 < 7; nBuffer2++)
                    {
                    sBufferD = GetLocalString(oScan,"Pop"+IntToString(nBuffer2));
                    if (sBufferD != "")
                        {
                        SetLocalString(oScan,"Pop"+IntToString(nBuffer2 - 1),sBufferD);
                        DeleteLocalString(oScan,"Pop"+IntToString(nBuffer2));
                        nBuffer3 = FALSE;
                        break;
                        }
                    }
                }
            if (nBuffer3 == FALSE) break;
            }
        nNumber ++;
        oScan = GetObjectByTag("MPOP",nNumber);
        }
}


void MPOP_Process()
{
string sPop;
int nPopStr;
int nPopStr2;
int nHostile;
int nAttack;
int nNumber;
int nBuffer;
int nCount;
int nGrow;
string sPopGrow;
string sDie;
string sBufferZ;
int nBufferZ;
float fBufferV;
string sBufferV;
string sBufferN;
int nCR1;
int nCR2;
float fProrate;

if (GetLocalInt(GetModule(),"MPOP_disable") == 1) return;

int nCountWP = 0;
int nCountPop;
object oWP = GetObjectByTag("MPOP",nCountWP);
while (oWP != OBJECT_INVALID)
    {
    nCountPop = 1;
    sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
//    if (GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B") != "")
//        sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));

    while (sPop != "")
        {
        nPopStr = StringToInt(GetSubString(sPop,5,3));
        nHostile = GetPopHostile(oWP,GetSubString(sPop,0,4));
        if (nHostile != 0)
            {
            nPopStr2 = StringToInt(GetSubString(GetLocalString(oWP,"Pop"+IntToString(nHostile)),5,3));
            nCR1 = GetLocalInt(GetModule(),GetSubString(sPop,0,4)+"_CR");
            nCR2 = GetLocalInt(GetModule(),GetSubString(GetLocalString(oWP,"Pop"+IntToString(nHostile)),0,4)+"_CR");
            if ((nCR1 == 0) || (nCR2 == 0)) fProrate = 1.0f;
            else fProrate = IntToFloat(nCR1) / IntToFloat(nCR2);
            nAttack = FloatToInt(fProrate * IntToFloat(nPopStr) *(IntToFloat(d100())*0.01));
            if (GetLocalString(oWP,"Pop"+IntToString(nHostile)+"_B") != "") nPopStr2 = StringToInt(GetSubString(GetLocalString(oWP,"Pop"+IntToString(nHostile)+"_B"),5,3));
            if (GetLocalString(oWP,"Pop"+IntToString(nHostile)+"_B") == "DELETE") nPopStr2 = 0;
            if ((nPopStr2 - nAttack) > 0)
                {
                sBufferN = GetSubString(GetLocalString(oWP,"Pop"+IntToString(nHostile)),0,4)+"_"+IntToString(nPopStr2 - nAttack);
                SetLocalString(oWP,"Pop"+IntToString(nHostile)+"_B",sBufferN);
                }
            else SetLocalString(oWP,"Pop"+IntToString(nHostile)+"_B","DELETE");
            nCountPop ++;
            sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
            if (GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B") != "")
                sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
            continue;
            }
        nGrow = 0;
        sPopGrow = GetLocalString(oWP,"GROWTH");
        if (sPopGrow == "")
            {
            PopMove(oWP,nCountPop,FALSE);
            nCountPop ++;
            sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
//            if (GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B") != "")
//                sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
            continue;
            }
        sDie = GetSubString(sPopGrow,1,3);
        nNumber = StringToInt(GetSubString(sPopGrow,0,1));
        if (sDie == "D04")
            nGrow = d4(nNumber);
        else if (sDie == "D06")
            nGrow = d6(nNumber);
        else if (sDie == "D08")
            nGrow = d8(nNumber);
        else if (sDie == "D10")
            nGrow = d10(nNumber);
        else if (sDie == "D12")
            nGrow = d12(nNumber);
        else if (sDie == "D20")
            nGrow = d20(nNumber);
        else if (sDie == "D00")
            nGrow = d100(nNumber);
        nPopStr += nGrow;
        if (nPopStr > 999) nPopStr = 999;
        sBufferZ = GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B");
//        nBuffer = 0;
        if (sBufferZ == "")
            {
            SetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B",GetSubString(sPop,0,4)+"_"+IntToString(nPopStr));
            }
        else if (sBufferZ != "DELETE")
            {
            nBuffer = StringToInt(GetSubString(GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B"),5,3)) + abs(nGrow - nPopStr);
            SetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B",GetSubString(sPop,0,4)+"_"+IntToString(nBuffer));
            }
        else if (sBufferZ == "DELETE")
            {
            nBuffer = abs(nGrow - nPopStr);
            SetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B",GetSubString(sPop,0,4)+"_"+IntToString(nBuffer));
            }
//        if (nBuffer != 0) nPopStr = nBuffer;
        if (nPopStr > 200) PopMove(oWP,nCountPop,TRUE);
        nCountPop ++;
        sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
//        if (GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B") != "")
//           sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
        }
    nCountWP ++;
    oWP = GetObjectByTag("MPOP",nCountWP);
    }
MPOP_Cleanup();

// line 379: && (d100() < (nPopStr -100))
}
