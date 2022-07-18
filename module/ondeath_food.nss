void main()
{
object oPC = GetLastKiller();
GiveXPToCreature(oPC,5);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iScore = GetLocalInt(oWidget,"score");
int iCP = GetLocalInt(oPC,"cp");
SetLocalInt(oWidget,"score",iScore+1);
SetLocalInt(oPC,"cp",iCP+1);
//respawn code
location lHere = GetLocation(OBJECT_SELF);
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
//message stuff
FloatingTextStringOnCreature("You gather a unit of food. +1 CP. +5 XP. +1 Score.",oPC,FALSE);
CreateItemOnObject("food",oPC);
}
