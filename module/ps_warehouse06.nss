#include "ps_timestamp"

int StartingConditional()
{
object oContainer = GetObjectByTag("CW_WAREHOUSE_STORES");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);
object oWP = GetWaypointByTag("VOUCHER_READ");
string sResRef = GetLocalString(oItem,"ResRef");
object oTest = CreateObject(OBJECT_TYPE_ITEM,sResRef,GetLocation(oWP),FALSE);
SetLocalInt(oItem,"Value",(GetGoldPieceValue(oTest) * 2));
SetCustomToken(331,GetName(oTest));
SetCustomToken(333,IntToString(GetGoldPieceValue(oTest) * 2));
DestroyObject(oTest);
int nHours = GetHoursTill(oItem);
if (nHours <= 0) SetCustomToken(332,"is mature.");
else SetCustomToken(332,"will mature in another "+SayHours(nHours)+".");
if (GetTag(oItem) == "VOUCHER") return TRUE;
return FALSE;
}
