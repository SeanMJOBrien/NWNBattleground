void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_post_good_hunt";SetLocalString(OBJECT_SELF,"moveto","wp_post_good_hunt");}
if (iSide==2) {sWP = "wp_post_evil_hunt";SetLocalString(OBJECT_SELF,"moveto","wp_post_evil_hunt");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
