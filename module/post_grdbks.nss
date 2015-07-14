void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_barracks_good";SetLocalString(OBJECT_SELF,"moveto","wp_barracks_good");}
if (iSide==2) {sWP = "wp_barracks_good";SetLocalString(OBJECT_SELF,"moveto","wp_barracks_good");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
