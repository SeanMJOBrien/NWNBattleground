void main()
{
object oMod = GetModule();
int iDepth = GetLocalInt(oMod,"avglevel");
object oWP = GetWaypointByTag("wp_center");//get center of map
location lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
///////////////////////////////////////////////////////////////////////////////////
//init vars
object oSpawn1;
object oSpawn2;
object oSpawn3;
object oSpawn4;
object oSpawn5;
object oSpawn6;
object oSpawn7;
object oSpawn8;
object oSpawn9;
object oSpawn10;
//create zombies
oSpawn1 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn2 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn3 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn4 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn5 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn6 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn7 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn8 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn9 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn10 = CreateObject(OBJECT_TYPE_CREATURE,"zombie"+IntToString(d10()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
//announce the event to the PCs
object oPC = GetFirstPC();
while(oPC!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("Hide your brains. Zombie attack!",oPC);
    oPC=GetNextPC();
    }
}
