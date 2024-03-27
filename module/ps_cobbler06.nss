#include "ps_craftsman"
void main()
{
object oPC = GetPCSpeaker();
WipeStoreList("COBBLER");
DeleteLocalInt(oPC,"CraftChoose");
DeleteLocalInt(oPC,"nPlace");
DeleteLocalInt(oPC,"nTotal");
DeleteLocalObject(GetPCSpeaker(),"Container");

}
