void main()
{
int iHP = GetCurrentHitPoints(OBJECT_SELF);
int iTeam = GetLocalInt(OBJECT_SELF,"team");
object oMod = GetModule();
string sTeam = IntToString(iTeam);
int iLevel = GetLocalInt(oMod,sTeam+"milmax");
string  sLevel = IntToString(iLevel);
string sHP = IntToString(iHP);
string sMessage = "HP are "+sHP+". Current troop training level is "+sLevel+".";
AssignCommand(OBJECT_SELF,ActionSpeakString(sMessage,TALKVOLUME_TALK));
}
