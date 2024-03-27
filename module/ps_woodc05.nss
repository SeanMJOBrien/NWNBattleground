void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("ps_torch01",oPC,1);
TakeGoldFromCreature(1,oPC,TRUE);
}
