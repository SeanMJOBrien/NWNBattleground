//::///////////////////////////////////////////////
//:: FileName ps_maid08
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/4/2006 9:47:05 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items

object oMug = CreateItemOnObject("lisa_mug", GetPCSpeaker(), 1);
AssignCommand(GetPCSpeaker(),ActionEquipItem(oMug,INVENTORY_SLOT_RIGHTHAND));
DelayCommand(300.0,DestroyObject(oMug));
DelayCommand(301.0,SendMessageToPC(GetPCSpeaker(),"You finish your ale."));

    // Remove some gold from the player
    TakeGoldFromCreature(1, GetPCSpeaker(), TRUE);
}
