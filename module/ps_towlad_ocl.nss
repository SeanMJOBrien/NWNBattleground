void main()
{
object oTDoor = GetObjectByTag("CM_TOW_TRP_OUT");
AssignCommand(oTDoor,ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
}
