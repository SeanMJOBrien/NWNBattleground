void main()
{
object oPC = GetPCSpeaker();
int nWPCount =GetLocalInt(OBJECT_SELF,"WPCount");
object oMPOP = GetObjectByTag("MPOP",nWPCount);
int nCountX = 1;
string sBufferX = GetLocalString(oMPOP,"Pop"+IntToString(nCountX));
while (sBufferX != "")
    {
    DeleteLocalString(oMPOP,"Pop"+IntToString(nCountX));
    DeleteLocalString(oMPOP,"Pop"+IntToString(nCountX)+"_B");
    nCountX ++;
    sBufferX = GetLocalString(oMPOP,"Pop"+IntToString(nCountX));
    }
//SendMessageToPC(GetPCSpeaker(),"oMPOP name: "+GetName(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")))+", nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));
}

