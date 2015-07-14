void main()
{
object oPC = GetFirstPC();
int iSide;
object oItem;
int iScore;

while(oPC!=OBJECT_INVALID)
    {
    iSide = GetLocalInt(oPC,"team");
    FloatingTextStringOnCreature("<cþþ >Evil has won! New game in 30 seconds.</c>",oPC,FALSE);
    if (iSide==2)
        {
        oItem = GetItemPossessedBy(oPC,"widget");
        iScore = GetLocalInt(oItem,"score");
        SetLocalInt(oItem,"score",iScore+1000);
        DelayCommand(3.0f,FloatingTextStringOnCreature("Your team has won! +1000 Score for a victory!",oPC,FALSE));
        }
    if (iSide==1)
        {
        oItem = GetItemPossessedBy(oPC,"widget");
        iScore = GetLocalInt(oItem,"score");
        SetLocalInt(oItem,"score",iScore+500);
        DelayCommand(3.0f,FloatingTextStringOnCreature("Your team has lost. +500 Score for completing a game.",oPC,FALSE));
        }
    oPC=GetNextPC();
    }
DelayCommand(30.0f,StartNewModule(GetName(GetModule())));
}
