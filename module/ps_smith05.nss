#include "ps_craftsman"
void main()
{
int nPlace = GetLocalInt(GetPCSpeaker(),"nPlace") + 10;
GenerateStoreList("SMITH_WEAPON",nPlace);
SetLocalInt(GetPCSpeaker(),"nPlace",nPlace);
}
