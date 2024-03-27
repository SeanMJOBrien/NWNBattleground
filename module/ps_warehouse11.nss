void main()
{
object oContainer = GetObjectByTag("CW_WAREHOUSE_STORES");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);
object oPC = GetPCSpeaker();
object oOwner = GetLocalObject(oItem,"Owner");
int nValue = GetGoldPieceValue(oItem) * 2;
AssignCommand(oContainer,ActionGiveItem(oItem,oPC));
TakeGoldFromCreature(nValue,oPC,TRUE);
object oGold = CreateItemOnObject("nw_it_gold001",oPC,((nValue / 4)*3));
SetLocalObject(oGold,"Owner",oOwner);
DeleteLocalObject(oItem,"Owner");

}
