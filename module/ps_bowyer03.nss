int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 1) return TRUE;
return FALSE;
}
