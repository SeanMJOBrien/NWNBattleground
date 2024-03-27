#include "x2_inc_switches"
#include "x0_i0_position"
#include "ps_inc_brtr2"

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
        object oScan;
        int nAssociate = FALSE;
        int nTagRemainder;
        oScan = GetFirstPC();
        while (oScan != OBJECT_INVALID)
            {
            if (GetFactionEqual(oTarget,oScan))
                {
                nAssociate = TRUE;
                break;
                }
            oScan = GetNextPC();
            }
        if (nAssociate)
            {
            FloatingTextStringOnCreature("You may not barter with associates or summoned creatures.",oPC,FALSE);
            return;
            }
        else if (GetIsEnemy(oTarget,oPC))
            {
            FloatingTextStringOnCreature("You may not barter with those hostile towards you.",oPC,FALSE);
            return;
            }
        else if (GetIsPC(oTarget))
            {
            FloatingTextStringOnCreature("Use the radial menu to barter with other player characters.",oPC,FALSE);
            return;
            }
        else if (GetAbilityScore(oTarget,ABILITY_INTELLIGENCE,FALSE) <= 6)
            {
            FloatingTextStringOnCreature("Characters or creatures with an intelligence of six or less cannot barter.",oPC,FALSE);
            return;
            }
         else if ((GetIsInCombat(oPC)) || (GetIsInCombat(oTarget)))
            {
            FloatingTextStringOnCreature("Barter is not possible in combat, or immediately after.",oPC,FALSE);
            }
         else if (GetDistanceBetween(oPC,oTarget) >= 8.0)
            {
            FloatingTextStringOnCreature("The subject is too far away.",oPC,FALSE);
            }
         else //Start the barter conversation...
            {
            AssignCommand(oTarget,ClearAllActions(TRUE));
            TurnToFaceObject(oPC,oTarget);
            switch (d4())
                    {
                    case 1:
                    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
                    break;
                    case 2:
                    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
                    break;
                    case 3:
                    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
                    break;
                    case 4:
                    AssignCommand(oTarget,ActionWait(0.5));
                    break;
                    }
            AssignCommand(oTarget,ActionMoveToObject(oPC,FALSE,2.0));
            AssignCommand(oTarget,ActionDoCommand(TagItems(oItem,oTarget)));
            AssignCommand(oTarget,ActionDoCommand(SwapItems(oItem,oTarget)));
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
