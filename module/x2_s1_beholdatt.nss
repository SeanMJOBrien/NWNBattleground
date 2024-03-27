//::///////////////////////////////////////////////
//:: x2_s1_beholdatt
//:: Beholder Attack Spell Logic
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This spellscript is the core of the beholder's
    attack logic.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-28
//:://////////////////////////////////////////////


#include "x2_inc_beholder"


void main()
{
    int nApp = GetAppearanceType(OBJECT_SELF);

    int bUseAntiMagic = nApp == APPEARANCE_TYPE_BEHOLDER_MOTHER ||
        nApp == APPEARANCE_TYPE_BEHOLDER || nApp == APPEARANCE_TYPE_BEHOLDER_EYEBALL;
    
    object oTarget = GetSpellTargetObject();
    // Only if we are beholders and not beholder mages
 /*
    //* GZ: cut whole immunity thing because it was causing too much trouble
     if (nApp == 472 ||nApp == 401 || nApp == 403)
    {
        CloseAntiMagicEye(oTarget);
    }
  */

    // need that to make them not drop out of combat
    SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));


    HenchInitSpellTargetObjects();

    // first determine where anti magic eye should be used (if at all)    
    if (bUseAntiMagic)
    {
        object oTestTarget = GetBestAntiMagicTarget(oTarget);
        bUseAntiMagic = GetIsObjectValid(oTestTarget);
        if (bUseAntiMagic)
        {
            oTarget = oTestTarget;
        }
    }

    // find targets - up to three eyes can be used in a quadrant
    InitRayTargets(oTarget);
    switch (d3())
    {
    case 1:
        BehTryFireBeam(BEHOLDER_RAY_DISINTEGRATE, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_DEATH, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_WOUND, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_PETRI, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLOW, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_FEAR, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_TK, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_MON, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_PER, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLEEP, bUseAntiMagic);
        break;
    case 2:
        BehTryFireBeam(BEHOLDER_RAY_PETRI, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_DEATH, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_DISINTEGRATE, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_WOUND, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_FEAR, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLEEP, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_MON, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_PER, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_TK, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLOW, bUseAntiMagic);
        break;
    case 3:
        BehTryFireBeam(BEHOLDER_RAY_PETRI, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_DISINTEGRATE, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_DEATH, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_WOUND, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_FEAR, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLOW, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_SLEEP, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_TK, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_MON, bUseAntiMagic);
        BehTryFireBeam(BEHOLDER_RAY_CHARM_PER, bUseAntiMagic);
        break;
    }
    
    // Only if we are beholders and not beholder mages
    if (bUseAntiMagic)
    {
        OpenAntiMagicEye(oTarget);
    }
    
//    if (GetDistanceBetween(oTarget, OBJECT_SELF) < 5.0)
//    {    
//        ActionAttack(oTarget);
//    }
}
