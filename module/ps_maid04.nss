int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) >= 12) return TRUE;
return FALSE;
}
