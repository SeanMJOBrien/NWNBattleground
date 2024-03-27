#include "ps_timestamp"
void main()
{
object oPC = GetPCSpeaker();
DeleteLocalInt(oPC,"DebitHour");
int nAdvanceHour;
int nCount = 0;
int nHour = GetTimeHour();
int nDay = GetCalendarDay();
int nMonth = GetCalendarMonth();
int nYear = GetCalendarYear();
int nTargetHour = 19;
if (nTargetHour < nHour) nAdvanceHour = (23 - nHour) + nTargetHour;
else nAdvanceHour = nTargetHour - nHour;
AdvanceTimeStamp(oPC,0,0,0,nAdvanceHour,7);
}

