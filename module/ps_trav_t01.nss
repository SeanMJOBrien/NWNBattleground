int StartingConditional()
{
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
int nProgress = StringToInt(GetSubString(sTravel,5,4));

if (nProgress == 0) return TRUE;
return FALSE;

}
