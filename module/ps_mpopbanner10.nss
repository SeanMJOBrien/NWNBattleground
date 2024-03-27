int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(OBJECT_SELF,"SeedStr") < 5) return FALSE;
return TRUE;
}
