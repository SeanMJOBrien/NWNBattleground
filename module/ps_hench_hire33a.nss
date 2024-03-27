int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 29) return TRUE;
return FALSE;
}
