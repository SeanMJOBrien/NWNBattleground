void main()
{
object oPC = GetLastOpenedBy();
if (GetIsPC(oPC)==FALSE) return;
int iOpened = GetLocalInt(OBJECT_SELF,"opened");
if (iOpened==TRUE) return;
int iHD = GetLocalInt(GetArea(oPC),"depth");
location lWP = GetLocation(GetWaypointByTag("wp_dummychest"));
object oDummy = CreateObject(OBJECT_TYPE_PLACEABLE,"dummychest",lWP);
SetLocalObject(oDummy,"mychest",OBJECT_SELF);
SetLocalInt(oDummy,"mylevel",iHD);
SetLocalInt(OBJECT_SELF,"opened",TRUE);
//create mundane stuff
ExecuteScript("create_potion",oDummy);
if (d6()==1) ExecuteScript("create_potion",oDummy);
//if (d12()==1) ExecuteScript("create_gem",oDummy);
if (d20()==1) ExecuteScript("create_potion",oDummy);
//if (d20()==1) ExecuteScript("create_scroll",oDummy);
//transfer items
DelayCommand(1.0f,ExecuteScript("chest_xfer",oDummy));
//DelayCommand(1.2f,ExecuteScript("unidall",OBJECT_SELF));
DelayCommand(300.0f,SetLocalInt(OBJECT_SELF,"opened",FALSE));
}
