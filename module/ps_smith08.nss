int StartingConditional()
{
object oContainer = GetLocalObject(GetPCSpeaker(),"Container");
object oItem = GetLocalObject(oContainer,"Item"+IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose")));
if (GetGold(GetPCSpeaker()) < GetGoldPieceValue(oItem)) return TRUE;
return FALSE;
}
