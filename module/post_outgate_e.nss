void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_outgate_good_e";SetLocalString(OBJECT_SELF,"moveto","wp_outgate_good_e");}
if (iSide==2) {sWP = "wp_outgate_evil_e";SetLocalString(OBJECT_SELF,"moveto","wp_outgate_evil_e");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
