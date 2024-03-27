void main()
{
object oDoor = GetNearestObjectByTag("ps_troggate");
PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
DelayCommand(0.5,SetLocked(oDoor,FALSE));
DelayCommand(1.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
DelayCommand(1.5,SetLocked(oDoor,TRUE));
}
