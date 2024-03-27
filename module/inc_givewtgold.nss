/*  inc_givewtgold version 1.0
    Den, Project Lead at Carpe Terra (http://carpeterra.com)

    History:    1.0 initial release */

void GiveWtGoldToCreature(object oPC, int iAmount);
void GiveWtGoldToParty(object oPC, int iAmount, int iSplitType=0);

// ========================================================== //
void GiveWtGoldToCreature(object oPC, int iAmount) {
// ========================================================== //
/*  - gives iAmount gold to oPC
    - if gold amount is over 500, immediately fires gold encumberance
      check, else sets variable that gold was received to be checked
      and cleared on area transition */
    GiveGoldToCreature(oPC, iAmount);
    if (iAmount > 249) ExecuteScript("doa_goldencum", oPC);
}

// ========================================================== //
void GiveWtGoldToParty(object oPC, int iAmount, int iSplitType=0) {
// ========================================================== //
/*  - gives iAmount gold to oPC's party
    - if iSplitType=0 each member in party gets even share,
      iSplitType=1 only members in same area as oPC get share
      iSplitType=2 each member in party gets iAmount (iAmount multiplied
      by number of party members, not split)
    - if gold amount is over 500, immediately fires gold encumberance
      check, else sets variable that gold was received to be checked
      and cleared on area transition */
    int iPartyCount, iRemainderOfGold, iWhichMember;
    int iShareOfGold = iAmount; // everyone initially gets iAmount (type=3)
    object oMember, oArea;

    if (iSplitType < 2) {
        // how many members
        oArea = GetArea(oPC);
        oMember = GetFirstFactionMember(oPC);
        while (GetIsObjectValid(oMember)) {
            if ((iSplitType == 1) && (oArea != GetArea(oMember))) iPartyCount--;
            iPartyCount++;
            oMember = GetNextFactionMember(oPC);
        }
        // calculate share and pick member for remainder
        iShareOfGold = FloatToInt(IntToFloat(iAmount) / IntToFloat(iPartyCount)); // iShareOfGold
        iRemainderOfGold = iAmount - (iShareOfGold * iPartyCount); // iRemainderOfGold
        iWhichMember = Random(iPartyCount); // iWhichMember
    }
    // distribute gold
    iPartyCount = 0; // reused as counter
    oMember = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oMember)) {
        iAmount = TRUE; // reused as conditional
        if (iSplitType == 1 && oArea != GetArea(oMember)) iAmount = FALSE;
        if (iAmount) {
            if (iPartyCount == iWhichMember) GiveGoldToCreature(oMember, iShareOfGold+iRemainderOfGold); // share + remainder
              else GiveGoldToCreature(oMember, iShareOfGold); // share
            if (iShareOfGold > 249) ExecuteScript("doa_goldencum", oMember);
            iPartyCount++;
        }
        oMember = GetNextFactionMember(oPC);
    }
}

//void main(){}

