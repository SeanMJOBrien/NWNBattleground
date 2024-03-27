void main()
{
object oPC = GetPCSpeaker();
TakeGoldFromCreature(20,oPC,TRUE);
CreateItemOnObject("ps_healingbalm",oPC);

}
