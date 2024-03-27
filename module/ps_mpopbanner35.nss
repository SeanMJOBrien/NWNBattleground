int StartingConditional()
{
int nCount = GetLocalInt(OBJECT_SELF,"PopPointer");
int nPlace = (5 * 5) + nCount;
string sPops = GetLocalString(GetModule(),"POPS");
string sPop = GetSubString(sPops,nPlace,4);
SetCustomToken(411,sPop);
if (sPop != "") return TRUE;
return FALSE;
}
