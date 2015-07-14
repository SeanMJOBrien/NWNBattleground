#include "_include_main"
void main()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(OBJECT_SELF);
int iBegged = GetLocalInt(OBJECT_SELF,"danced");
if (iBegged>=50)
    {
    SpeakString("Go away! Now, you are annoying me.",TALKVOLUME_TALK);
    return;
    }
int iDC = 20-iGold+iBegged;
if (iDC<=1) iDC=1;
int iSkill = GetSkillRank(SKILL_PERFORM,oPC,FALSE);
int iCheck = iSkill+d20();
if (iCheck>=iDC)
    {
    GiveGoldToCreature(oPC,d4());
    SpeakString("Here you go, thank you for the performance.",TALKVOLUME_TALK);
    DelayCommand(3.0f,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0f,0.0f)));
    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oPC,3.0f);
    SetLocalInt(OBJECT_SELF,"danced",iBegged+3);
    return;
    }
SpeakString("Go away, fool!",TALKVOLUME_TALK);
SetLocalInt(OBJECT_SELF,"danced",iBegged+3);
}
