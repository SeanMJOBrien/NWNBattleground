//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
object oArea = GetArea(OBJECT_SELF);
//effect ePoof = EffectVisualEffect(VFX_IMP_HARM,FALSE);
//location lSelf = GetLocation(OBJECT_SELF);
if ((GetIsDay() == TRUE)
    && (GetIsAreaAboveGround(oArea) == TRUE))
        {
        SetCommandable(FALSE,OBJECT_SELF);
        SetIsDestroyable(TRUE,FALSE,FALSE);
        DestroyObject(OBJECT_SELF);
//        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lSelf);
        }
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
