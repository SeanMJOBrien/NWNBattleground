int StartingConditional()
{
object oScan;
int nCount;
int nRoomFree = FALSE;
object oPC = GetPCSpeaker();
int nHoursTraveled = GetLocalInt(oPC,"HoursTraveled");
if (nHoursTraveled >= 9) return FALSE;
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

