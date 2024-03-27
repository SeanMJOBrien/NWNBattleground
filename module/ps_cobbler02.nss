#include "ps_craftsman"

void main()
{
GenerateStoreList("RF_COBBLER",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("RF_COBBLER"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("RF_COBBLER"));
}
