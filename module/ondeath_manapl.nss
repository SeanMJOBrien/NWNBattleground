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
if (iMyTeam==1) ExecuteScript("evilwins",oMod);
if (iMyTeam==2) ExecuteScript("goodwins",oMod);
if (iTeam==iMyTeam)//bad job
{
//traitor code here
SetLocalInt(oPC,"cp",iCP-20);
FloatingTextStringOnCreature("You destroyed the "+sNameSelf+". Traitor. CP -20.",oPC,0);
AdjustReputation(oPC,GetObjectByTag("goodguyx"),-100);
AdjustReputation(oPC,GetObjectByTag("evilguyx"),-100);
}
if (iTeam!=iMyTeam)//good job
{
SpeakString(sName+" has destroyed the "+sNameSelf+".",TALKVOLUME_SHOUT);
GiveXPToCreature(oPC,100);
SetLocalInt(oPC,"cp",iCP+5);
FloatingTextStringOnCreature("You destroyed the "+sNameSelf+". +5 Command Points.",oPC,TRUE);
}
//set mana to zero
string sTeam = IntToString(iMyTeam);
SetLocalInt(oMod,sTeam+"mana",0);
oPC = GetFirstPC();
string sMyTeam;
while(oPC!=OBJECT_INVALID)
    {
    if (iMyTeam=1) sMyTeam="Good";
    else sMyTeam="Evil";
    DelayCommand(2.0f,FloatingTextStringOnCreature("The "+sMyTeam+" Team's mana pool was destroyed! Game over man.",oPC,TRUE));
    oPC=GetNextPC();
    }
//respawn code
//string sRes = GetResRef(OBJECT_SELF);
//object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
//SetLocalString(oSpawner,"resref",sRes);
//AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
}
