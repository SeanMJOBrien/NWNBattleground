int StartingConditional()
{
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
if (GetTag(GetArea(OBJECT_SELF)) == "CW_COBBLER") return FALSE;
return TRUE;
}
