#include "spawn_functions"
#include "ps_timestamp"
// "ps_area_ox01" will stamp the area with a 60 minute timestamp.
void main()
{
    AdvanceTimeStamp(GetArea(OBJECT_SELF),0,0,0,30,1);
    Spawn_OnAreaExit();
}
