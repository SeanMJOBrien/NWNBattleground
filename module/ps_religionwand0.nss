void main()
{
object oPC = GetPCSpeaker();
DeleteLocalObject(oPC,"ReligionTarget");
DestroyObject(OBJECT_SELF);
}
