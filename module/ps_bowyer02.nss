int StartingConditional()
{
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
if (GetTag(GetArea(OBJECT_SELF)) == "CM_PUB") return FALSE;
return TRUE;
}
