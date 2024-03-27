int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) > 49) return TRUE;
return FALSE;
}
