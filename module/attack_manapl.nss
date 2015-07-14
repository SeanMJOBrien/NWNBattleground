#include "nw_i0_generic"
void main()
{
    {
    object oPC = GetPCSpeaker();
    int iCP = GetLocalInt(oPC,"cp");
    if (iCP<1)
        {
        SpeakString("You lack the authority.",TALKVOLUME_TALK);
        return;
        }

    object oEnemy;
    int iTeam = GetLocalInt(OBJECT_SELF,"team");
    if (iTeam==1) oEnemy = GetObjectByTag("evilmanapool");
    if (iTeam==2) oEnemy = GetObjectByTag("goodmanapool");
    if (oEnemy!=OBJECT_INVALID)
        {
        ActionAttack(oEnemy);SetLocalString(OBJECT_SELF,"attack","mana");
        SetLocalInt(oPC,"cp",iCP-1);
        return;
        }
    else SpeakString("It is currently destroyed. Maybe later?",TALKVOLUME_TALK);
    }
}
