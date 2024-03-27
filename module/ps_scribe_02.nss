void main()
{
object oPC = GetPCSpeaker();
TakeGoldFromCreature(5,oPC,TRUE);
CreateItemOnObject("x2_it_cfm_bsscrl",oPC);
}
