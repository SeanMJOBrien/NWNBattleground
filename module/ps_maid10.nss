//::///////////////////////////////////////////////
//:: FileName ps_maid10
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/4/2006 9:50:47 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker the items
	CreateItemOnObject("ps_meal2", GetPCSpeaker(), 1);


	// Remove some gold from the player
	TakeGoldFromCreature(12, GetPCSpeaker(), TRUE);
}