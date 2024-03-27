void main()
{
object oPC = GetLastOpenedBy();
object oDoor = OBJECT_SELF;
object oTargetArea = GetArea(GetTransitionTarget(oDoor));
object oScan;
int nPCPresent = FALSE;
if ((GetIsNight()) && (GetLocalInt(oDoor,"PlayerUnlocked") == FALSE))
    {
    ActionCloseDoor(oDoor);
    SetLocked(oDoor,1);
    }
else
    {
    if (GetLocked(oDoor)) SetLocked(oDoor,0);
    }
DelayCommand(30.0,ActionCloseDoor(oDoor));
}
