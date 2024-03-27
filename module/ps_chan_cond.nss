int StartingConditional()
{
object oQuestChest = GetObjectByTag("QUEST_CHEST");
object oPC = GetPCSpeaker();
object oItemScan = GetFirstItemInInventory(oPC);
string sSay;
int nGPReward;
int nXPReward;
while (oItemScan != OBJECT_INVALID)
    {
    if (GetLocalInt(oItemScan,"QUEST") == 1)
        {
        nGPReward = GetLocalInt(oItemScan,"GP_REWARD");
        nXPReward = GetLocalInt(oItemScan,"XP_REWARD") * GetHitDice(oPC);
        if (nGPReward == 0) nGPReward = GetGoldPieceValue(oItemScan);
        if (nXPReward == 0) nXPReward = GetHitDice(oPC) * 200;
        GiveGoldToCreature(oPC,nGPReward);
        GiveXPToCreature(oPC,nXPReward);
        AssignCommand(oQuestChest,ActionTakeItem(oItemScan,oPC));
        switch (d4())
            {
            case 1:
            sSay = "Thank you for returning the "+GetName(oItemScan)+".";
            break;
            case 2:
            sSay = "You prove your mettle as a hero by winning back our "+GetName(oItemScan)+".";
            break;
            case 3:
            sSay = "Heironeous smiles upon us. You've brought back the "+GetName(oItemScan)+".";
            break;
            case 4:
            sSay = "Many thanks for returning the "+GetName(oItemScan)+".";
            break;
            }
        SetCustomToken(866,sSay);
        return TRUE;
        }
    oItemScan = GetNextItemInInventory(oPC);
    }
string sQuestList = GetLocalString(GetModule(),"QUEST_LIST");
if (sQuestList == "")
    {
    switch (d4())
        {
        case 1:
        sSay = "We do not know of the whereabouts of any of our missing items at this time.";
        break;
        case 2:
        sSay = "Check back with me another day, perhaps then I'll have clues pertaining to items lost in the Shield Lands.";
        break;
        case 3:
        sSay = "No fresh leads on any of our peoples' treasures today.";
        break;
        case 4:
        sSay = "Check in with me another day, perhaps then I'll be able to give you clues on how to win back the treasures of our people.";
        break;
        }
    }
else sSay = sQuestList;
SetCustomToken(866,sSay);
return TRUE;
}
