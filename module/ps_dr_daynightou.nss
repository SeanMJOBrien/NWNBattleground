void main()
{
object oPC = GetLastUnlocked();
if (GetIsPC(oPC))
    {
    SetLocalInt(OBJECT_SELF,"PlayerUnlocked",1);
    DelayCommand(60.0,DeleteLocalInt(OBJECT_SELF,"PlayerUnlocked"));
    }
}
