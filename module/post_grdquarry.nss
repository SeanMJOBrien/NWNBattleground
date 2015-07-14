void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_post_good_quarry";SetLocalString(OBJECT_SELF,"moveto","wp_post_good_quarry");}
if (iSide==2) {sWP = "wp_post_evil_quarry";SetLocalString(OBJECT_SELF,"moveto","wp_post_evil_quarry");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
