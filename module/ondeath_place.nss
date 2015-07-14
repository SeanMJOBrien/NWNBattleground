void main()
{
location lHere = GetLocation(OBJECT_SELF);
object oPC =  GetLastKiller();
int iTeam = GetLocalInt(oPC,"team");
string sName = GetName(oPC);
int iCP = GetLocalInt(oPC,"cp");
object oMod = GetModule();
string sNameSelf = GetName(OBJECT_SELF);
int iMyTeam = GetLocalInt(OBJECT_SELF,"team");
int iIgnore =GetLocalInt(OBJECT_SELF,"ignore");

if (iTeam==iMyTeam)//bad job
{
//traitor code here
SetLocalInt(oPC,"cp",iCP-20);
FloatingTextStringOnCreature("You destroyed the "+sNameSelf+". Traitor. CP -20.",oPC,0);
AdjustReputation(oPC,GetObjectByTag("goodguyx"),-100);
AdjustReputation(oPC,GetObjectByTag("evilguyx"),-100);
}
if (iTeam!=iMyTeam&&iIgnore!=FALSE)//good job
{
SpeakString(sName+" has destroyed the "+sNameSelf+".",TALKVOLUME_SHOUT);
GiveXPToCreature(oPC,100);
SetLocalInt(oPC,"cp",iCP+5);
FloatingTextStringOnCreature("You destroyed the "+sNameSelf+". +5 Command Points.",oPC,TRUE);
}
//respawn code
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
}
