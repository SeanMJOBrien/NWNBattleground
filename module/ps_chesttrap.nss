void main()
{
object oDoorN = GetObjectByTag("ps_trogdr3n");
object oDoorE = GetObjectByTag("ps_trogdr3e");
location lTrollSpawn = GetLocation(GetWaypointByTag("ps_TrollSpawn"));
location lTrollHatchSpawn = GetLocation(GetWaypointByTag("ps_TrollHatchSpawn"));
location lTrollWP1 = GetLocation(GetWaypointByTag("ps_TrollWP1"));
location lTrollWP2 = GetLocation(GetWaypointByTag("ps_TrollWP2"));

ActionCloseDoor(oDoorE);
ActionCloseDoor(oDoorN);
object oTrollHatch = CreateObject(OBJECT_TYPE_PLACEABLE,"nw_pl_hiddendr03",lTrollHatchSpawn,FALSE,"TrollHatch");
object oTroll = CreateObject(OBJECT_TYPE_CREATURE,"nw_troll",lTrollSpawn);
DelayCommand(5.0,AssignCommand(oTrollHatch,PlayAnimation(ANIMATION_PLACEABLE_OPEN)));
DelayCommand(6.0,AssignCommand(oTroll,ActionJumpToLocation(lTrollWP1)));
DelayCommand(6.5,AssignCommand(oTroll,ActionMoveToLocation(lTrollWP2,TRUE)));

DelayCommand(90.0,ActionOpenDoor(oDoorE));
DelayCommand(90.0,ActionOpenDoor(oDoorN));
}
