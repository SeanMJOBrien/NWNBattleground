void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("ps_tinderbox",oPC,1);
TakeGoldFromCreature(12,oPC,TRUE);

}
