void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodwood";SetLocalString(OBJECT_SELF,"moveto","wp_goodwood");}
if (iSide==2) {sWP = "wp_evilwood";SetLocalString(OBJECT_SELF,"moveto","wp_evilwood");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
