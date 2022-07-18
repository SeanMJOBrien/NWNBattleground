void main()
{
object oItem = GetFirstItemInInventory(OBJECT_SELF);
object oChest = GetLocalObject(OBJECT_SELF,"mychest");
while (oItem!=OBJECT_INVALID)
    {
    CopyItem(oItem,oChest,TRUE);
    DestroyObject(oItem);
    oItem = GetNextItemInInventory(OBJECT_SELF);
    }
DestroyObject(OBJECT_SELF,2.0f);
}
