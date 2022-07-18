void main()
{
object oEnter = GetEnteringObject();
string sTag = GetTag(OBJECT_SELF);
string sEnter = GetTag(oEnter);
string sCheck = GetStringLeft(sEnter,7);
if (sCheck!="peasant") return;
string sSide = IntToString(GetLocalInt(oEnter,"team"));
string sMySide = IntToString(GetLocalInt(OBJECT_SELF,"team"));
if (sSide!=sMySide) return;
string sValue = GetLocalString(OBJECT_SELF,"value");
string sMax = GetLocalString(OBJECT_SELF,"max");
object oMod = GetModule();
int iValue = GetLocalInt(oMod,sValue);
int iMax =GetLocalInt(oMod,sMax);
if (iValue>=iMax) return;
DestroyObject(oEnter);
SetLocalInt(oMod,sValue,iValue+1);
int iPop = GetLocalInt(oMod,sSide+"pop");
SetLocalInt(oMod,sSide+"pop",iPop-1);
}
