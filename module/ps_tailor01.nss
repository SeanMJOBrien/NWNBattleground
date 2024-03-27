#include "ps_craftsman"

void main()
{
GenerateStoreList("CW_TAILORSTORE",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("CW_TAILORSTORE"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("CW_TAILORSTORE"));
}
