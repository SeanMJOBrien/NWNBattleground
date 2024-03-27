void main()
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oScan = GetFirstObjectInArea();
object oDoor = OBJECT_SELF;
object oMPOP;
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "MPOP")
        {
        oMPOP = oScan;
        break;
        }
    oScan = GetNextObjectInArea();
    }
if (oMPOP == OBJECT_INVALID) oMPOP = GetNearestObjectByTag("MPOP",GetWaypointByTag(GetTag(oArea)));
int nCount;
int nUnderAttack = FALSE;
for (nCount = 1; nCount < 5; nCount++)
    {
    if (GetLocalString(oMPOP,"Pop"+IntToString(nCount)) == "") continue;
    if (GetSubString(GetLocalString(oMPOP,"Pop"+IntToString(nCount)),0,4) != "SHLD")
        {
        nUnderAttack = TRUE;
        }
    }
if ((!nUnderAttack) && (GetLocalInt(oDoor,"PlayerUnlocked") == FALSE))
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
