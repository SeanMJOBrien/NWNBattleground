void main()
{
object oPC = GetExitingObject();
DeleteLocalInt(oPC,"WRTRIG");
object oScan = GetFirstObjectInArea(GetArea(OBJECT_SELF));
while (oScan != OBJECT_INVALID)
    {
    if ((oScan != oPC) && (GetLocalInt(oScan,"WRTRIG"))) return;
    oScan = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }
object oInvisibleObject = GetNearestObjectByTag("RavineHatch");
SetLocalInt(oInvisibleObject,"Reset",1);
}
