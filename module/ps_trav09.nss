int StartingConditional()
{
object oScan;
int nCount;
int nRoomFree = FALSE;
for (nCount = 1; nCount <= 6; nCount ++)
    {
    oScan = GetWaypointByTag("WILDERNESS"+IntToString(nCount));
    if (GetLocalInt(GetArea(oScan),"Occupied") == FALSE)
        {
        nRoomFree = TRUE;
        break;
        }
    }
return nRoomFree;
}
