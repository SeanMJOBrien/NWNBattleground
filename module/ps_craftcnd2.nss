#include "ps_timestamp"

int StartingConditional()
{
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
object oPC = GetPCSpeaker();
object oScan = GetFirstItemInInventory(oPC);
object oFlag = OBJECT_INVALID;
int nMonths;
int nDays;
int nHours;
int nMinHours = 0;
string sSay = "";
while (oScan != OBJECT_INVALID)
    {
    if ((GetTag(oScan) == "VOUCHER") && (GetIsLaterThan(oScan) == 0) && (GetLocalString(oScan,"MerchantID") == GetName(GetArea(OBJECT_SELF))))
        {
        nHours = GetHoursTill(oScan);
        if ((nMinHours == 0) || (nHours < nMinHours))
            {
            nMinHours = nHours;
            oFlag = oScan;
            }
        }
    oScan = GetNextItemInInventory(oPC);
    }
if ((nMinHours > 0) && (oFlag != OBJECT_INVALID))
    {
    nHours = GetHoursTill(oFlag);
        while (nHours > 23)
            {
            nHours = nHours - 24;
            nDays++;
            }
        while (nDays > 27)
            {
            nDays = nDays - 28;
            nMonths ++;
            }
        if ((nMonths == 0) && (nDays == 0) && (nHours > 0))
            {
            sSay = IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths == 0) && (nDays > 0) && (nHours == 0))
            {
            sSay = IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays == 0) && (nHours == 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays > 0) && (nHours == 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays == 0) && (nHours > 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths == 0) && (nDays > 0) && (nHours > 0))
            {
            sSay = IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays > 0) && (nHours > 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+", "+IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
    SetCustomToken(302,sSay);
    return TRUE;
    }
return FALSE;
}
