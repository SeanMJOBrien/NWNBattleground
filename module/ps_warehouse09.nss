int StartingConditional()
{
object oContainer = GetObjectByTag("CW_WAREHOUSE_STORES");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);

if (GetGold(GetPCSpeaker()) < GetLocalInt(oItem,"Value")) return TRUE;
return FALSE;
}
