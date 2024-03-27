//::///////////////////////////////////////////////
//:: Check if Stealth Enabled
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the henchman currently use stealth when
    moving.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:
//:://////////////////////////////////////////////
//:: Brent: May 2002: Disabled this option

#include "hench_i0_conv"

int StartingConditional()
{
    return GetLocalInt(OBJECT_SELF, sHenchStealthMode);    
}
