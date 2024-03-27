#include "ps_timestamp"

void main()
{
object oPC=GetPCLevellingUp();
int nHD=GetHitDice(oPC);
int nNewXP;
int nSetHour;
object oLegalRest = GetNearestObjectByTag("LEGALREST",oPC);
if ((oLegalRest == OBJECT_INVALID)
     || (GetArea(oLegalRest) != GetArea(oPC))
     || (GetDistanceBetween(oLegalRest,oPC) > 10.0)
     || (GetDistanceBetween(oLegalRest,oPC) == 0.0))
   {
   SendMessageToPC(oPC,"You may not level-up outside of legal rest areas.");
   nNewXP = ((nHD * (nHD-1)) / 2 * 1000)-1;
   SetXP(oPC, nNewXP);
   }
else
    {
    nNewXP = ((nHD * (nHD-1)) / 2 * 1000) + 1;
    SetXP(oPC, nNewXP);
    DeleteLocalInt(oPC,"RaisePenalty");
    PrintString(SayLogTime()+" "+GetName(oPC)+" advanced to level "+IntToString(GetHitDice(oPC))+".");
    }
}
