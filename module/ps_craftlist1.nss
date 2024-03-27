int StartingConditional()
{
object oPC = GetPCSpeaker();
int nPlace  = GetLocalInt(oPC,"nPlace");
int nTotal = GetLocalInt(oPC,"nTotal");
if (nPlace <= nTotal) return TRUE;
return FALSE;
}
