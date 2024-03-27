void main()
{
//SpawnScriptDebugger();
int nFlipped = FALSE;
int nCount = 0;
string sTag = GetTag(OBJECT_SELF);
string sBuffer;
object oDoor;

while (GetSubString(sTag,nCount,1) != "")
    {
    sBuffer = GetSubString(sTag,nCount,1);
    if (sBuffer == "_") nFlipped = TRUE;
    else if ((sBuffer != "")
            && (nFlipped == FALSE))
         {
         oDoor = GetNearestObjectByTag("DR_"+ sBuffer);
         PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        DelayCommand(6.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        DelayCommand(0.5,SetLocked(oDoor,FALSE));
        DelayCommand(1.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
        DelayCommand(1.5,SetLocked(oDoor,TRUE));
         }
    else if ((sBuffer != "")
        && (nFlipped == FALSE))
         {
         oDoor = GetNearestObjectByTag("DR_"+ sBuffer);
         DelayCommand(0.5,SetLocked(oDoor,FALSE));
         DelayCommand(1.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
         DelayCommand(1.5,SetLocked(oDoor,TRUE));
         }
    nCount ++;
    }

}
