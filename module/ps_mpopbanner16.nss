void main()
{
object oPC = GetPCSpeaker();
int nSeedStr = GetLocalInt(OBJECT_SELF,"SeedStr");
string sSeedChar = GetLocalString(OBJECT_SELF,"SeedChr");
if ((nSeedStr == 0) || (sSeedChar == "")) return;
int nCountZ = 1;
string sCountZ = GetLocalString(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")),"Pop"+IntToString(nCountZ));
while (sCountZ != "")
    {
    nCountZ++;
    sCountZ = GetLocalString(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")),"Pop"+IntToString(nCountZ));
    }
SetLocalString(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")),"Pop"+IntToString(nCountZ),sSeedChar+"_"+IntToString(nSeedStr));
DeleteLocalInt(OBJECT_SELF,"SeedStr");
DeleteLocalInt(OBJECT_SELF,"SeedChr");
//SendMessageToPC(GetPCSpeaker(),"oMPOP name: "+GetName(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")))+", nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));
}
