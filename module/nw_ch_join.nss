//::///////////////////////////////////////////////
//:: Join as Henchman
//:: nw_ch_join.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Adds the current object as a henchman
    to the PC speaking in conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: October 22, 2001
//:://////////////////////////////////////////////


void main()
{
    SetAssociateListenPatterns();
    // * Companions, come in, by default with Attack Nearest Enemy && Follow Master modes
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_COMBAT",ASSOCIATE_COMMAND_ATTACKNEAREST);
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_MOVEMENT",ASSOCIATE_COMMAND_FOLLOWMASTER);
    AddHenchman(GetPCSpeaker());
// Auldar: Trying to detect when the henchman has been re-hired so GetFormerMaster
// no longer returns true for OnHeartbeat's checking for henchmen left in stealth or detect mode
    if (GetLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER") != OBJECT_INVALID)
    {
        DeleteLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER");
    }
// Auldar: Clearing the check set in OnHeartbeat so when we fire this henchman again,
// we can once again check if we need to clear their Stealth and detect modes.
    if (GetLocalInt(OBJECT_SELF,"haveCheckedFM") == 1)
    {
        DeleteLocalInt(OBJECT_SELF, "haveCheckedFM");
    }
}
