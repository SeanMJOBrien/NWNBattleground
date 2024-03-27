#include "ps_craftsman"

void main()
{
GenerateStoreList("SMITH_ARMOR",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("SMITH_ARMOR"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("SMITH_ARMOR"));
}
