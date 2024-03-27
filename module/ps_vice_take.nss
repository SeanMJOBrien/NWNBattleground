#include "ps_questitems"
#include "X0_I0_PARTYWIDE"

void main()
{
object oQuestChest = GetObjectByTag("QUEST_CHEST");
object oPC = GetPCSpeaker();
object oItemScan = GetFirstItemInInventory(oPC);
string sSay;
int nGPReward;
int nXPReward;
object oMPOPHome = GetWaypointByTag(GetTag(GetArea(OBJECT_SELF)));
object oMPOP = GetNearestObjectByTag("MPOP",oMPOPHome);
object oStandard;
string sPossessor;
int nStandardStrength;
int nSHLDStrength;
int nCount;
string sPop;
for (nCount = 1; nCount < 5; nCount ++)
    {
    sPop = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    if (GetSubString(sPop,0,4) == "SHLD")
        {
        nSHLDStrength = StringToInt(GetSubString(sPop,5,3));
        break;
        }
    }
while (oItemScan != OBJECT_INVALID)
    {
    if (GetLocalInt(oItemScan,"QUEST") == 1)
        {
        nGPReward = GetLocalInt(oItemScan,"GP_REWARD");
        nXPReward = GetLocalInt(oItemScan,"XP_REWARD") * GetHitDice(oPC);
        if (nXPReward == 0) nXPReward = GetFactionAverageLevel(oPC) * 100;
        GiveGoldToAll(oPC,nGPReward);
        GiveXPToAll(oPC,nXPReward);
        AssignCommand(oQuestChest,ActionTakeItem(oItemScan,oPC));
        DetermineQuestsItems(0);
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
        if (nSHLDStrength < 100)
            {
            switch (d2())
                {
                case 1:
                sSay = sSay + " Surely now, Critwall will send reinforcements.";
                break;
                case 2:
                sSay = sSay + " This will rally our men's spirits.";
                break;
                }
            SetLocalString(oMPOP,"Pop"+IntToString(nCount),"SHLD_"+IntToString(nSHLDStrength+50));
            }
        else
            {
            oStandard = GetItemPossessedByParty(oPC,"SHLD_STANDARD");
            if (oStandard == OBJECT_INVALID)
                {
                oStandard = CreateItemOnObject("shld_standard",oPC);
                SetLocalInt(oStandard,"FORCE",50);
                sSay = sSay + " I give you the standard of our army. With it you may act as a vanguard of our forces. You may instruct your force to enter a locale from the wilderness.";
                }
            else if (oStandard != OBJECT_INVALID)
                {
                nStandardStrength = GetLocalInt(oStandard,"FORCE") + 50;
                SetLocalInt(oStandard,"FORCE",nStandardStrength);
                if (GetName(GetItemPossessor(oStandard)) == GetName(oPC))
                    {
                    sSay = sSay + " I shall assign additional troops to march under your standard.";
                    }
                else
                    {
                    sPossessor = GetName(GetItemPossessor(oStandard));
                    sSay = sSay + " I shall assign additional troops to march under "+sPossessor+"'s standard.";
                    }
                }
            }
        SetCustomToken(868,sSay);
        break;
        }
    oItemScan = GetNextItemInInventory(oPC);
    }
}
