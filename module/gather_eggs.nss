void main()
{
object oPC = GetPCSpeaker();
int iEgg = GetLocalInt(OBJECT_SELF,"eggs");
if (iEgg==TRUE)
    {
    FloatingTextStringOnCreature("You find no eggs.",oPC,FALSE);
    return;
    }
int iRoll =GetSkillRank(SKILL_ANIMAL_EMPATHY,OBJECT_SELF,FALSE)+d20();
if (iRoll<=10)
    {
    FloatingTextStringOnCreature("Failed check. You harvest no eggs",oPC,FALSE);
    return;
    }
if (iRoll>=11)
    {
    FloatingTextStringOnCreature("You get some eggs",oPC,FALSE);
    CreateItemOnObject("chickeneggs",oPC);
    }
if (iRoll>=20)
    {
    CreateItemOnObject("chickeneggs",oPC);
    }
if (iRoll>=30)
    {
    CreateItemOnObject("chickeneggs",oPC);
    }
if (iRoll>=40)
    {
    CreateItemOnObject("chickeneggs",oPC);
    }
if (iRoll>=50)
    {
    CreateItemOnObject("chickeneggs",oPC);
    }
SetLocalInt(OBJECT_SELF,"eggs",1);
DelayCommand(180.0f,DeleteLocalInt(OBJECT_SELF,"eggs"));
}
