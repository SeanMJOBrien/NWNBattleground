void main()
{
int nCount = GetLocalInt(OBJECT_SELF,"PopPointer");
int nPlace = (5 * 1) + nCount;
string sPops = GetLocalString(GetModule(),"POPS");
SetLocalString(OBJECT_SELF,"SeedChr",GetSubString(sPops, nPlace,4));
}
