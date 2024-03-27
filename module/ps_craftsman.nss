#include "ps_timestamp"

void CreateVoucherOn(object oTarget, object oItem)
{
int nDebitHour = GetLocalInt(oTarget,"DebitHour");
string sResRef = GetResRef(oItem);
int nValue = GetGoldPieceValue(oItem);
if (GetBaseItemType(oItem) == BASE_ITEM_SPELLSCROLL) nValue = nValue / 6;
int nCraftMultiplier = GetLocalInt(GetModule(),"CraftMultiplier");
if (nCraftMultiplier == 0) nCraftMultiplier = 10;
float fDays = IntToFloat(nValue) / IntToFloat(nCraftMultiplier);
float fHoursRemainder = (fDays - IntToFloat(FloatToInt(fDays))) * 24;
int nDays = FloatToInt(fDays);
int nHours = (nDays * 24) + FloatToInt(fHoursRemainder);
if ((nDays == 0) && (nHours == 0)) nHours = 1;
if (nDebitHour > 0)
    {
    if ((nDebitHour - nHours) > 0)
        {
        nDebitHour -= nHours;
        SetLocalInt(oTarget,"DebitHour",nDebitHour);
        nHours = -1;
        SendMessageToPC(oTarget,"This request has consumed debited time. You are now debited "+SayHours(nDebitHour)+". The voucher you just recieved is automatically mature.");
        }
    else if ((nHours - nDebitHour) > 0)
        {
        DeleteLocalInt(oTarget,"DebitHour");
        nHours -= nDebitHour;
        SendMessageToPC(oTarget,"You have consumed all of your debited time towards the maturation of this voucher. You have no more debited time. The voucher will be mature in "+SayHours(nHours)+".");
        }
    else if ((nHours - nDebitHour) == 0)
        {
        DeleteLocalInt(oTarget,"DebitHour");
        nHours = -1;
        SendMessageToPC(oTarget,"You have consumed all of your debited time towards the maturation of this voucher. You have no more debited time. The voucher you just recieved is automatically mature.");
        }
    }
object oVoucher = CreateItemOnObject("ps_voucher",oTarget);
AdvanceTimeStamp(oVoucher,0,0,0,nHours);
SetLocalString(oVoucher,"ResRef",sResRef);
SetLocalString(oVoucher,"MerchantID",GetName(GetArea(OBJECT_SELF)));
}

void HonorVoucher(object oVoucher)
{
if ((GetHoursTill(oVoucher) > 0) || (GetHoursTill(oVoucher) == -1)) return;
string sResRef = GetLocalString(oVoucher,"ResRef");
object oPC = GetItemPossessor(oVoucher);
DestroyObject(oVoucher);
object oNew = CreateItemOnObject(sResRef,oPC);
SetCustomToken(301,GetName(oNew));
}

void GenerateStoreList(string sContainerTag, int nListPlace = 1)
{
//SpawnScriptDebugger();
object oContainer = GetObjectByTag(sContainerTag);
if (oContainer == OBJECT_INVALID) return;
int nCount = 0;
int nValue;
object oScan = GetFirstItemInInventory(oContainer);
while (oScan != OBJECT_INVALID)
    {
        nCount ++;
        if ((nCount >= nListPlace)  && (nCount < (nListPlace + 10)))
            {
            SetCustomToken((310+(nCount - nListPlace +1)),GetName(oScan));
            nValue = GetGoldPieceValue(oScan);
            if (GetBaseItemType(oScan) == BASE_ITEM_SPELLSCROLL) nValue = nValue / 6;
            SetCustomToken((320+(nCount - nListPlace +1)),IntToString(nValue));
            SetLocalObject(oContainer,"Item"+IntToString(nCount - nListPlace +1),oScan);
            }
    oScan = GetNextItemInInventory(oContainer);
    }
SetLocalInt(oContainer,"ListCount",nCount);
}



void WipeStoreList(string sContainerTag)
{
object oContainer = GetObjectByTag(sContainerTag);
if (oContainer == OBJECT_INVALID) return;
int nCount;
for (nCount = 1; nCount < 11; nCount++)
    {
    DeleteLocalObject(oContainer,"Item"+IntToString(nCount));
    }
}

int CountStore(string sContainerTag)
{
object oContainer = GetObjectByTag(sContainerTag);
if (oContainer == OBJECT_INVALID) return -1;
int nCount = 0;
object oScan = GetFirstItemInInventory(oContainer);
while (oScan != OBJECT_INVALID)
    {
        nCount ++;
    oScan = GetNextItemInInventory(oContainer);
    }
return nCount;
}
