void main()
{
object oDoor = GetNearestObjectByTag("ps_lvdr5");
PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
DelayCommand(0.5,SetLocked(oDoor,FALSE));
DelayCommand(1.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
DelayCommand(1.5,SetLocked(oDoor,TRUE));
DelayCommand(21.5,SetLocked(oDoor,FALSE));
DelayCommand(22.5,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
DelayCommand(22.5,SetLocked(oDoor,TRUE));
DelayCommand(23.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

}
