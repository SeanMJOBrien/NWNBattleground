void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(OBJECT_SELF,"SeedStr",GetLocalInt(OBJECT_SELF,"SeedStr")+5);
}
