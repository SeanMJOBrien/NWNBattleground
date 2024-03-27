#include "spawn_functions"
void main()
{

object oPC = GetExitingObject();
DeleteLocalInt(oPC,"LegalRest");
    Spawn_OnAreaExit();

}
