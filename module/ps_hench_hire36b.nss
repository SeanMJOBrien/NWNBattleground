#include "ps_timestamp"
#include "x0_i0_henchman"

void main()
{
int nRate = 10;
int nDaysToHire = 6;
object oPC = GetPCSpeaker();
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
int nDebitHour = GetLocalInt(oPC,"DebitHour");
TakeGoldFromCreature((nRate*nDaysToHire),oPC,TRUE);
int nHoursToHire = nDaysToHire * 23;
if (nDebitHour > 0)
    {
    nHoursToHire += nDebitHour;
    SendMessageToPC(oPC,"Your debited time has been added to your new hireling's commissioned time. You are no longer debited time.");
    DeleteLocalInt(oPC, "DebitHour");
    }
AdvanceTimeStamp(OBJECT_SELF,0,0,0,nHoursToHire,1);

    HireHenchman(oPC);

}
