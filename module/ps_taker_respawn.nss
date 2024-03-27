#include "nw_i0_plot"

void main()
{
object oPC = GetPCSpeaker();
//location lPC = GetLocation(oPC);
object oRespawnWP = GetWaypointByTag("PLAYERSPAWN");
object oRemains = GetLocalObject(oPC,"Remains");
SetLocalInt(oPC,"Respawning",TRUE);
object oScan;
int nHD = GetHitDice(oPC);
// Next lines modified Bioware code.
int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
int nPenalty = 100 * GetHitDice(oPC); //10% penalty.
    int nXP = GetXP(oPC);
    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oPC, nNewXP);
//end Bioware code
SetCommandable(TRUE,oPC);
AssignCommand(oPC,ClearAllActions(TRUE));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_BELT,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),oRemains));
AssignCommand(oPC, ActionGiveItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC),oRemains));

AssignCommand(oRemains, TakeGold(GetGold(oPC),oPC,FALSE));
oScan = GetFirstItemInInventory(oPC);
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) != "PAJAMAS") AssignCommand(oRemains, ActionTakeItem(oScan,oPC));
    oScan = GetNextItemInInventory(oPC);

    }
object oRobes = CreateItemOnObject("ps_pajamas",oPC);
AssignCommand(oPC,ActionEquipItem(oRobes, INVENTORY_SLOT_CHEST));
AssignCommand(oPC,JumpToLocation(GetLocation(oRespawnWP)));
AssignCommand(oPC,ActionDoCommand(DeleteLocalInt(oPC,"Respawning")));
//Spawn a remains container at the sight of the player's death and put their
//belongings in it.
RemoveEffects(oPC);
//RemoveEffect(oPC,EffectCutsceneImmobilize());

}
