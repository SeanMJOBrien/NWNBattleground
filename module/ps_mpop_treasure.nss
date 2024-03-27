void main()
{
if (GetLocalInt(OBJECT_SELF,"DoOnce") == 1) return;
object oArea = OBJECT_SELF;
object oScan = GetFirstObjectInArea();
object oMPOP;
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "MPOP")
        {
        oMPOP = oScan;
        break;
        }
    oScan = GetNextObjectInArea();
    }
if (oMPOP == OBJECT_INVALID) oMPOP = GetNearestObjectByTag("MPOP",GetWaypointByTag(GetTag(oArea)));
int nCount;
int nHighestPop;
string sChoosePop;
string sBuffer;
for (nCount = 1; nCount < 9; nCount++)
    {
    sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    if (sBuffer == "") continue;
    if ((StringToInt(GetSubString(sBuffer,5,3)) * (GetLocalInt(GetModule(),GetSubString(sBuffer,0,4)+"_CR"))) > nHighestPop)
        {
        sChoosePop = GetSubString(sBuffer,0,4);
        nHighestPop = StringToInt(GetSubString(sBuffer,5,3));
        }
    }
if (sChoosePop != "")
    {
    object oChest = GetObjectByTag(sChoosePop+"_LOOT");
    int nGold = GetLocalInt(oChest,"GOLD");
    int nCount; int nCountB;
    int nPick; int nGiveGold;
    int nShares;
    object oScan = GetFirstItemInInventory(oChest);
    while (oScan != OBJECT_INVALID)
        {
        nCount ++;
        oScan = GetNextItemInInventory(oChest);
        }
    int nMaxShares = d6();
    while (nShares <=  nMaxShares)
        {
        nShares ++;
        nPick = Random(nCount) + 1;
        nCountB = 1;
        oScan = GetFirstItemInInventory(oChest);
        object oSelf = OBJECT_SELF;
        while (oScan != OBJECT_INVALID)
            {
            if (nCountB == nPick)
                {
                CopyItem(oScan,oSelf);
                break;
                }
            nCountB ++;
            oScan = GetNextItemInInventory(oChest);
            }
        nGiveGold = 0;
        if (nGold != 0) nGiveGold = Random(nGold) + 1;
        if (nGiveGold > 0) GiveGoldToCreature(OBJECT_SELF,nGiveGold);
        }
    }
SetLocalInt(OBJECT_SELF,"DoOnce",1);
}
