//::///////////////////////////////////////////////
//:: FileName ps_maid12
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/4/2006 9:51:52 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker the items
	CreateItemOnObject("ps_meal1", GetPCSpeaker(), 1);


	// Remove some gold from the player
	TakeGoldFromCreature(20, GetPCSpeaker(), TRUE);
}
