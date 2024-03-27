int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 59) return TRUE;
return FALSE;
}
