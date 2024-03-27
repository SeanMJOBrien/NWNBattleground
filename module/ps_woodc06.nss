void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("it_torch002",oPC,1);
TakeGoldFromCreature(20,oPC,TRUE);
}
