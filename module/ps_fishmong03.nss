void main()
{
object oPC = GetPCSpeaker();
object oFish = CreateItemOnObject("ps_saltedfish",oPC);
TakeGoldFromCreature(1,oPC,TRUE);

}
