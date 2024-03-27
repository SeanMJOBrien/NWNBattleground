#include "nw_i0_plot"

void WipeEffects(object oDead)
//Remove Effects sans the visual
{
    //Declare major variables
    object oTarget = oDead;
//    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE
                )
            {
                //Remove effect if it is negative.
                RemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

//    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    // * May 2002: Removed this because ActionRest is no longer an instant.
    // * rest the player
    //AssignCommand(oDead, ActionRest());
}
void main()
{
SpawnScriptDebugger();
object oPC = GetLastPlayerDied();
location lPC = GetLocation(oPC);
object oRemains = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_remains",lPC,FALSE);
string sCRef;
int nOnlyPC = TRUE;
int nHeal;
object oScan = GetFirstPC();
while (oScan != OBJECT_INVALID)
    {
    if (oScan != oPC)
        {
        nOnlyPC = FALSE;
        return;
        }
    oScan = GetNextPC();
    }
object oTemple = GetWaypointByTag("ALTAR_RESPAWN");
location lRespawn;
WipeEffects(oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
nHeal = abs(GetCurrentHitPoints(oPC)) + 1;
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oPC);

AssignCommand(oPC,ClearAllActions(TRUE));
if (nOnlyPC == TRUE) AssignCommand(oPC,ActionJumpToObject(oTemple));
//else AssignCommand(oPC,ActionJumpToObject(oComa));
if (nOnlyPC == FALSE)
    {
    if (GetGender(oPC) == GENDER_FEMALE) sCRef = "ps_comatosepc_f";
    else sCRef = "ps_comatosepc_m";
    object oCorpse = CreateItemOnObject(sCRef,oRemains);
    SetLocalObject(oCorpse,"Owner",oPC);
    SetLocalObject(oPC,"Corpse",oCorpse);
    SetLocalInt(oPC,"Dead",1);
    }
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_BELT,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),oPC));
AssignCommand(oRemains, ActionTakeItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC),oPC));

AssignCommand(oRemains, TakeGold(GetGold(oPC),oPC,FALSE));
oScan = GetFirstItemInInventory(oPC);
while (oScan != OBJECT_INVALID)
    {
    AssignCommand(oRemains, ActionTakeItem(oScan,oPC));
    oScan = GetNextItemInInventory(oPC);

    }

if (nOnlyPC == TRUE)
    {
    SendMessageToPC(oPC,"As you are the only PC logged on, you have been raised.");
    if (GetHitDice(oPC) > 1)
        {
        int nHD = GetHitDice(oPC) -1;
        int nMax = (((nHD + 1) * nHD) / 2) * 1000;
        int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
        int nMid = nMin + ((nMax - nMin) / 2);
        SetXP(oPC, nMid);
        SendMessageToPC(oPC,"You suffer level loss from being raised.");
        }
    else if (GetAbilityScore(oPC,ABILITY_CONSTITUTION) > 3)
        {
        int nRaisePenalty = GetLocalInt(oPC,"RaisePenalty");
        nRaisePenalty++;
        if (((GetAbilityScore(oPC,ABILITY_CONSTITUTION) - nRaisePenalty) < 3)
            || ((GetAbilityScore(oPC,ABILITY_STRENGTH) - nRaisePenalty) < 3)
            || ((GetAbilityScore(oPC,ABILITY_STRENGTH) - nRaisePenalty) < 3))
            nRaisePenalty = GetAbilityScore(oPC,ABILITY_CONSTITUTION) - 3;
        SetLocalInt(oPC,"RaisePenalty",nRaisePenalty);
//        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_CONSTITUTION,nRaisePenalty),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_STRENGTH,nRaisePenalty),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_DEXTERITY,nRaisePenalty),oPC);
        SendMessageToPC(oPC,"You are raised but infirm.");
        }
    }

}
