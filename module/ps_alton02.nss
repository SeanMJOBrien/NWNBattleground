#include "ps_craftsman"

void main()
{
GenerateStoreList("ALTON_POTION",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("ALTON_POTION"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("ALTON_POTION"));
}
