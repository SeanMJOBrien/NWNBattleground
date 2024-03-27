//:://////////////////////////////////////////////////
//:: X0_D2_HEN_MASTER
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Returns TRUE if the speaker is the henchman's current
master.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 09/13/2002
//:://////////////////////////////////////////////////

#include "x0_i0_henchman"
#include "ps_timestamp"
int StartingConditional()
{

    string sSay;
    int nHoursTill = GetHoursTill(OBJECT_SELF,1);
    if (nHoursTill < 1) sSay = "Almost time to say goodbye.";
    else sSay = "Me fight for "+SayHours(nHoursTill)+" longer.";
    SetCustomToken(555,sSay);

    int bWorking = FALSE;
    if (GetWorkingForPlayer(GetPCSpeaker()) == TRUE)
        bWorking = TRUE;

    int bReturn = TRUE;

    if (bWorking == FALSE || GetLocalInt(OBJECT_SELF, "X2_PLEASE_NO_TALKING") == 100)
    {
        bReturn = FALSE;
    }




    return bReturn;
}
