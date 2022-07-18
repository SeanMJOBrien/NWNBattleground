void main()
{
object oMod=GetModule();
int iCurrentHour=GetTimeHour();



 if (iCurrentHour!=GetLocalInt(oMod,"lasthour"))
 {
 ExecuteScript("upkeep",oMod);
 SetLocalInt(oMod,"lasthour",iCurrentHour);
 }
}
