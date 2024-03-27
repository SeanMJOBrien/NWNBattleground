#include "ps_craftsman"
void main()
{
string sTag = GetTag(GetLocalObject(GetPCSpeaker(),"Container"));
int nPlace = GetLocalInt(GetPCSpeaker(),"nPlace") + 10;
GenerateStoreList(sTag,nPlace);
SetLocalInt(GetPCSpeaker(),"nPlace",nPlace );
}
