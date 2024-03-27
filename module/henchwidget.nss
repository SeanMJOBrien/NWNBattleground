#include "x2_inc_switches"
#include "NW_I0_GENERIC"


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
        object oTarget = GetItemActivatedTarget();
        location lTarget = GetItemActivatedTargetLocation();
        object oHenchman = GetHenchman(oPC);
        if (oHenchman == OBJECT_INVALID)
            {
            SendMessageToPC(oPC,"You don't have a henchman/hireling.");
            return;
            }
        else if ((GetDistanceBetweenLocations(GetLocation(oHenchman),lTarget) > 30.0)
            ||(GetDistanceBetweenLocations(GetLocation(oHenchman),lTarget) == -1.0))
            {
            SendMessageToPC(oPC,"Henchman/hireling is too far away from target.");
            return;
            }
        else if ((oTarget != OBJECT_INVALID)
            && (GetObjectType(oTarget) == OBJECT_TYPE_DOOR))
            {
            AssignCommand(oHenchman,ClearAllActions());
            PlayVoiceChat(VOICE_CHAT_CANDO,oHenchman);
            AssignCommand(oHenchman,ActionOpenDoor(oTarget));
            AssignCommand(oHenchman,ActionWait(6.0));
            }
        else if ((oTarget != OBJECT_INVALID)
            && (GetIsEnemy(oTarget,oPC)
            && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)))
            {
            switch (d3())
                {
                case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY1,oHenchman); break;
                case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY2,oHenchman); break;
                case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY3,oHenchman); break;
                }
            AssignCommand(oHenchman,ClearAllActions());
            AssignCommand(oHenchman,DetermineCombatRound(oTarget));
            }
        else if (oHenchman != OBJECT_INVALID)
            {
            object oWP = CreateObject(OBJECT_TYPE_WAYPOINT,"nw_waypoint001",lTarget);
            AssignCommand(oHenchman,ClearAllActions());
            AssignCommand(oHenchman,ActionMoveToObject(oWP,TRUE));
            AssignCommand(oHenchman,ActionWait(6.0));
            DestroyObject(oWP,12.0);
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
