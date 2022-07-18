void main()
{
object oPC = GetPCSpeaker();
FloatingTextStringOnCreature("Lizardfolk chosen.",oPC,FALSE);
SetLocalInt(oPC,"racechoice",4);
}
