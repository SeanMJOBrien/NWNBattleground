#include "ps_craftsman"

void main()
{
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
int nCount;
object oBuffer;
string sBuffer;
int nBuffer;

object oPC = GetFirstPC();
while (oPC != OBJECT_INVALID)
    {
    if (oPC == GetPCSpeaker())
        {
        oPC = GetNextPC();
        continue;
        }
    nCount = 1;
    oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
    SetLocalObject(oBuffer,"Owner",oPC);
    DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
    while (oBuffer != OBJECT_INVALID)
            {
            nCount++;
            oBuffer = RetrieveCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),GetLocation(oStores),oStores);
            SetLocalObject(oBuffer,"Owner",oPC);
            DeleteCampaignVariable("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount));
            }
     oPC = GetNextPC();
     }
int nListPlace = 1;
nCount = 0;
object oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
        nCount ++;
        if ((nCount >= nListPlace)  && (nCount < (nListPlace + 10)))
            {
            SetCustomToken((310+(nCount - nListPlace +1)),GetName(oScan));
            if (GetTag(oScan) == "VOUCHER") SetCustomToken((320+(nCount - nListPlace +1)),"unknown value of");
            else SetCustomToken((320+(nCount - nListPlace +1)),IntToString(GetGoldPieceValue(oScan)* 2));
            SetLocalObject(oStores,"Item"+IntToString(nCount - nListPlace +1),oScan);
            }
    oScan = GetNextItemInInventory(oStores);
    }
SetLocalInt(oStores,"ListCount",nCount);
SetLocalObject(GetPCSpeaker(),"Container",oStores);
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("CW_WAREHOUSE_STORES"));
}
