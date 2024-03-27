#include "ps_timestamp"

int CompareForHostile(string sPopA, string sPopB)
{
int nHostile = TRUE;
string sFriend = GetLocalString(GetModule(),sPopA+"_FRIEND");
int nCount = 0;
string sScan = GetSubString(sFriend,nCount,4);
while (sScan != "")
    {
    if (sScan == sPopB)
        {
        nHostile = FALSE;
        break;
        }
    nCount += 5;
    sScan = GetSubString(sFriend,nCount,4);
    }
if (nHostile == TRUE)
    {
    sFriend = GetLocalString(GetModule(),sPopA+"_FRIEND");
    nCount = 0;
    sScan = GetSubString(sFriend,nCount,4);
    while (sScan != "")
        {
        if (sScan == sPopA)
            {
            nHostile = FALSE;
            break;
            }
        nCount += 5;
        sScan = GetSubString(sFriend,nCount,4);
        }
    }
return nHostile;
}

int GetPopHostile(object oAreaWPG,int nPopSlotG)
// returns the slot # of the strongest hostile population in an area
{
int nStrG = 0;
int nPlaceG= 0;
int nCountG= 1;
int nHostileG = FALSE;
string sBasePopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nPopSlotG)),0,4);
string sScanPopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),0,4);
while (sScanPopG != "")
    {
    if (nCountG!= nPopSlotG)
        {
        if (CompareForHostile(sBasePopG,sScanPopG) == TRUE)
            {
            if ((StringToInt(GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),5,3)) * GetLocalInt(GetModule(),GetSubString(sScanPopG,0,4)+"_CR"))  > nStrG)
                {
                nStrG = StringToInt(GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),5,3)) * GetLocalInt(GetModule(),GetSubString(sScanPopG,0,4)+"_CR");
                nPlaceG= nCountG;
                }
            }
        }
    nHostileG = FALSE;
    nCountG++;
    sScanPopG = GetSubString(GetLocalString(oAreaWPG,"Pop"+IntToString(nCountG)),0,4);
    }
return nPlaceG;
}

