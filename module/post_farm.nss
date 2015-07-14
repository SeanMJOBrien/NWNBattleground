void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodfarm";SetLocalString(OBJECT_SELF,"moveto","wp_goodfarm");}
if (iSide==2) {sWP = "wp_evilfarm";SetLocalString(OBJECT_SELF,"moveto","wp_evilfarm");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
