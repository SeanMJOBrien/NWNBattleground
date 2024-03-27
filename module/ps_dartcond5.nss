int StartingConditional()
{
if (GetLocalInt(GetArea(OBJECT_SELF),"iSummoned") > 0) return TRUE;
else return FALSE;
}
