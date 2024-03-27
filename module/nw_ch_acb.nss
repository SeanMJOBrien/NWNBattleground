//::///////////////////////////////////////////////
//:: Henchmen: On Spell Cast At
//:: NW_CH_ACB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:://////////////////////////////////////////////

#include "hench_i0_ai"


void main()
{
    object oCaster = GetLastSpellCaster();
    if(GetLastSpellHarmful())
    {
        SetCommandable(TRUE);
        // * GZ Oct 3, 2003
        // * Really, the engine should handle this, but hey, this world is not perfect...
        // * If I was hurt by my master or the creature hurting me has
        // * the same master
        // * Then clear any hostile feelings I have against them
        // * After all, we're all just trying to do our job here
        // * if we singe some eyebrow hair, oh well.
        object oMyMaster = GetMaster(OBJECT_SELF);
        if ((oMyMaster != OBJECT_INVALID) && (oMyMaster == oCaster || (oMyMaster  == GetMaster(oCaster)))  )
        {
            ClearPersonalReputation(oCaster, OBJECT_SELF);
            // Send the user-defined event as appropriate
            if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
            {
                SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_SPELL_CAST_AT));
            }
            return;
        }
        if (
// Auldar: Don't react if we are Taunting.
         GetCurrentAction() != ACTION_TAUNT &&
         !GetIsObjectValid(GetAttackTarget()) &&
         !GetIsObjectValid(GetAttemptedSpellTarget()) &&
         !GetIsObjectValid(GetAttemptedAttackTarget()) &&
         !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)) &&
         !GetIsFriend(oCaster))
        {
            SetCommandable(TRUE);
            HenchDetermineCombatRound(oCaster);
        }
    }
}
