int StartingConditional()
{
object oPC = GetPCSpeaker();
SetCustomToken(402,IntToString(GetLocalInt(OBJECT_SELF,"SeedStr")));
return TRUE;

}
