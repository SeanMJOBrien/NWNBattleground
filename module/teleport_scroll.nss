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
void TeleportHome(object oPC)
{
location lPC = GetLocation(oPC);
object oWPHome = GetWaypointByTag("TELEPORT_SCROLL_DEST");
object oScan = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lPC,FALSE,OBJECT_TYPE_CREATURE);
effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);

while (oScan != OBJECT_INVALID)
    {
    if ((GetFactionEqual(oPC,oScan) == TRUE) && (oScan != oPC))
        {
//        SendMessageToPC(oPC,GetTag(oScan));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,ePoof,oScan);
        AssignCommand(oScan,ClearAllActions(TRUE));
        AssignCommand(oScan,ActionJumpToObject(oWPHome,FALSE));
        }
    oScan = GetNextObjectInShape(SHAPE_SPHERE,5.0,lPC,FALSE,OBJECT_TYPE_CREATURE);
    }
}
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
effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
        object oWPHome = GetWaypointByTag("TELEPORT_SCROLL_DEST");
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,1.5));
        AssignCommand(oPC,ActionSpeakString("Klaatu varata nicto!"));
        AssignCommand(oPC,ActionWait(0.5));
        AssignCommand(oPC,ActionDoCommand(TeleportHome(oPC)));
        AssignCommand(oPC,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,ePoof,oPC)));
//        ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,1.5);
//        ActionDoCommand(TeleportHome(oPC));
//        AssignCommand(oPC,ClearAllActions(TRUE));
        AssignCommand(oPC,ActionJumpToObject(oWPHome,FALSE));
        DestroyObject(oItem,1.5);
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
