void main()
{
object oStores = GetObjectByTag("ps_warehouse");
object oCrate = GetNearestObjectByTag("ps_storagecrate");
object oPC = GetPCSpeaker();

object oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
    if (GetLocalObject(oScan,"Owner") == GetPCSpeaker())
        {
        DeleteLocalString(oScan,"Owner");
        AssignCommand(oStores,ActionGiveItem(oScan,oCrate));
        }
    oScan = GetNextItemInInventory(oStores);
    }
SetLocalInt(GetPCSpeaker(),"Storing",1);
}
