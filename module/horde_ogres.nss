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
oSpawn1 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn2 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn2));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn3 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn3));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn4 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn4));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn5 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn5));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn6 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn6));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn7 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn7));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn8 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn8));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn9 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn9));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn10 = CreateObject(OBJECT_TYPE_CREATURE,"ogre"+IntToString(d6()),lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn10));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
//announce the event to the PCs
object oPC = GetFirstPC();
while(oPC!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("Ogres have come to make bread out of our bones!",oPC);
    oPC=GetNextPC();
    }
}
