#include "ps_timestamp"

void main()
{
object oPC = GetPCSpeaker();
object oBread = CreateItemOnObject("ps_bread",oPC);
//AdvanceTimeStamp(oBread,0,0,5,0,1);
TakeGoldFromCreature(4,oPC,TRUE);
}
