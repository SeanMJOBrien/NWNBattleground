//::///////////////////////////////////////////////
//:: Beholder AI and Attack Include
//:: x2_inc_beholder
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Include file for several beholder functions

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: August, 2003
//:://////////////////////////////////////////////

#include "x0_i0_spells"

#include "hench_i0_generic"


const int BEHOLDER_RAY_DEATH = 1;
const int BEHOLDER_RAY_TK = 2;
const int BEHOLDER_RAY_PETRI= 3;
const int BEHOLDER_RAY_CHARM_PER = 4;
const int BEHOLDER_RAY_SLOW = 5;
const int BEHOLDER_RAY_WOUND = 6;
const int BEHOLDER_RAY_FEAR = 7;
// added rays
const int BEHOLDER_RAY_CHARM_MON = 8;
const int BEHOLDER_RAY_SLEEP = 9;
const int BEHOLDER_RAY_DISINTEGRATE = 10;



int gHenchSpellTargetObjects;

const string HENCH_SPELL_TARGET_OBJECTS = "HenchSpellTarget";


void HenchInitSpellTargetObjects()
{
    if (gHenchSpellTargetObjects != 0)
    {
        return;
    }

    location lTargetLocation = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, lTargetLocation, TRUE,
        OBJECT_TYPE_CREATURE /*| OBJECT_TYPE_AREA_OF_EFFECT*/);
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsEnemy(oTarget) && !GetIsDead(oTarget) && (GetObjectSeen(oTarget) || GetObjectHeard(oTarget)))
        {
            gHenchSpellTargetObjects += 1;
            SetObjectArray(OBJECT_SELF, HENCH_SPELL_TARGET_OBJECTS, gHenchSpellTargetObjects, oTarget);
            if (gHenchSpellTargetObjects >= 10)
            {
                break;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 40.0, lTargetLocation, TRUE,
            OBJECT_TYPE_CREATURE /*| OBJECT_TYPE_AREA_OF_EFFECT*/);
    }
}


int BehGetTargetThreatRating(object oTarget)
{
    if (!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
    {
        return 0;
    }

    int nRet = 20;

    if (GetDistanceBetween(oTarget,OBJECT_SELF) < 5.0f)
    {
        nRet += 3;
    }

    nRet += (GetHitDice(oTarget) - GetHitDice(OBJECT_SELF) / 2);

    if (GetPlotFlag(oTarget)) //
    {
        nRet -= 6 ;
    }

    if (GetIsObjectValid(GetMaster(oTarget)))
    {
        nRet -= 4;
    }

    if (!GetObjectSeen(oTarget))
    {
        nRet -= 8;
    }

    if (GetIsDisabled(oTarget))
    {
        nRet -=10;
    }

    return nRet;
}



const string HENCH_RAY_TARGET_OBJECTS = "HenchRayTarget";
const string HENCH_RAY_TARGET_QUAD = "HenchRayQuad";
const string HENCH_RAY_TARGET_THREAT = "HenchRayThreat";
const string HENCH_RAY_TARGET_SELECT = "HenchRaySelect";
const string HENCH_RAY_QUAD_COUNT = "HenchRayQuadCount";



int gHenchRayTargetObjects;


void InitRayTargets(object oTarget)
{
    int curLoopCount = 1;
    while (curLoopCount <= gHenchSpellTargetObjects)
    {
        object oCurTarget = GetObjectArray(OBJECT_SELF, HENCH_SPELL_TARGET_OBJECTS, curLoopCount);
        curLoopCount += 1;
        int curThreat = BehGetTargetThreatRating(oCurTarget);
            // sort the threats
        int curTestIndex = gHenchRayTargetObjects;
        int testThreat;
        while (curTestIndex > 0 && (testThreat = GetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_THREAT, curTestIndex)) < curThreat)
        {
            SetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, curTestIndex + 1, GetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, curTestIndex));
            SetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_THREAT, curTestIndex + 1, testThreat);
            curTestIndex --;
        }
        gHenchRayTargetObjects += 1;
        SetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, curTestIndex + 1, oCurTarget);
        SetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_THREAT, curTestIndex + 1, curThreat);
    }
    // assign quadrants
    curLoopCount = 1;
    vector vSelf = GetPositionFromLocation(GetLocation(OBJECT_SELF));
    vector vTarget = GetPositionFromLocation(GetLocation(oTarget));
    float fAngle1 = VectorToAngle(vTarget - vSelf);

    while (curLoopCount <= gHenchRayTargetObjects)
    {
        object oCurTarget = GetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, curLoopCount);

        vector vCurTarget = GetPositionFromLocation(GetLocation(oCurTarget));
        float fAngle2 = VectorToAngle(vCurTarget - vSelf);

        float fRelAngel = fAngle1 - fAngle2;
        if (fRelAngel < 0.0)
        {
            fAngle1 += 360.0;
        }
        int quadrant;
        if (fRelAngel > 315.0 || fRelAngel <= 45.0)
        {
            quadrant = 1;
        }
        else if (fRelAngel <= 135.0)
        {
            quadrant = 2;
        }
        else if (fRelAngel <= 225.0)
        {
            quadrant = 3;
        }
        else
        {
            quadrant = 4;
        }
        SetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_QUAD, curLoopCount, quadrant);
        SetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_SELECT, curLoopCount, 0);
        curLoopCount += 1;
    }
    int curQuadCount;
    for (curQuadCount = 1; curQuadCount <= 4; curQuadCount++)
    {
        SetIntArray(OBJECT_SELF, HENCH_RAY_QUAD_COUNT, curQuadCount, 0);
    }
}


