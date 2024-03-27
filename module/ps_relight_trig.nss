void main()
{
object oPC = GetEnteringObject();
if (GetLocalInt(OBJECT_SELF,"Triggered") != 1)
    {
    RecomputeStaticLighting(GetArea(OBJECT_SELF));
    SetLocalInt(OBJECT_SELF,"TRIGGERED",TRUE);
    DelayCommand(60.0,DeleteLocalInt(OBJECT_SELF,"TRIGGERED"));
    }

}
