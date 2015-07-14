void main()
{
object oPC = GetLastKiller();
FloatingTextStringOnCreature("You gather a unit of stone. +1 CP. +25 XP. +1 Score.",oPC,FALSE);
GiveXPToCreature(oPC,25);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iScore = GetLocalInt(oWidget,"score");
int iCP = GetLocalInt(oPC,"cp");
SetLocalInt(oWidget,"score",iScore+1);
SetLocalInt(oPC,"cp",iCP+1);
CreateItemOnObject("stone",oPC);
//respawn code
location lHere = GetLocation(OBJECT_SELF);
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
}
