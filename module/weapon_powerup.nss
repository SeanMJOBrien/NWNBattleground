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
        float fDuration;
// This version of weapon "power-up" effects only the user and the weapon.
        int nPowerType = GetLocalInt(oItem,"TYPE");
        switch (nPowerType)
            {
// Start with simple item types... Fire/Ice & Positive/Negative blades.
            case 1: // Ice Weapon +1, 1d6 cold damage, +50% fire vulnerability
            fDuration = IntToFloat(d6()) * 12.0;
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyEnhancementBonus(1),oItem,fDuration);
            break;
            case 2: // Ice Weapon +2, 1d10 cold damage, +75% fire vulnerability
            fDuration = IntToFloat(d8()) * 12.0;
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEVULNERABILITY_75_PERCENT),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d10),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyEnhancementBonus(2),oItem,fDuration);
            break;
            case 3: // Fire Weapon +1, 1d6 fire damage, +50% ice vulnerability
            fDuration = IntToFloat(d6()) * 12.0;
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyEnhancementBonus(1),oItem,fDuration);
            break;
            case 4: // Fire Weapon +2, 1d10 fire damage,+75% ice vulnerability
            fDuration = IntToFloat(d6()) * 12.0;
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEVULNERABILITY_75_PERCENT),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d10),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyEnhancementBonus(2),oItem,fDuration);
            break;
            case 5: // Enervation +1, +50% positive/holy vulnerability, OnHit casts Doom, Use shifts alignment towards Evil
            fDuration = IntToFloat(d6()) * 12.0;
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_EVIL),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyEnhancementBonus(1),oItem,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyOnHitProps(IP_CONST_ONHIT_DOOM,IP_CONST_ONHIT_SAVEDC_14),oItem,fDuration);
            AdjustAlignment(oPC,ALIGNMENT_EVIL,2);
            break;
//            case 4: // Giant-slayer +1. AC Bonus & Attack Bonus vs. Giants. Weapon gets very heavy, hindering retreat.
            {

            }
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
