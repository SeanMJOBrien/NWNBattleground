int StartingConditional()
{
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
string sTag = GetTag(GetArea(OBJECT_SELF));
if (sTag != "CM_PUB") return TRUE;
return FALSE;
}
