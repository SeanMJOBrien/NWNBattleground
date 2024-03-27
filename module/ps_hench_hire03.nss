int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 13) return TRUE;
return FALSE;
}
