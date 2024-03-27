#include "ps_craftsman"

void main()
{
GenerateStoreList("CW_BOWYER",1);
SetLocalObject(GetPCSpeaker(),"Container",GetObjectByTag("CW_BOWYER"));
SetLocalInt(GetPCSpeaker(),"nPlace",1);
SetLocalInt(GetPCSpeaker(),"nTotal",CountStore("CW_BOWYER"));
}
