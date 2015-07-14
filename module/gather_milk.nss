void main()
{
object oPC = GetPCSpeaker();
int iEgg = GetLocalInt(OBJECT_SELF,"milk");
if (iEgg==TRUE)
    {
    FloatingTextStringOnCreature("This cow yields no milk.",oPC,FALSE);
    return;
    }
int iRoll = GetSkillRank(SKILL_ANIMAL_EMPATHY,OBJECT_SELF,FALSE)+d20();
if (iRoll<=10)
    {
    FloatingTextStringOnCreature("Failed check. You harvest no milk",oPC,FALSE);
    return;
    }
if (iRoll>=11)
    {
    FloatingTextStringOnCreature("You get some milk",oPC,FALSE);
    CreateItemOnObject("milk",oPC);
    }
if (iRoll>=20)
    {
    CreateItemOnObject("milk",oPC);
    }
if (iRoll>=30)
    {
    CreateItemOnObject("milk",oPC);
    }
if (iRoll>=40)
    {
    CreateItemOnObject("milk",oPC);
    }
if (iRoll>=50)
    {
    CreateItemOnObject("milk",oPC);
    }
//CreateItemOnObject("milk",oPC);
SetLocalInt(OBJECT_SELF,"milk",1);
DelayCommand(180.0f,DeleteLocalInt(OBJECT_SELF,"milk"));
}
