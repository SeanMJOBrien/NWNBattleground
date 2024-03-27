void main()
{
object oPC = GetPCSpeaker();
TakeGoldFromCreature(200,oPC,TRUE);
CreateItemOnObject("teleport_scroll",oPC);
}
