#include "ps_mpop_process"

void main()
{
//SpawnScriptDebugger();
int nCountMPOP = 0;
object oMPOP = GetObjectByTag("MPOP",nCountMPOP);

int nMinCR;
int nMaxCR;

string sPOPS = GetLocalString(GetModule(),"POPS");
string sPOPSParse;
int nPOPSCount;
int nParseCount;
int nScanCR;

string sPOPSBuild;

int nCountPop;
int sParsePop;
string sPopChoose;
int nPopChoose;
int nPopTrack;
int nPopChance;

int nIncrementalStr;
int nMPOPStr;

while (oMPOP != OBJECT_INVALID)
    {
//    if (GetName(oMPOP) == "BGS2") SpawnScriptDebugger();
    sPOPSBuild = "";
    nMinCR = GetLocalInt(oMPOP,"MinCR");
    nMaxCR = GetLocalInt(oMPOP,"MaxCR");
    if ((nMinCR != 0) || (nMaxCR != 0))
        {
        int nCountPop = 1;
        string sParsePop = GetLocalString(oMPOP,"Pop"+IntToString(nCountPop));
        while (sParsePop != "")
            {
            DeleteLocalString(oMPOP,"Pop"+IntToString(nCountPop));
            DeleteLocalString(oMPOP,"Pop"+IntToString(nCountPop)+"_B");
            nCountPop ++;
            sParsePop = GetLocalString(oMPOP,"Pop"+IntToString(nCountPop));
            }
        nCountPop = 1; // Pop Number 1, 2, 3

        if (nMaxCR == 0) nMaxCR = 100;
        if (nMinCR >= nMaxCR) nMinCR = 0;
        nParseCount = 0; // Placeholder
        nPOPSCount = 0;  // Count # of POPS within given CR range
        sPOPSParse = GetSubString(sPOPS,nParseCount,4);
        while (sPOPSParse != "")
            {
            if ((GetLocalInt(GetModule(),GetStringUpperCase(sPOPSParse)+"_CR") >= nMinCR)
                && (GetLocalInt(GetModule(),GetStringUpperCase(sPOPSParse)+"_CR") <= nMaxCR)
//                && (sPOPSParse != "SHLD") && (CompareForHostile(sPOPSParse, "SHLD")))
                && (sPOPSParse != "SHLD"))
                    {
                    nPopChance = GetLocalInt(GetModule(),sPOPSParse+"_CHANCE");
                    if ((d100() <= nPopChance) || (nPopChance == 0))
                        {
                        sPOPSBuild = sPOPSBuild + sPOPSParse + "_";
                        nPOPSCount++;
                        }
                    }
            nParseCount += 5;
            sPOPSParse = GetSubString(sPOPS,nParseCount,4);
            }
        if (nPOPSCount > 0)
            {
            nPopChoose = Random(nPOPSCount) + 1;
            sPopChoose = "";
            nParseCount = 0;
            nPopTrack = 0;
            sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
            while (sPOPSParse != "")
                {
                nPopTrack ++;
                if (nPopTrack == nPopChoose)
                       {
                       sPopChoose = sPOPSParse;
                       break;
                       }
                nParseCount += 5;
                sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
                }
            if (sPopChoose != "")
                {
                nIncrementalStr = d6(4) * 10;
                nMPOPStr = nIncrementalStr;
                SetLocalString(oMPOP,"Pop1",sPopChoose+"_"+IntToString(nIncrementalStr));
                if (d100() < (170 - nMPOPStr))
                    {
                    nPopChoose = Random(nPOPSCount) + 1;
                    sPopChoose = "";
                    nParseCount = 0;
                    nPopTrack = 0;
                    sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
                while (sPOPSParse != "")
                    {
                    nPopTrack ++;
                    if (nPopTrack == nPopChoose)
                           {
                           sPopChoose = sPOPSParse;
                           break;
                           }
                    nParseCount += 5;
                    sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
                    }
                    if ((sPopChoose != "") && (sPopChoose != GetSubString(GetLocalString(oMPOP,"Pop1"),0,4)))
                        {
                        nIncrementalStr = d10(2) * 10;
                        nMPOPStr += nIncrementalStr;
                        SetLocalString(oMPOP,"Pop2",sPopChoose+"_"+IntToString(nIncrementalStr));
                        if (d100() < (230 - nMPOPStr))
                            {
                            nPopChoose = Random(nPOPSCount) + 1;
                            sPopChoose = "";
                            nParseCount = 0;
                            nPopTrack = 0;
                            sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
                        while (sPOPSParse != "")
                            {
                            nPopTrack ++;
                            if (nPopTrack == nPopChoose)
                                {
                                sPopChoose = sPOPSParse;
                                break;
                                }
                            nParseCount += 5;
                            sPOPSParse = GetSubString(sPOPSBuild,nParseCount,4);
                            }
                           if ((sPopChoose != "")  && (sPopChoose != GetSubString(GetLocalString(oMPOP,"Pop1"),0,4))
                            && (sPopChoose != GetSubString(GetLocalString(oMPOP,"Pop2"),0,4)))
                                {
                                nIncrementalStr = d8(2) * 10;
                                nMPOPStr += nIncrementalStr;
                                SetLocalString(oMPOP,"Pop3",sPopChoose+"_"+IntToString(nIncrementalStr));
                                }
                           }
                        }//if (sPopChoose != "")
                    }//if (d100() < (100 - nMPOPStr))
                }//if (sPopChoose != "")

            }//if (nPOPSCount > 0)

        }//if ((fMinCR != 0.0) || (fMaxCR != 0.0))

    nCountMPOP ++;
    oMPOP = GetObjectByTag("MPOP",nCountMPOP);
    }

}
