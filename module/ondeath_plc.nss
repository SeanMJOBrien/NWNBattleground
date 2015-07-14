void main()
{
location lHere = GetLocation(OBJECT_SELF);
//respawn code
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
}
