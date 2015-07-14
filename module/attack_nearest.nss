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

    object oEnemy = GetNearestEnemy(OBJECT_SELF,1);
    if (oEnemy!=OBJECT_INVALID)
        {
        ActionAttack(oEnemy);SetLocalString(OBJECT_SELF,"attack","nearest");
        SetLocalInt(oPC,"cp",iCP-1);
        return;
        }
    else SpeakString("I see no enemies nearby.",TALKVOLUME_TALK);
    }
}
