void main()
{
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
if (GetFirstItemInInventory(oStores) != OBJECT_INVALID)
    {
    object oScan;
    object oPC;
    int nCount = 1;
    oScan = GetFirstItemInInventory(oStores);
    while (oScan != OBJECT_INVALID)
        {
        oPC = GetLocalObject(oScan,"Owner");
        StoreCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),oScan);
        nCount ++;
        DestroyObject(oScan);
        oScan = GetNextItemInInventory(oStores);
        }
    }
}
