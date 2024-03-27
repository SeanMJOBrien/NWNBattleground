int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) >= 8) return TRUE;
return FALSE;
}
