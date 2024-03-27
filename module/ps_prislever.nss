void main()
{
//SpawnScriptDebugger();
string sTag = GetTag(OBJECT_SELF);
string sBuffer = "DR_" + GetSubString(sTag,0,1);
int nCount = 1;

object oDoor = GetNearestObjectByTag(sBuffer);
PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
DelayCommand(6.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
DelayCommand(0.5,SetLocked(oDoor,FALSE));
DelayCommand(1.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
DelayCommand(1.5,SetLocked(oDoor,TRUE));
while (GetSubString(sTag,nCount,1) != "")
    {
    sBuffer = "DR_" + GetSubString(sTag,nCount,1);
    oDoor = GetNearestObjectByTag(sBuffer);
    if (GetIsOpen(oDoor))
        {
        DelayCommand(0.5,SetLocked(oDoor,FALSE));
        DelayCommand(1.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
        DelayCommand(1.5,SetLocked(oDoor,TRUE));
        }
    nCount++;
    }

}
