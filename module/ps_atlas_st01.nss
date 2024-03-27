int StartingConditional()
{

if ((GetTag(OBJECT_SELF) == "START")
    && (GetXP(GetPCSpeaker()) == 0))
    {
    PlayAnimation(ANIMATION_PLACEABLE_OPEN);
    return TRUE;
    }
return FALSE;
}
