void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodhunt";SetLocalString(OBJECT_SELF,"moveto","wp_goodhunt");}
if (iSide==2) {sWP = "wp_evilhunt";SetLocalString(OBJECT_SELF,"moveto","wp_evilhunt");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
