#include "spawn_functions"
#include "ps_timestamp"
// "ps_area_ox02" will stamp the area with a 30 minute timestamp.
void main()
{
    AdvanceTimeStamp(GetArea(OBJECT_SELF),0,0,0,15,1);
    Spawn_OnAreaExit();
}
