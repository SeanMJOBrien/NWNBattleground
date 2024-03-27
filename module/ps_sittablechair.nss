void main()
{
    object oPlayer = GetLastUsedBy();
    object oChair = OBJECT_SELF;
    if (GetIsPC(oPlayer))
    {
        if (GetIsObjectValid(oChair) && !GetIsObjectValid (GetSittingCreature(oChair)))
        {
            AssignCommand(oPlayer, ActionSit(oChair));
        }
    }
}

