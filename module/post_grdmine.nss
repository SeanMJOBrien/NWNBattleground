void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_post_good_mine";SetLocalString(OBJECT_SELF,"moveto","wp_post_good_mine");}
if (iSide==2) {sWP = "wp_post_evil_mine";SetLocalString(OBJECT_SELF,"moveto","wp_post_evil_mine");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
