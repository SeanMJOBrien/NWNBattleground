void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_post_baileybridge_good";SetLocalString(OBJECT_SELF,"moveto","wp_post_baileybridge_good");}
if (iSide==2) {sWP = "wp_post_baileybridge_evil";SetLocalString(OBJECT_SELF,"moveto","wp_post_baileybridge_evil");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
