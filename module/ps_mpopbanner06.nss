void main()
{
//SetLocalInt(GetPCSpeaker(),"WPCount",0);
object oMPOP = GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount"));
if (oMPOP == OBJECT_INVALID)
    {
    SetCustomToken(401,"There are no more MPOP waypoints.");
    return;
    }
string sSayW = GetName(oMPOP)+", (AREA: "+GetName(GetArea(oMPOP))+") ";
string sGrow =  GetLocalString(oMPOP,"GROWTH");
if (sGrow != "")
    sSayW = sSayW + "(GROWTH: "+sGrow+") ";
int nCountW = 1;
string sBufferW = GetLocalString(oMPOP,"Pop"+IntToString(nCountW));
while (sBufferW != "")
    {
    sSayW = sSayW + "("+ sBufferW+") ";
    nCountW ++;
    sBufferW = GetLocalString(oMPOP,"Pop"+IntToString(nCountW));
    }
SendMessageToPC(GetPCSpeaker(),"oMPOP name: "+GetName(oMPOP)+", nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));
SetCustomToken(401,sSayW);
}
