#include "ps_craftsman"

void main()
{
GenerateStoreList("ALTON_SPELLS1",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("ALTON_SPELLS1"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("ALTON_SPELLS1"));
}
