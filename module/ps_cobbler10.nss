#include "ps_craftsman"

void main()
{
GenerateStoreList("COBBLER_THIEF",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("COBBLER_THIEF"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("COBBLER_THIEF"));
}
