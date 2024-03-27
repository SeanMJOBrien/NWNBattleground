int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 39) return TRUE;
return FALSE;
}
