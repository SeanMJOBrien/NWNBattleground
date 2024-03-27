void StoreChange()
{
object oStoreTT;
object oStoreScan;
int nStoreCount;
int nMPOPCount = 0;
object oMPOPScan = GetObjectByTag("MPOP",nMPOPCount);
while (oMPOPScan != OBJECT_INVALID)
    {
    nStoreCount = 1;
    oStoreScan = GetNearestObject(OBJECT_TYPE_STORE,oMPOPScan,nStoreCount);
    while (oStoreScan != OBJECT_INVALID)
        {
        oStoreTT = GetObjectByTag(GetTag(oStoreScan)+"_IMPORT");
        if (oStoreTT != OBJECT_INVALID)
            {

            }
        nStoreCount++;
        oStoreScan = GetNearestObject(OBJECT_TYPE_STORE,oMPOPScan,nStoreCount);
        }
    nMPOPCount++;
    oMPOPScan = GetObjectByTag("MPOP",nMPOPCount);
    }
}
