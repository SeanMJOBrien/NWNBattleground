//::///////////////////////////////////////////////
//:: FileName henchmanshow
//:://////////////////////////////////////////////
//:: This script will cause the henchman to tell the PC
//:: the full contents of his inventory.
//:://////////////////////////////////////////////
//:: Created By: Pausanias
//:: Created On: 6/28/2002 20:43:15
//:://////////////////////////////////////////////


#include "hench_i0_ident"
#include "hench_i0_strings"


// Pausanias's modification: correct for bard lore.

void main()
{
    int    i, nItem=0;
    int iMaxGPIdentify = HenchGetMaxGPToIdentify();
    object oItem;

    // First go through all the equipped slots
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    {
        oItem = GetItemInSlot(i);
        if (oItem != OBJECT_INVALID)

         //We don't want to report any creature items; that would be odd
        switch (GetBaseItemType(oItem))
        {
        case BASE_ITEM_CREATUREITEM:
        case BASE_ITEM_CBLUDGWEAPON:
        case BASE_ITEM_CSLASHWEAPON:
        case BASE_ITEM_CSLSHPRCWEAP:
        case BASE_ITEM_CPIERCWEAPON:
            break;
        default:
            // GetName doesn't care whether the object is identified, so
            // we have to check ourselves.
            if(HenchIdentifyItem(oItem, iMaxGPIdentify))
            SpeakString(GetName(oItem) + sHenchShowEquipKnown +
                        IntToString(GetNumStackedItems(oItem)));
            else
            SpeakString(sHenchShowEquipUnknown +
                        IntToString(GetNumStackedItems(oItem)));
            ++nItem;
        }
    }

    // Now loop through the items in the backpack.
    oItem = GetFirstItemInInventory();

    while (oItem != OBJECT_INVALID) {
        if(HenchIdentifyItem(oItem, iMaxGPIdentify))
           SpeakString(GetName(oItem) + sHenchShowInventoryKnown +
                       IntToString(GetNumStackedItems(oItem)));
        else
           SpeakString(sHenchShowInventoryUnknown +
                       IntToString(GetNumStackedItems(oItem)));
        oItem = GetNextItemInInventory();
        ++nItem;
    }
    if (nItem == 0) SpeakString(sHenchShowNoItems);
}
