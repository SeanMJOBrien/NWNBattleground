int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 9) return TRUE;
return FALSE;
}
