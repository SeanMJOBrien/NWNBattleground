#include "nw_i0_2q4luskan"
void main()
{
//SpeakString("Script running to respawn NPC.");
string sRes = GetLocalString(OBJECT_SELF,"resref");
location lHere = GetLocalLocation(OBJECT_SELF,"rloc");
CreateObjectVoid(OBJECT_TYPE_CREATURE,sRes,lHere);
DestroyObject(OBJECT_SELF);
}
