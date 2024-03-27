int StartingConditional()
{
int nCount = GetLocalInt(OBJECT_SELF,"PopPointer");
int nPlace = (5 * 4) + nCount;
string sPops = GetLocalString(GetModule(),"POPS");
string sPop = GetSubString(sPops,nPlace,4);
SetCustomToken(415,sPop);
if (sPop != "") return TRUE;
return FALSE;
}
