void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sWP;
if (iSide==1) {sWP = "wp_baileygate_good";SetLocalString(OBJECT_SELF,"moveto","wp_baileygate_good");}
if (iSide==2) {sWP = "wp_baileygate_evil";SetLocalString(OBJECT_SELF,"moveto","wp_baileygate_evil");}
object oWP = GetWaypointByTag(sWP);
location lDest = GetLocation(oWP);
ActionForceMoveToLocation(lDest,FALSE);
}
