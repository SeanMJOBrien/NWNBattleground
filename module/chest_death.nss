void main()
{
location lHere = GetLocation(OBJECT_SELF);
int iOpen = GetLocalInt(OBJECT_SELF,"opened");
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_c",lHere);
SetLocalInt(oSpawner,"opened",iOpen);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
}
