int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 0) return TRUE;
return FALSE;
}
