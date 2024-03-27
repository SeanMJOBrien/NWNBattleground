#include "ps_timestamp"
#include "ps_mod_data"

void main()
{
object oPC = GetExitingObject();
SaveTime(oPC);
SaveTreasure();
SaveStores(oPC);
}
