int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 19) return TRUE;
return FALSE;
}
