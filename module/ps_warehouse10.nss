void main()
{
object oContainer = GetObjectByTag("CW_WAREHOUSE_STORES");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);
int nValue = GetLocalInt(oItem,"Value");
object oOwner = GetLocalObject(oItem,"Owner");
object oPC = GetPCSpeaker();
AssignCommand(oContainer,ActionGiveItem(oItem,oPC));
TakeGoldFromCreature(nValue,oPC,TRUE);
object oGold = CreateItemOnObject("nw_it_gold001",oPC,((nValue / 4)*3));
SetLocalObject(oGold,"Owner",oOwner);
DeleteLocalObject(oItem,"Owner");
}
