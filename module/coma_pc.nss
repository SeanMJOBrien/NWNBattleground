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
#include "x0_i0_position"
#include "nw_i0_plot"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

   SendMessageToPC(GetFirstPC(),IntToString(nEvent));

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
        object oOwner = GetLocalObject(oItem,"Owner");
        if (oOwner != OBJECT_INVALID)
            {
            SendMessageToPC(oPC,"This is the body of "+GetName(oOwner)+".");
            SendMessageToPC(oOwner,GetName(oPC)+" has picked up your body.");
            }

    }

    // * This code runs when the item is unaquire d
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {

        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
        object oOwner = GetLocalObject(oItem,"Owner");
        if (oOwner != OBJECT_INVALID)
            {
            SendMessageToPC(oOwner,GetName(oPC)+" has dropped your body.");
            }

    }

    //* This code runs when a PC or DM casts a spell from one of the
    //* standard spellbooks on the item
    else if (nEvent == X2_ITEM_EVENT_SPELLCAST_AT)
    {
        oItem  = GetSpellTargetObject();
        object oOwner = GetLocalObject(oItem,"Owner");
        object oPC = GetItemPossessor(oItem);
        object oScan;
        location lRespawn;
        int nSpellID = GetLastSpell();
        if ((nSpellID == SPELL_RAISE_DEAD) || (nSpellID == SPELL_RESURRECTION))
            {
            if (oOwner != OBJECT_INVALID)
                {
                if (oPC != OBJECT_INVALID) lRespawn = GetAheadLocation(oPC);
                else lRespawn = GetLocation(oItem);
                DestroyObject(oItem);
                AssignCommand(oOwner,ClearAllActions(TRUE));
                AssignCommand(oOwner,ActionJumpToLocation(lRespawn));
                DeleteCampaignVariable("SHIELD_LANDS","DEAD_"+GetName(oOwner));
                DeleteCampaignVariable("SHIELD_LANDS","BODY_"+GetName(oOwner));
                if (nSpellID == SPELL_RAISE_DEAD)
                    {
                    if (GetHitDice(oOwner) > 1)
                        {
                        int nHD = GetHitDice(oOwner) -1;
                        int nMax = (((nHD + 1) * nHD) / 2) * 1000;
                        int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
                        int nMid = nMin + ((nMax - nMin) / 2);
                        SetXP(oOwner, nMid);
                        SendMessageToPC(oOwner,"You suffer level loss from being raised.");
                        }
                    else if (GetAbilityScore(oOwner,ABILITY_CONSTITUTION) > 3)
                        {
                        int nRaisePenalty = GetLocalInt(oOwner,"RaisePenalty");
                        nRaisePenalty++;
                        if ((GetAbilityScore(oOwner,ABILITY_CONSTITUTION) - nRaisePenalty) < 3)
                            nRaisePenalty = GetAbilityScore(oOwner,ABILITY_CONSTITUTION) - 3;
                        SetLocalInt(oOwner,"RaisePenalty",nRaisePenalty);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_CONSTITUTION,nRaisePenalty),oOwner);
                        if (GetCurrentHitPoints(oOwner) < 1)
                            {
                           int nHeal = abs(GetCurrentHitPoints(oOwner)) + 1;
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oOwner);
                           }
                            SendMessageToPC(oOwner,"You are raised but infirm.");
                        }
                    }
                if (nSpellID == SPELL_RESURRECTION)
                    {
                    int nHeal = GetMaxHitPoints(oOwner) - GetCurrentHitPoints(oOwner);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oOwner);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_STRIKE_HOLY),lRespawn);
                    }
                SendMessageToPC(oOwner,"You awaken from your coma.");

                }
            }

    }


}
