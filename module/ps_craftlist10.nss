int StartingConditional()
{
object oPC = GetPCSpeaker();
int nPlace  = GetLocalInt(oPC,"nPlace");
int nTotal = GetLocalInt(oPC,"nTotal");
if ((nPlace + 9) <= nTotal) return TRUE;
return FALSE;
}
