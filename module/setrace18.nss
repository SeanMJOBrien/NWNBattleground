void main()
{
object oPC = GetPCSpeaker();
FloatingTextStringOnCreature("Bugbear chosen.",oPC,FALSE);
SetLocalInt(oPC,"racechoice",18);
}
