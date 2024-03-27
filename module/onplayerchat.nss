void MakeEquippedItemVisible(object oPC, string sSlot, int iVisible=TRUE)
{
  int iSlot = -1;
  if (GetStringLeft(sSlot, 1) == " ") sSlot = GetStringRight(sSlot, GetStringLength(sSlot)-1); //Take either "armor" or " armor", for example
  if (sSlot == "clothes" || sSlot == "armor" || sSlot == "outfit") iSlot = INVENTORY_SLOT_CHEST; //Comment out this line to disable the ability to hide equipped chest items for all players
  if (sSlot == "helm" || sSlot == "helmet") iSlot = INVENTORY_SLOT_HEAD; //Comment out this line to disable the ability to hide equipped helms for all players
  if (sSlot == "cloak") iSlot = INVENTORY_SLOT_CLOAK; //Comment out this line to disable the ability to hide equipped cloaks for all players

  object oEquippedItem = GetItemInSlot(iSlot, oPC);

  if (!GetIsObjectValid(oEquippedItem) || iSlot == -1) SendMessageToPC(oPC, "You do not have a visible or hidden item equipped in that inventory slot.");
  else {
    if (iVisible) { //Show the item
      if (GetLocalInt(oEquippedItem, "ItemCannotBeShown")) SendMessageToPC(oPC, "That item cannot be shown."); //Allow Designer/DM restriction so an item will never be shown if the ItemCannotBeShown int is on it
      else if (GetHiddenWhenEquipped(oEquippedItem)) SetHiddenWhenEquipped(oEquippedItem, FALSE);
      else SendMessageToPC(oPC, "That item is already visible.");
    }
    else { //Hide the item
      if (GetLocalInt(oEquippedItem, "ItemCannotBeHidden")) SendMessageToPC(oPC, "That item cannot be hidden."); //Allow Designer/DM restriction so an item will never be hidden if the ItemCannotBeHidden int is on it
      else if (!GetHiddenWhenEquipped(oEquippedItem)) SetHiddenWhenEquipped(oEquippedItem, TRUE);
      else SendMessageToPC(oPC, "That item is already hidden.");
    }
  }

  SetPCChatMessage("");
}

void main()
{
  object oPC = GetPCChatSpeaker();
  string sChat = GetPCChatMessage();
  if (GetStringLeft(sChat, 5) == "!hide") MakeEquippedItemVisible(oPC, GetStringRight(sChat, GetStringLength(sChat)-5), FALSE);
  if (GetStringLeft(sChat, 5) == "!show") MakeEquippedItemVisible(oPC, GetStringRight(sChat, GetStringLength(sChat)-5));
}
