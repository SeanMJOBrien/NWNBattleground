int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) >= 16) return TRUE;
return FALSE;
}
