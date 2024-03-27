int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) < 3) return TRUE;
return FALSE;
}
