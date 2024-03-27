int StartingConditional()
{
object oStandard = GetItemPossessedBy(GetPCSpeaker(),"SHLD_STANDARD");
if (oStandard != OBJECT_INVALID)
    {
    if (GetLocalInt(oStandard,"FORCE") > 0)
        return TRUE;
    }
return FALSE;
}
