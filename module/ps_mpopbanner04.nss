void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC,"WPCount",GetLocalInt(oPC,"WPCount")+1);
}
