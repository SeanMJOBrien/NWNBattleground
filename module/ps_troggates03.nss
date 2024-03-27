void main()
{
if (GetIsPC(GetLastClosedBy()))
    {
    FloatingTextStringOnCreature("This gate is operated by a counterweight.",GetLastClosedBy(),FALSE);
    ActionOpenDoor(OBJECT_SELF);
    }
}
