//::///////////////////////////////////////////////
//:: FileName ps_maid09
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/4/2006 9:50:17 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker the items
	CreateItemOnObject("ps_meal003", GetPCSpeaker(), 1);


	// Remove some gold from the player
	TakeGoldFromCreature(8, GetPCSpeaker(), TRUE);
}