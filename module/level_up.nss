void main()
{
int iLevel;
object oMod = GetModule();
int iDL = GetLocalInt(OBJECT_SELF,"dontlevel");
if (iDL==1) return;
int iTeam = GetLocalInt(OBJECT_SELF,"team");
string sTeam = IntToString(iTeam);
int iHD = GetLocalInt(oMod,sTeam+"milmax");
if (iTeam==0) iHD = GetLocalInt(oMod,"avglevel");
int iLevelAdd = GetLocalInt(OBJECT_SELF,"leveladd");
iHD = iHD + iLevelAdd;
int iClass = GetCreatureStartingPackage(OBJECT_SELF);
//int iType = GetClassByPosition(1,OBJECT_SELF);
if (iHD>=39) iHD=39;
if (iHD<=1) return;

while (iLevel<iHD)
{
iLevel = LevelUpHenchman(OBJECT_SELF,CLASS_TYPE_INVALID,TRUE,PACKAGE_INVALID);
string sResult = IntToString(iLevel);
//SpeakString("My new level is "+sResult,TALKVOLUME_SHOUT);
WriteTimestampedLogEntry(GetName(OBJECT_SELF)+": My new level is "+sResult);
        if (iLevel==0) break;
}

}
