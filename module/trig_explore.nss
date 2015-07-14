void main()
{
object oPC = GetExitingObject();
if (GetIsPC(oPC)==FALSE) return;
ExploreAreaForPlayer(GetArea(oPC),oPC,TRUE);
}
