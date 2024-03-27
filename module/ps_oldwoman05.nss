void main()
{
object oPC = GetPCSpeaker();
TakeGoldFromCreature(2,oPC,TRUE);
CreateItemOnObject("ps_material001",oPC);
}
