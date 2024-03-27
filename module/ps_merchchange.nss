void MerchantDaychange(object oMerchant)
{
object oImportChest = GetObjectByTag("IMPORT_CHEST");
int nChestCount = 0;
object oItemScan;
int nStoreGold = GetStoreGold(oMerchant);
int nChanceSell = GetLocalInt(oMerchant,"TOSELL");
int nNumImport = GetLocalInt(oMerchant,"TOBUY");
if (nChanceSell == 0) nChanceSell = 50;
if (nNumImport == 0) nNumImport = 10;
int nImport = Random(nNumImport) + 1;
oItemScan = GetFirstItemInInventory(oMerchant);
while (oItemScan != OBJECT_INVALID)
    {
    if (((Random(100)+ 1) < nChanceSell)
        && (!GetLocalInt(oItemScan,"QUEST")))
            {
            nStoreGold += (GetGoldPieceValue(oItemScan))/2;
            DestroyObject(oItemScan);
            }
    oItemScan = GetNextItemInInventory(oMerchant);
    }
int nCount;
oItemScan = GetFirstItemInInventory(oImportChest);
while (oItemScan != OBJECT_INVALID)
    {
    nChestCount++;
    oItemScan = GetNextItemInInventory(oImportChest);
    }
int nChoose;
int nToggle;
for (nCount = 1; nCount <= nImport; nCount ++)
    {
    nChoose = Random(nChestCount) + 1;
    nToggle = 1;
    oItemScan = GetFirstItemInInventory(oImportChest);
    while (oItemScan != OBJECT_INVALID)
        {
        if (nToggle == nChoose)
            {
            if (GetGoldPieceValue(oItemScan) <= nStoreGold)
                {
                CopyItem(oItemScan,oMerchant,TRUE);
                nStoreGold -= GetGoldPieceValue(oItemScan);
                }
                break;
            }
        nToggle++;
        oItemScan = GetNextItemInInventory(oImportChest);
        }
    }
SetStoreGold(oMerchant,nStoreGold);
}
