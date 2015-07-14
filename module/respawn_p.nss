#include "nw_i0_2q4luskan"
void main()
{
string sRes = GetLocalString(OBJECT_SELF,"resref");
location lHere = GetLocation(OBJECT_SELF);
CreateObjectVoid(OBJECT_TYPE_PLACEABLE,sRes,lHere);
DestroyObject(OBJECT_SELF);
}
