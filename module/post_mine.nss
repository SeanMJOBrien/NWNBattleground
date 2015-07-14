void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodmine";SetLocalString(OBJECT_SELF,"moveto","wp_goodmine");}
if (iSide==2) {sWP = "wp_evilmine";SetLocalString(OBJECT_SELF,"moveto","wp_evilmine");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
