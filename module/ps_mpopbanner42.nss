int StartingConditional()
{
int nCount = GetLocalInt(OBJECT_SELF,"PopPointer");
int nPlace = (5 * 0) + nCount;
string sPops = GetLocalString(GetModule(),"POPS");
string sPop = GetSubString(sPops,nPlace,4);
SendMessageToPC(GetPCSpeaker(),"sPop : "+sPop);
SetCustomToken(416,sPop);
if (sPop != "") return TRUE;
return FALSE;
}
