void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_post_good_wood";SetLocalString(OBJECT_SELF,"moveto","wp_post_good_wood");}
if (iSide==2) {sWP = "wp_post_evil_wood";SetLocalString(OBJECT_SELF,"moveto","wp_post_evil_wood");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
