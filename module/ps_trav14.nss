int StartingConditional()
{
object oPC = GetPCSpeaker();
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
if (nHoursTraveled >= 6) SetCustomToken(365,"[Press on with a forced march.]");
else SetCustomToken(365,"[Journey onward.]");
return TRUE;

}
