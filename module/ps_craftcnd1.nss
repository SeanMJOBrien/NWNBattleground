#include "ps_timestamp"
#include "ps_craftsman"

int StartingConditional()
{
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
object oPC = GetPCSpeaker();
object oScan = GetFirstItemInInventory(oPC);
while (oScan != OBJECT_INVALID)
    {
    if ((GetTag(oScan) == "VOUCHER") && (GetIsLaterThan(oScan) == 1)&&(GetName(GetArea(OBJECT_SELF)) == GetLocalString(oScan,"MerchantID")))
        {
        string sResRef = GetLocalString(oScan,"ResRef");
        DestroyObject(oScan);
        object oNew = CreateItemOnObject(sResRef,oPC);
        SetCustomToken(301,GetName(oNew));
        return TRUE;
        }
    oScan = GetNextItemInInventory(oPC);
    }
return FALSE;
}
