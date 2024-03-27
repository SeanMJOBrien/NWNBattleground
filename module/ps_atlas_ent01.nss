int StartingConditional()
{
if ((GetTag(OBJECT_SELF) == "ENTER")
    && (GetXP(GetPCSpeaker()) != 0)) return TRUE;
return FALSE;

}
