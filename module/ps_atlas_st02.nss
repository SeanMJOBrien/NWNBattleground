void main()
{
object oPC = GetPCSpeaker();
object oStartingStore = GetObjectByTag("STARTINGEQUIP");
GiveGoldToCreature(oPC, 200);
GiveXPToCreature(oPC,1);
DelayCommand(0.5,OpenStore(oStartingStore,oPC));
PlayAnimation(ANIMATION_PLACEABLE_CLOSE);

}
