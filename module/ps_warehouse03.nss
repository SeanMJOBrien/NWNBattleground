#include "ps_craftsman"
void main()
{
int nListPlace = GetLocalInt(GetPCSpeaker(),"nPlace") + 10;
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
int nCount = 0;
object oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
        nCount ++;
        if ((nCount >= nListPlace)  && (nCount < (nListPlace + 10)))
            {
            SetCustomToken((310+(nCount - nListPlace +1)),GetName(oScan));
            SetCustomToken((320+(nCount - nListPlace +1)),IntToString(GetGoldPieceValue(oScan)* 2));
            SetLocalObject(oStores,"Item"+IntToString(nCount - nListPlace +1),oScan);
            }
    oScan = GetNextItemInInventory(oStores);
    }
SetLocalInt(oStores,"ListCount",nCount);
SetLocalInt(GetPCSpeaker(),"nPlace",nListPlace);
}
