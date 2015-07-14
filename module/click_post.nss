void main()
{
int iHP = GetCurrentHitPoints(OBJECT_SELF);
string sRes = GetLocalString(OBJECT_SELF,"res");
object oMod = GetModule();
int iLevel = GetLocalInt(oMod,sRes);
string  sLevel = IntToString(iLevel);
string sHP = IntToString(iHP);
string sMessage = "HP are "+sHP+". Level is "+sLevel+".";
AssignCommand(OBJECT_SELF,ActionSpeakString(sMessage,TALKVOLUME_TALK));
}
