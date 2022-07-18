void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_goodtowncenter";SetLocalString(OBJECT_SELF,"moveto","wp_goodtowncenter");}
if (iSide==2) {sWP = "wp_eviltowncenter";SetLocalString(OBJECT_SELF,"moveto","wp_eviltowncenter");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
