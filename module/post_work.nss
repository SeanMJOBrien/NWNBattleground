void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodwork";SetLocalString(OBJECT_SELF,"moveto","wp_goodwork");}
if (iSide==2) {sWP = "wp_evilwork";SetLocalString(OBJECT_SELF,"moveto","wp_evilwork");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
