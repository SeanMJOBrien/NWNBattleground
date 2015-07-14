void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_outgate_good_w";SetLocalString(OBJECT_SELF,"moveto","wp_outgate_good_w");}
if (iSide==2) {sWP = "wp_outgate_evil_w";SetLocalString(OBJECT_SELF,"moveto","wp_outgate_evil_w");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
