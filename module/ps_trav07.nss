int StartingConditional()
{
object oPC = GetPCSpeaker();
string sTravelTo = GetLocalString(oPC,"TravelTo");

SetCustomToken(365,sTravelTo);
return TRUE;
}
