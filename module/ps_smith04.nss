#include "ps_craftsman"

void main()
{
GenerateStoreList("SMITH_WEAPON",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("SMITH_WEAPON"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("SMITH_WEAPON"));

}
