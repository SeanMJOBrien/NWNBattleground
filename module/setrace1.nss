void main()
{
object oPC = GetPCSpeaker();
FloatingTextStringOnCreature("Aasimar chosen.",oPC,FALSE);
SetLocalInt(oPC,"racechoice",1);
}
