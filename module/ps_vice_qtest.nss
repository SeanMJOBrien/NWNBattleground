int StartingConditional()
{
object oPC = GetPCSpeaker();
object oItemScan = GetFirstItemInInventory(oPC);

while (oItemScan != OBJECT_INVALID)
    {
    if (GetLocalInt(oItemScan,"QUEST") == 1)
        {
        SetCustomToken(867,GetName(oItemScan));
        return TRUE;
        }
    oItemScan = GetNextItemInInventory(oPC);
    }
return FALSE;
}
