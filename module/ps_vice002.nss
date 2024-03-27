#include "ps_questitems"
#include "X0_I0_PARTYWIDE"

int StartingConditional()
{
object oQuestChest = GetObjectByTag("QUEST_CHEST");
object oPC = GetPCSpeaker();
object oItemScan = GetFirstItemInInventory(oPC);
string sSay;
int nGPReward;
int nXPReward;
string sQuestList = GetLocalString(GetModule(),"QUEST_LIST");
if (GetLocalInt(GetArea(OBJECT_SELF),"UnderAttack") == TRUE)
    {
    SetCustomToken(866,"We're under attack!");
    return TRUE;
    }

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
