int StartingConditional()
{
object oScan = GetFirstObjectInArea();
while (oScan != OBJECT_INVALID)
    {
    if ((GetIsPC(oScan)) && (GetLocalInt(oScan,"Storing") == 1)) return FALSE;
    oScan = GetNextObjectInArea();
    }
return TRUE;
}
