int StartingConditional()
{
if (GetLocalInt(GetArea(OBJECT_SELF),"iSummoned") > 3) return FALSE;
if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer8") == OBJECT_INVALID) return TRUE;
else return FALSE;
}
