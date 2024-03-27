int StartingConditional()
{
object oCrate = GetNearestObjectByTag("ps_storagecrate");
if ((GetFirstItemInInventory(oCrate) != OBJECT_INVALID) && (GetLocalInt(GetPCSpeaker(),"Storing") == 1)) return TRUE;
return FALSE;
}
