void main()
{
object oStores = GetObjectByTag("ps_warehouse");
object oCrate = GetNearestObjectByTag("ps_storagecrate");
object oPC = GetPCSpeaker();

object oScan = GetFirstItemInInventory(oCrate);
while (oScan != OBJECT_INVALID)
    {
        SetLocalString(oScan,"Owner",GetName(oPC));
        AssignCommand(oCrate,ActionGiveItem(oScan,oStores));
    oScan = GetNextItemInInventory(oCrate);
    }
DeleteLocalInt(GetPCSpeaker(),"Storing");
}
