void DetermineQuestsItems(int nGive)
{
//SpawnScriptDebugger();
object oQuestChest = GetObjectByTag("QUEST_CHEST");
string sPops = GetLocalString(GetModule(),"POPS");
int nParseCount = 0;
string sParse= GetSubString(sPops,nParseCount,4);
int nChestCount;
int nMPOPCount;
object oMPOPScan;
int nPopPresent;
int nChanceToSteal;
int nPopScanner;
string sPopScanner;
object oTreasureType;
int nAlreadyHave;
object oScan;
object oQuestItem;
string sToTell;
int nPick;
string sMPOPName;

// Cycle through possible MPOP codes.
while (sParse != "")
    {
    nPopPresent = FALSE;
    oQuestItem = OBJECT_INVALID;
// Could the MPOP possibly steal an item?
    nChanceToSteal = GetLocalInt(GetModule(),sParse+"_QUEST");
    if (nChanceToSteal == 0)
        {
        nParseCount += 5;
        sParse = GetSubString(sPops,nParseCount,4);
        continue;
        }
// Is the MPOP present on the board?
    nMPOPCount = 0;
    oMPOPScan = GetObjectByTag("MPOP",nMPOPCount);
    while (oMPOPScan != OBJECT_INVALID)
        {
        nPopScanner = 1;
        sPopScanner = GetSubString(GetLocalString(oMPOPScan,"Pop"+IntToString(nPopScanner)),0,4);
        while (sPopScanner != "")
            {
            if (sPopScanner == sParse)
                {
                nPopPresent = TRUE;
                break;
                }
            nPopScanner ++;
            sPopScanner = GetSubString(GetLocalString(oMPOPScan,"Pop"+IntToString(nPopScanner)),0,4);
            }
        if (nPopPresent == TRUE) break;
        nMPOPCount ++;
        oMPOPScan = GetObjectByTag("MPOP",nMPOPCount);
        }
//If the Population is present on the board...
    if (nPopPresent == TRUE)
        {
        nAlreadyHave = FALSE;
        oTreasureType = GetObjectByTag(sParse+"_TT");
        if (oTreasureType != OBJECT_INVALID)
            {
//Does the MPOP already have a quest item...
            oScan = GetFirstItemInInventory(oTreasureType);
            while (oScan != OBJECT_INVALID)
                {
                if (GetLocalInt(oScan,"QUEST") == TRUE)
                    {
                    oQuestItem = oScan;
                    nAlreadyHave = TRUE;
                    break;
                    }
                oScan = GetNextItemInInventory(oTreasureType);
                }
// If no quest item already, determine if we should plant one.
            if  ((nGive == TRUE) && (nAlreadyHave == FALSE) && (d100(1) <= nChanceToSteal))
                {
                nChestCount = 0;
                oScan = GetFirstItemInInventory(oQuestChest);
                while (oScan != OBJECT_INVALID)
                    {
                    nChestCount ++;
                    oScan = GetNextItemInInventory(oQuestChest);
                    }
                if (nChestCount != 0)
                    {
                    nPick = Random(nChestCount) + 1;
                    nChestCount = 0;
                    oScan = GetFirstItemInInventory(oQuestChest);
                    while (oScan != OBJECT_INVALID)
                        {
                        nChestCount ++;
                        if (nChestCount == nPick)
                            {
                            oQuestItem = oScan;
                            SetLocalInt(oQuestItem,"QUEST",1);
                            SetLocalInt(oQuestItem,"Unique",1);
                            AssignCommand(oQuestChest,ActionGiveItem(oQuestItem,oTreasureType));
                            break;
                              }
                        oScan = GetNextItemInInventory(oQuestChest);
                        }
                    }
                }
//If the MPOP has a quest item.. add it to the list.
            if (oQuestItem != OBJECT_INVALID)
                {
                sMPOPName = GetLocalString(GetModule(),sParse+"_NAME");
                switch (d4())
                    {
                    case 1:
                    sToTell += "The "+GetName(oQuestItem)+" is believed to be in the possession of the "+sMPOPName+". ";
                    break;
                    case 2:
                    sToTell += "The "+GetName(oQuestItem)+" has been stolen by the "+sMPOPName+". ";
                    break;
                    case 3:
                    sToTell += "The "+sMPOPName+" is believed to be holding the "+GetName(oQuestItem)+". ";
                    break;
                    case 4:
                    sToTell += "The "+sMPOPName+" has most devilishly stolen the "+GetName(oQuestItem)+". ";
                    break;
                    }
                }
            }
        }
    nParseCount += 5;
    sParse = GetSubString(sPops,nParseCount,4);
    }
SetLocalString(GetModule(),"QUEST_LIST",sToTell);
}
