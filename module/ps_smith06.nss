#include "ps_craftsman"
void main()
{
object oPC = GetPCSpeaker();
WipeStoreList("SMITH_ARMOR");
WipeStoreList("SMITH_WEAPON");
DeleteLocalInt(oPC,"CraftChoose");
DeleteLocalInt(oPC,"nPlace");
DeleteLocalInt(oPC,"nTotal");
DeleteLocalObject(GetPCSpeaker(),"Container");

}
