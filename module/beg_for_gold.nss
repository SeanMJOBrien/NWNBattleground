#include "_include_main"
void main()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(OBJECT_SELF);
int iBegged = GetLocalInt(OBJECT_SELF,"begged");
if (iBegged>=30)
    {
    SpeakString("You truly are persistent. Leave me alone or I shall call the local constibulary.",TALKVOLUME_TALK);
    return;
    }
int iDC = 25-iGold+iBegged;
if (iDC<=1) iDC=1;
int iCheck = DoSkillCheck(oPC,"Begging",iDC);
if (iCheck==1)
    {
    GiveGoldToCreature(oPC,1);
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0f,3.0f));
    SpeakString("Here you go, you poor soul.",TALKVOLUME_TALK);
    SetLocalInt(OBJECT_SELF,"begged",iBegged+3);
    return;
    }
SpeakString("Go away, beggar!.",TALKVOLUME_TALK);
SetLocalInt(OBJECT_SELF,"begged",iBegged+5);
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0f,3.0f));
}
