void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodrock";SetLocalString(OBJECT_SELF,"moveto","wp_goodrock");}
if (iSide==2) {sWP = "wp_evilrock";SetLocalString(OBJECT_SELF,"moveto","wp_evilrock");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