void OpenAntiMagicEye (object oTarget)
{
    if (GetObjectSeen(oTarget))
    {
        ActionCastSpellAtObject(727 , oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else
    {
        ActionCastSpellAtLocation(727, GetLocation(oTarget), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
}

// being a badass beholder, we close our antimagic eye only to attack with our eye rays
// and then reopen it...
void CloseAntiMagicEye(object oTarget)
{
    RemoveSpellEffects (727,OBJECT_SELF,oTarget);
}


void BehDoFireBeam(int nRay, object oTarget)
{
    int bHit   = TouchAttackRanged(oTarget,FALSE)>0;
    int nProj;
    switch (nRay)
    {
        case BEHOLDER_RAY_DEATH: nProj = 776;
                            break;
        case BEHOLDER_RAY_TK:    nProj = 777;
                            break;
        case BEHOLDER_RAY_PETRI: nProj = 778;
                            break;
        case BEHOLDER_RAY_CHARM_PER: nProj = 779;
                            break;
        case BEHOLDER_RAY_SLOW:  nProj = 780;
                            break;
        case BEHOLDER_RAY_WOUND: nProj = 783;
                            break;
        case BEHOLDER_RAY_FEAR:  nProj = 784;
                            break;
        case BEHOLDER_RAY_CHARM_MON: nProj = 785;
                            break;
        case BEHOLDER_RAY_SLEEP: nProj = 786;
                            break;
        case BEHOLDER_RAY_DISINTEGRATE: nProj = 787;
                            break;

    }

    if (bHit)
    {
         ActionCastSpellAtObject(nProj,oTarget,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    else
    {
        location lFail = GetLocation(oTarget);
        vector vFail = GetPositionFromLocation(lFail);

        if (GetDistanceBetween(OBJECT_SELF,oTarget) > 6.0f)
        {

           vFail.x += IntToFloat(Random(3)) - 1.5;
           vFail.y += IntToFloat(Random(3)) - 1.5;
           vFail.z += IntToFloat(Random(2));
           lFail = Location(GetArea(oTarget),vFail,0.0f);

        }
        //----------------------------------------------------------------------
        // if we are fairly near, calculating a location could cause us to
        // spin, so we use the same location all the time
        //----------------------------------------------------------------------
        else
        {
              vFail.z += 0.8;
              vFail.y += 0.2;
              vFail.x -= 0.2;
        }

        ActionCastFakeSpellAtLocation(nProj,lFail);
    }
}


int bGlobalSkipFireBeam;


void BehTryFireBeam(int nRay, int bUseAntiMagic)
{
    if (bGlobalSkipFireBeam)
    {
        return;
    }
    int nSaveTargetIndex = 0;
    int curLoopCount = 1;
    int bFoundOne = FALSE;
    int targetThres = 1000;

    while (curLoopCount <= gHenchRayTargetObjects)
    {
        object oCurTarget = GetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, curLoopCount);
        int quadrant = GetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_QUAD, curLoopCount);
        int bExcludeQuadSpell = quadrant == 1 && bUseAntiMagic;    // don't use effect spells in first quadrant
            // if anti magic is to be used, will remove effect right away
        // no more than three rays in a quadrant
        if (GetIntArray(OBJECT_SELF, HENCH_RAY_QUAD_COUNT, quadrant) >= 3)
        {
            curLoopCount++;
            continue;
        }

        bFoundOne = TRUE;
        int bFoundMatch = FALSE;

        switch (nRay)
        {
        case BEHOLDER_RAY_DEATH:
            if (!GetIsImmune(oCurTarget, IMMUNITY_TYPE_DEATH, OBJECT_SELF))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_TK:
            if (!GetIsImmune(oCurTarget, IMMUNITY_TYPE_KNOCKDOWN, OBJECT_SELF))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_PETRI:
            if (!GetHasEffect(EFFECT_TYPE_PETRIFY, oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_CHARM_PER:
            if (!bExcludeQuadSpell && GetIsHumanoid(GetRacialType(oCurTarget)) &&
                !GetIsImmune(oCurTarget, IMMUNITY_TYPE_CHARM, OBJECT_SELF) && !GetIsDisabled(oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_SLOW:
            if (!bExcludeQuadSpell && !GetIsImmune(oCurTarget, IMMUNITY_TYPE_SLOW, OBJECT_SELF) &&
                !GetHasEffect(EFFECT_TYPE_SLOW, oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_WOUND:
            if (GetRacialType(oCurTarget) != RACIAL_TYPE_UNDEAD)
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_FEAR:
            if (!bExcludeQuadSpell && !GetIsImmune(oCurTarget, IMMUNITY_TYPE_FEAR, OBJECT_SELF) &&
                !GetIsDisabled(oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_CHARM_MON:
            if (!bExcludeQuadSpell && !GetIsImmune(oCurTarget, IMMUNITY_TYPE_CHARM, OBJECT_SELF) &&
                !GetIsDisabled(oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_SLEEP:
            if (!bExcludeQuadSpell && !GetIsImmune(oCurTarget, IMMUNITY_TYPE_SLEEP, OBJECT_SELF) &&
                !GetIsDisabled(oCurTarget))
            {
                bFoundMatch = TRUE;
            }
            break;
        case BEHOLDER_RAY_DISINTEGRATE:
            bFoundMatch = TRUE;
            break;
        }

        if (bFoundMatch)
        {
            int curTargetCount = GetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_SELECT, curLoopCount);
            if (curTargetCount < targetThres)
            {
                nSaveTargetIndex = curLoopCount;
                targetThres = curTargetCount;
            }
        }
        curLoopCount++;
    }

    bGlobalSkipFireBeam = !bFoundOne;

    if (nSaveTargetIndex > 0)
    {
        // cast the spell
        object oCurTarget = GetObjectArray(OBJECT_SELF, HENCH_RAY_TARGET_OBJECTS, nSaveTargetIndex);
        int quadrant = GetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_QUAD, nSaveTargetIndex);

        SetIntArray(OBJECT_SELF, HENCH_RAY_QUAD_COUNT, quadrant,
            GetIntArray(OBJECT_SELF, HENCH_RAY_QUAD_COUNT, quadrant) + 1);
        SetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_SELECT, nSaveTargetIndex,
            GetIntArray(OBJECT_SELF, HENCH_RAY_TARGET_SELECT, nSaveTargetIndex) + 1);

        BehDoFireBeam(nRay, oCurTarget);
    }
}


const string sCreatureSaveResultStr = "HENCH_CREATURE_SAVE";


object GetBestAntiMagicTarget(object oTarget)
{
    int curLoopCount = 1;
    location testTargetLoc;
    object oCurTarget;
    object oTestTarget;
    int bRequireTarget;

    // reset flag on nearby creatures
    testTargetLoc = GetLocation(OBJECT_SELF);
    oTestTarget = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTestTarget))
    {
        SetLocalInt(oTestTarget, sCreatureSaveResultStr, -1);
        oTestTarget = GetNextObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    }

    if (GetDistanceToObject(oTarget) <= 5.0)
    {
        bRequireTarget = TRUE;
    }

    object oBestTarget = OBJECT_INVALID;
    int nBestMagicTarget = 0;

    while (curLoopCount <= gHenchSpellTargetObjects)
    {
        oCurTarget = GetObjectArray(OBJECT_SELF, HENCH_SPELL_TARGET_OBJECTS, curLoopCount);
        curLoopCount += 1;

        if (GetDistanceToObject(oCurTarget) > (bRequireTarget ? 5.0 : 25.0))
        {
            continue;
        }
        testTargetLoc = GetLocation(oCurTarget);
        int nAntiMagicCount = 0;

        oTestTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTestTarget))
        {
            if (GetObjectType(oTestTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                object oCreator = GetAreaOfEffectCreator(oTestTarget);
                if (GetObjectType(oCreator) == OBJECT_TYPE_CREATURE && GetIsEnemy(oCreator))
                {
                    nAntiMagicCount += 5;
                }
            }
            else
            {
                if (GetIsFriend(oTestTarget))
                {
                    nAntiMagicCount = -1000;
                    break;
                }
                if (oTestTarget != OBJECT_SELF && !GetIsDead(oTestTarget))
                {
                    int nSaveResult = GetLocalInt(oTestTarget, sCreatureSaveResultStr);
                    if (nSaveResult == -1)
                    {
                        // already antimagic or dead?
                        if (!GetHasSpellEffect(727, oTestTarget) && !GetIsDead(oTestTarget))
                        {
                            int nMag = GetLevelByClass(CLASS_TYPE_WIZARD, oTestTarget) + GetLevelByClass(CLASS_TYPE_SORCERER, oTestTarget) +
                                GetLevelByClass(CLASS_TYPE_BARD, oTestTarget) + GetLevelByClass(CLASS_TYPE_CLERIC, oTestTarget) +
                                GetLevelByClass(CLASS_TYPE_DRUID, oTestTarget);
                            nSaveResult = nMag / 3;
                            effect eCheck = GetFirstEffect(oTestTarget);
                            int bContinueLoop = TRUE;
                            while (bContinueLoop && GetIsEffectValid(eCheck))
                            {
                                int iSpell = GetEffectSpellId(eCheck);
                                if (iSpell != -1 && GetEffectSubType(eCheck) == SUBTYPE_MAGICAL)
                                {
                                    // Found an effect applied by a spell script - check the effect type
                                    // Ignore invisibility effects since that's a special case taken
                                    // care of elsewhere
                                    int iType = GetEffectType(eCheck);

                                    switch(iType)
                                    {
                                    case EFFECT_TYPE_REGENERATE:
                                    case EFFECT_TYPE_SANCTUARY:
                                    case EFFECT_TYPE_IMMUNITY:
                                    case EFFECT_TYPE_INVULNERABLE:
                                    case EFFECT_TYPE_HASTE:
                                    case EFFECT_TYPE_ELEMENTALSHIELD:
                                    case EFFECT_TYPE_SPELL_IMMUNITY:
                                    case EFFECT_TYPE_SPELLLEVELABSORPTION:
                                    case EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE:
                                    case EFFECT_TYPE_DAMAGE_INCREASE:
                                    case EFFECT_TYPE_DAMAGE_REDUCTION:
                                    case EFFECT_TYPE_DAMAGE_RESISTANCE:
                                    case EFFECT_TYPE_POLYMORPH:
                                    case EFFECT_TYPE_DOMINATED:
                                        nSaveResult += 10;
                                        break;
                                    case EFFECT_TYPE_ABILITY_INCREASE:
                                    case EFFECT_TYPE_AC_INCREASE:
                                    case EFFECT_TYPE_ATTACK_INCREASE:
                                    case EFFECT_TYPE_CONCEALMENT:
                                    case EFFECT_TYPE_ENEMY_ATTACK_BONUS:
                                    case EFFECT_TYPE_MOVEMENT_SPEED_INCREASE:
                                    case EFFECT_TYPE_SAVING_THROW_INCREASE:
                                    case EFFECT_TYPE_SEEINVISIBLE:
                                    case EFFECT_TYPE_SKILL_INCREASE:
                                    case EFFECT_TYPE_SPELL_RESISTANCE_INCREASE:
                                    case EFFECT_TYPE_TEMPORARY_HITPOINTS:
                                    case EFFECT_TYPE_TRUESEEING:
                                    case EFFECT_TYPE_ULTRAVISION:
                                        nSaveResult++;
                                        break;
                                    case EFFECT_TYPE_SLOW:
                                    // sometimes ignore slow
                                        if (d2() == 1)
                                        {
                                            break;
                                        }
                                    case EFFECT_TYPE_PARALYZE:
                                    case EFFECT_TYPE_STUNNED:
                                    case EFFECT_TYPE_FRIGHTENED:
                                    case EFFECT_TYPE_SLEEP:
                                    case EFFECT_TYPE_DAZED:
                                    case EFFECT_TYPE_CHARMED:
                                    case EFFECT_TYPE_CONFUSED:
                                    case EFFECT_TYPE_TURNED:
                                        // if disabled don't dispel
                                        nSaveResult = -1000;
                                        bContinueLoop = FALSE;
                                        break;
                                    case EFFECT_TYPE_PETRIFY:
                                    // ignore this target
                                        nSaveResult = 0;
                                        bContinueLoop = FALSE;
                                        break;
                                    }
                                }
                                eCheck = GetNextEffect(oTestTarget);
                            }
                            if (nSaveResult < 0)
                            {
                                nAntiMagicCount = -1000;
                                break;
                            }
                        }
                        else
                        {
                            nSaveResult = 0;
                        }
                        SetLocalInt(oTestTarget, sCreatureSaveResultStr, nSaveResult);
                    }
                    nAntiMagicCount += nSaveResult;
                }
            }
            //Select the next target within the spell shape.
            oTestTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
        if (nAntiMagicCount > nBestMagicTarget)
        {
            nBestMagicTarget = nAntiMagicCount;
            oBestTarget = oCurTarget;
        }
    }
    // ignore minor magic sometimes
    if (nBestMagicTarget <= d4())
    {
        oBestTarget = OBJECT_INVALID;
    }
    return oBestTarget;
}
