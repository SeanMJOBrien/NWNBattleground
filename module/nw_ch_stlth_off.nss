//::///////////////////////////////////////////////
//:: Turn Off Stealth Mode
//:: NW_CH_SRCH_ON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////
// Auldar: Unflag associate, and remove Stealth state if active.
#include "hench_i0_conv"

void main()
{
    HenchSetAssociateInt(sHenchStealthMode, FALSE);
    SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
}