void PopMove(object oAreaWP, int nSlot, int nOverflow = FALSE)
{
//SpawnScriptDebugger();
string sBasePop = GetLocalString(oAreaWP,"Pop"+IntToString(nSlot));
if (GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B") != "")
    {
    if (GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B") == "DELETE") return;
    sBasePop = GetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B");
    }
int nBaseStr = StringToInt(GetSubString(sBasePop,5,3));
string sScanLink;
string sScanPop;
int nScanStr;
string sSlotScan;
object oWPScan;
int nMadeChoice = FALSE;
object oChooseWP;
int nChooseSlot;
object oOptionWP1;
int nOptionSlot1;
object oOptionWP2;
int nOptionSlot2;
object oOptionWP3;
int nOptionSlot3;
object oOptionWP4;
int nOptionSlot4;

int nCountB;
int nCount;
int nWPNum;
string sBufferLink = GetLocalString(oAreaWP,"LINK");
nCount = 1;
nWPNum = 0;
sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
while (sScanLink != "")
    {
    nWPNum = 0;
    oWPScan = GetObjectByTag("MPOP",nWPNum);
    while (GetSubString(GetLocalString(oWPScan,"LINK"),0,4) != sScanLink)
        {
        nWPNum ++;
        oWPScan = GetObjectByTag("MPOP",nWPNum);
        if (oWPScan == OBJECT_INVALID) break;
        }
    if (oWPScan == OBJECT_INVALID)
        {
        nCount++;
        sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
        continue;
        }
    nCountB = 1;
    sSlotScan = GetLocalString(oWPScan,"Pop"+IntToString(nCountB));
    while (sSlotScan != "")
        {
        if ((GetSubString(sBasePop,0,4) == GetSubString(sSlotScan,0,4)) && (StringToInt(GetSubString(sSlotScan,5,3)) < 100) && (GetLocalString(oWPScan,"Pop"+IntToString(nCountB)+"_B") != "DELETE"))
            {
            nMadeChoice = TRUE;
            if ((oOptionWP1 == OBJECT_INVALID) && (nOptionSlot1 == 0))
                {
                oOptionWP1 = oWPScan;
                nOptionSlot1 = nCountB;
                }
            else if ((oOptionWP2 == OBJECT_INVALID) && (nOptionSlot2 == 0))
                {
                oOptionWP2 = oWPScan;
                nOptionSlot2 = nCountB;
                }
            else if ((oOptionWP3 == OBJECT_INVALID) && (nOptionSlot3 == 0))
                {
                oOptionWP3 = oWPScan;
                nOptionSlot3 = nCountB;
                }
            else if ((oOptionWP4 == OBJECT_INVALID) && (nOptionSlot4 == 0))
                {
                oOptionWP4 = oWPScan;
                nOptionSlot4 = nCountB;
                }
            }
        nCountB++;
        sSlotScan = GetLocalString(oWPScan,"Pop"+IntToString(nCountB));
        }
    nCount++;
    sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
    }

int nHostilePresent;
int nPopPresent;
if (nMadeChoice != TRUE)
    {
    nCount = 1;
    nWPNum = 0;
    sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
    while (sScanLink != "")
        {
        nWPNum = 0;
        oWPScan = GetObjectByTag("MPOP",nWPNum);
        while (GetSubString(GetLocalString(oWPScan,"LINK"),0,4) != sScanLink)
            {
            nWPNum ++;
            oWPScan = GetObjectByTag("MPOP",nWPNum);
            if (oWPScan == OBJECT_INVALID) break;
            }
        if (oWPScan == OBJECT_INVALID)
            {
            nCount++;
            sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
            continue;
            }
        nCountB = 1;
        nHostilePresent = FALSE;
        nPopPresent = FALSE;
        sSlotScan = GetLocalString(oWPScan,"Pop"+IntToString(nCountB));
        while (sSlotScan != "")
            {
            if ((CompareForHostile(GetSubString(sBasePop,0,4),GetSubString(sSlotScan,0,4)) == TRUE)
                && ((nBaseStr * GetLocalInt(GetModule(),GetSubString(sBasePop,0,4)+"_CR")) <= (StringToInt(GetSubString(sSlotScan,5,3))) * GetLocalInt(GetModule(),GetSubString(sSlotScan,0,4)+"_CR")))
                nHostilePresent = TRUE;

            if (GetSubString(sBasePop,0,4) == GetSubString(sSlotScan,0,4)) nPopPresent = TRUE;
            nCountB++;
            sSlotScan = GetLocalString(oWPScan,"Pop"+IntToString(nCountB));
            }
        if ((nHostilePresent == FALSE) && (nPopPresent == FALSE))
            {
            nMadeChoice = TRUE;
            if ((oOptionWP1 == OBJECT_INVALID) && (nOptionSlot1 == 0))
                {
                oOptionWP1 = oWPScan;
                nOptionSlot1 = nCountB;
                }
            else if ((oOptionWP2 == OBJECT_INVALID) && (nOptionSlot2 == 0))
                {
                oOptionWP2 = oWPScan;
                nOptionSlot2 = nCountB;
                }
            else if ((oOptionWP3 == OBJECT_INVALID) && (nOptionSlot3 == 0))
                {
                oOptionWP3 = oWPScan;
                nOptionSlot3 = nCountB;
                }
            else if ((oOptionWP4 == OBJECT_INVALID) && (nOptionSlot4 == 0))
                {
                oOptionWP4 = oWPScan;
                nOptionSlot4 = nCountB;
                }
            }
        nCount++;
        sScanLink = GetSubString(sBufferLink,(nCount * 5),4);
        }
    }
int nMoveStr;
if (nMadeChoice == TRUE)
    {
    int nOptionRoll;
    int nCountZ;
    int nCrapZ;
    for (nCountZ = 1; nCountZ < d10(); nCountZ ++)
        {
        nCrapZ = Random(4);
        }
    if ((oOptionWP4 != OBJECT_INVALID) && (nOptionSlot1 != 0)) nOptionRoll = Random(4) + 1;
    else if ((oOptionWP3 != OBJECT_INVALID) && (nOptionSlot1 != 0)) nOptionRoll = Random(3) + 1;
    else if ((oOptionWP2 != OBJECT_INVALID) && (nOptionSlot1 != 0)) nOptionRoll = Random(2) + 1;
    else if ((oOptionWP1 != OBJECT_INVALID) && (nOptionSlot1 != 0)) nOptionRoll = 1;
    if (nOptionRoll == 1)
        {
        oChooseWP = oOptionWP1;
        nChooseSlot = nOptionSlot1;
        }
    else if (nOptionRoll == 2)
        {
        oChooseWP = oOptionWP2;
        nChooseSlot = nOptionSlot2;
        }
    else if (nOptionRoll == 3)
        {
        oChooseWP = oOptionWP3;
        nChooseSlot = nOptionSlot3;
        }
    else if (nOptionRoll == 4)
        {
        oChooseWP = oOptionWP4;
        nChooseSlot = nOptionSlot4;
        }

    if (nOverflow == TRUE)
        {
        nMoveStr = nBaseStr - 100;
        nBaseStr -= nMoveStr;
        if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B") != "")
            {
            if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B") != "DELETE")
            nMoveStr += StringToInt(GetSubString(GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B"),5,3));
            }
        else if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)) != "")
            nMoveStr += StringToInt(GetSubString(GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)),5,3));

        SetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B",GetSubString(sBasePop,0,4)+"_"+IntToString(nMoveStr));
        SetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B",GetSubString(sBasePop,0,4)+"_"+IntToString(nBaseStr));
        }
    else
        {
        nMoveStr = nBaseStr;
        if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B") != "")
            {
            if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B") != "DELETE")
            nMoveStr += StringToInt(GetSubString(GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B"),5,3));
            }
        else if (GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)) != "")
            nMoveStr += StringToInt(GetSubString(GetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)),5,3));

        SetLocalString(oChooseWP,"Pop"+IntToString(nChooseSlot)+"_B",GetSubString(sBasePop,0,4)+"_"+IntToString(nMoveStr));
        SetLocalString(oAreaWP,"Pop"+IntToString(nSlot)+"_B","DELETE");
        }
    }
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
        nHostile = GetPopHostile(oWP,nCountPop);
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
// Old Prohibition on SHLD pop growing or migrating
//        if (GetSubString(sPop,0,4) == "SHLD")
//            {
//            nCountPop ++;
//            sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
//            continue;
//            }
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
        sBufferZ = GetLocalString(oWP,"Pop"+IntToString(nCountPop)+"_B");
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
        if (nPopStr > 100) PopMove(oWP,nCountPop,TRUE);
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

string sPrint = SayLogTime()+" <mpop_process> ";
nCountWP = 0;
oWP = GetObjectByTag("MPOP",nCountWP);
while (oWP != OBJECT_INVALID)
    {
    sPrint = sPrint + "["+IntToString(nCountWP)+"] ";
    sPopGrow = GetLocalString(oWP,"GROWTH");
    if (sPopGrow != "") sPrint = sPrint + "(" + sPopGrow + ") ";
    nCountPop = 1;
    sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
    while (sPop != "")
        {
        sPrint = sPrint + sPop + " ";
        nCountPop ++;
        sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
        }
    nCountWP ++;
    oWP = GetObjectByTag("MPOP",nCountWP);
    }
PrintString(sPrint);
}
