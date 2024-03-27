void main()
{
object oPC = GetEnteringObject();
object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF);
object oTargetArea = GetArea(GetTransitionTarget(oDoor));
int nUnderAttack = GetLocalInt(GetArea(OBJECT_SELF),"UnderAttack");
if ((GetIsNight()) && (GetLocalInt(oDoor,"PlayerUnlocked") == FALSE) && (!nUnderAttack) && (!GetIsOpen(oDoor)))
    {
    SetLocked(oDoor,1);
    }
else if ((GetLocked(oDoor)) || (nUnderAttack)) SetLocked(oDoor,0);
}
