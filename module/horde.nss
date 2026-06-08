void main()
{
object oPC = GetPCSpeaker();
int iCP = GetLocalInt(oPC,"cp");
if (iCP<1000)
    {
    FloatingTextStringOnCreature("<c�  >That order requires 1000 Command Points to carry out.</c>",oPC,0);
    return;
    }
int iTeam = GetLocalInt(oPC,"team");
string sTeam;
if (iTeam==1) sTeam = "_good";
else sTeam = "_evil";
object oMod = GetModule();
//int iDepth = GetLocalInt(oMod,"avglevel");
object oWP = GetWaypointByTag("wp_center");//get center of map
location lHere = GetLocation(GetNearestObjectByTag("wp_horde"+sTeam,oWP));
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
object oSpawn11;
object oSpawn12;
//create horde
oSpawn1 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn2 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn2));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn3 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn3));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn4 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn4));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn5 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn5));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn6 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn6));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn7 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn7));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn8 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn8));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn9 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn9));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn10 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn10));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn11 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn11));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
oSpawn12 = CreateObject(OBJECT_TYPE_CREATURE,"horde"+sTeam,lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn12));
lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
SetLocalInt(oPC,"cp",iCP-1000);
//announce the event to the PCs
oPC = GetFirstPC();
string sKind;
if (iTeam==1) sKind = "Dwarven";
else sKind = "Orcish";
while(oPC!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("The "+sKind+" horde has been unleashed.",oPC);
    oPC=GetNextPC();
    }
}
