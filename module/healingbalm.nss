//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "ps_mod_data"
void PCRecover(object oTarget)
{
if (GetCurrentHitPoints(oTarget) <= -10)
    {
    effect eDeath = EffectDeath(FALSE, FALSE);
    DeleteLocalInt(oTarget,"Recovering");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
    return;
    }
if (GetLocalInt(oTarget,"Recovering"))
    {
    if (GetCurrentHitPoints(oTarget) < 1) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oTarget);
//    if (GetCurrentHitPoints(oTarget) < 1) DelayCommand(30.0,PCRecover(oTarget));
    if (GetCurrentHitPoints(oTarget) < 1) DelayCommand(30.0,PCRecover(oTarget));
    else DeleteLocalInt(oTarget,"Recovering");
    SaveTime(oTarget);
    }
}
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

//   SendMessageToPC(GetFirstPC(),IntToString(nEvent));

    // * This code runs when the item has the OnHitCastSpell: Unique power property
    // * and it hits a target(weapon) or is being hit (armor)
    // * Note that this event fires for non PC creatures as well.
    if (nEvent ==X2_ITEM_EVENT_ONHITCAST)
    {
        oItem  =  GetSpellCastItem();                  // The item casting triggering this spellscript
        object oSpellOrigin = OBJECT_SELF ;
        object oSpellTarget = GetSpellTargetObject();
        oPC = OBJECT_SELF;

    }

    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    else if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {

        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        object oTarget = GetItemActivatedTarget();
        int nTargetHP = GetCurrentHitPoints(oTarget);
        int nHealRank = GetSkillRank(SKILL_HEAL,oPC);
        int nWisMod = GetAbilityModifier(ABILITY_WISDOM,oPC);
        int nBuffer;
    if (oTarget == OBJECT_INVALID)
        {
        nBuffer = GetItemCharges(oItem);
        SetItemCharges(oItem,(nBuffer + 1));
        return;
        }
    int nRoll = d20() + nHealRank + nWisMod;
    if ((nTargetHP < 1)
        && (!GetLocalInt(oTarget,"Recovering")))
            {
            if (nRoll >= (15 + abs(nTargetHP)))
                {
                SendMessageToPC(oTarget,"You have stabilized and will recover 1 hit point every 30 seconds.");
                SendMessageToPC(oPC,"You have stabilized "+GetName(oTarget)+".");
                SetLocalInt(oTarget,"Recovering",1);
                DelayCommand(30.0,PCRecover(oTarget));
                DeleteLocalInt(oTarget,"Bleeding");
                return;
                }
            else
                {
                SendMessageToPC(oPC,"You have failed to stabilize "+GetName(oTarget)+".");
                return;
                }
            }
    if (nHealRank <= 0)
        {
        SendMessageToPC(oPC,"You must have skill ranks in heal to provide long term care.");
        nBuffer = GetItemCharges(oItem);
        SetItemCharges(oItem,(nBuffer + 1));
        return;
        }
        int nHealBonus = nRoll / 10;
        int nCurrentBonus = GetLocalInt(oTarget,"HealBonus");
        if ((oTarget == oPC) && (nHealBonus <= nCurrentBonus))
            SendMessageToPC(oPC,"You fail to further benefit yourself.");
        else if ((oTarget == oPC) && (nHealBonus > nCurrentBonus))
            {
            SendMessageToPC(oPC,"You have tended to your wounds.");
            SetLocalInt(oPC,"HealBonus",nHealBonus);
            }
        else if ((oTarget != oPC) && (nHealBonus <= nCurrentBonus))
            {
            SendMessageToPC(oPC,"You fail to further benefit "+GetName(oTarget)+".");
            SendMessageToPC(oTarget,GetName(oPC)+" fails to heal you.");
            }
        else if ((oTarget != oPC) && (nHealBonus > nCurrentBonus))
            {
            SendMessageToPC(oPC,"You have tended to "+GetName(oTarget)+"'s wounds.");
            SendMessageToPC(oTarget,GetName(oTarget)+" has tended to your wounds.");
            SetLocalInt(oTarget,"HealBonus",nHealBonus);
            }
    }

    // * This code runs when the item is equipped
    // * Note that this event fires PCs only
    else if (nEvent ==X2_ITEM_EVENT_EQUIP)
    {

        oPC = GetPCItemLastEquippedBy();
        oItem = GetPCItemLastEquipped();

    }

    // * This code runs when the item is unequipped
    // * Note that this event fires PCs only
    else if (nEvent ==X2_ITEM_EVENT_UNEQUIP)
    {

        oPC    = GetPCItemLastUnequippedBy();
        oItem  = GetPCItemLastUnequipped();

    }
    // * This code runs when the item is acquired
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {

        oPC = GetModuleItemAcquiredBy();
        oItem  = GetModuleItemAcquired();
    }

    // * This code runs when the item is unaquire d
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {

        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
    }

    //* This code runs when a PC or DM casts a spell from one of the
    //* standard spellbooks on the item
    else if (nEvent == X2_ITEM_EVENT_SPELLCAST_AT)
    {

        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
    }


}
