#include "ps_craftsman"
void main()
{
int nPlace = GetLocalInt(GetPCSpeaker(),"nPlace") - 10;
GenerateStoreList("SMITH_ARMOR",nPlace);
SetLocalInt(GetPCSpeaker(),"nPlace",nPlace);
}

