void main()
{
object oPC = GetLocalObject(OBJECT_SELF,"OWNER");
if (GetDistanceBetween(oPC,OBJECT_SELF) > 10.0)
    {
    PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    DestroyObject(OBJECT_SELF,3.0);
    }
}
