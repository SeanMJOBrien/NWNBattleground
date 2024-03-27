//::///////////////////////////////////////////////
//:: Check if Stealth Disabled
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the henchman currently not use stealth when
    moving.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:
//:://////////////////////////////////////////////
// Auldar: Do we have skill points spent in either Hide or Move Silently skills

#include "hench_i0_conv"

int StartingConditional()
{    
    return !GetLocalInt(OBJECT_SELF, sHenchStealthMode);    
}
