int StartingConditional()
{
object oPC = GetPCSpeaker();
int iRace = GetRacialType(oPC);

if (iRace!=RACIAL_TYPE_HUMAN) return FALSE;
else return TRUE;
}
