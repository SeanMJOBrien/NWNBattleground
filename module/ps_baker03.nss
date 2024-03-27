int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetGold(oPC) >= 4) return TRUE;
return FALSE;

}
