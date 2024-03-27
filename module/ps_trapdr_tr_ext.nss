void main()
{
object oTrapdoor = GetObjectByTag("CM_TOW_TRP_OUT");
object oPC = GetExitingObject();
if (GetObjectType(oPC) != OBJECT_TYPE_CREATURE) return;
object oTrig = OBJECT_SELF;
object oScan = GetFirstInPersistentObject(oTrig,OBJECT_TYPE_CREATURE);
while (oScan != OBJECT_INVALID)
    {
    if (oScan != oPC) return;
    oScan = GetNextInPersistentObject(oTrig,OBJECT_TYPE_CREATURE);
    }
AssignCommand(oTrapdoor, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
}
