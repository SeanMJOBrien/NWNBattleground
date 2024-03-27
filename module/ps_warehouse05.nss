int StartingConditional()
{
object oContainer = GetObjectByTag("CW_WAREHOUSE_STORES");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);
if (GetGold(GetPCSpeaker()) < (GetGoldPieceValue(oItem) * 2)) return TRUE;
return FALSE;
}
