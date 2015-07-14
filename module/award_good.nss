void main()
{
object oPC = GetFirstPC();
int iCP;
int iTeam;

   while (oPC!=OBJECT_INVALID)
    {
    iTeam = GetLocalInt(oPC,"team");
    if (iTeam==1)
        {
        DelayCommand(1.0f,FloatingTextStringOnCreature("Evil gate destroyed bonus. +100 XP, +10 CP.",oPC,FALSE));
        GiveXPToCreature(oPC,100);
        iCP = GetLocalInt(oPC,"cp");
        SetLocalInt(oPC,"cp",iCP+10);
        }
    oPC = GetNextPC();
    }
}
