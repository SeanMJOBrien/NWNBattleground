#include "NW_I0_GENERIC"

void PCBleed(object oPC)
{
int nLastHP = GetLocalInt(oPC,"LastHP");
int nBleedDC = GetLocalInt(oPC,"BleedDC");
if (GetLocalInt(oPC,"Bleeding") == TRUE)
    {
    if (GetCurrentHitPoints(oPC) > 0)
        {
        DeleteLocalInt(oPC,"Bleeding");
        return;
        }
    if (FortitudeSave(oPC,nBleedDC) > 0)
        {
        SetLocalInt(oPC,"BleedDC",(nBleedDC + 5));
        DelayCommand(6.0,PCBleed(oPC));
        return;
        }
    SetLocalInt(oPC,"BleedDC",10);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY),oPC);
//    if (GetCurrentHitPoints(oPC) <= -10)
    if (GetCurrentHitPoints(oPC) <= -30)

        {
       effect eDeath = EffectDeath(FALSE, FALSE);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
       DeleteLocalInt(oPC,"Bleeding");
       DeleteLocalInt(oPC,"BleedDC");
       return;
       }
    SetLocalInt(oPC,"LastHP",GetCurrentHitPoints(oPC));
        switch (d12())
            {
            case 1: PlayVoiceChat(VOICE_CHAT_PAIN1, oPC); break;
            case 2: PlayVoiceChat(VOICE_CHAT_PAIN2, oPC); break;
            case 3: PlayVoiceChat(VOICE_CHAT_PAIN3, oPC); break;
            case 4: PlayVoiceChat(VOICE_CHAT_HEALME, oPC); break;
            case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH, oPC); break;
            case 6: PlayVoiceChat(VOICE_CHAT_HELP, oPC); break;
            }
    DelayCommand(6.0,PCBleed(oPC));
    }
}

void main()
{
object oPC = GetLastPlayerDying();
object oScan;
int nCount;
if (GetLocalInt(oPC,"Bleeding") != TRUE)
{
    object oScan = GetFirstObjectInArea(GetArea(oPC));
    while (oScan != OBJECT_INVALID)
        {
        if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
            && (GetAttackTarget(oScan) == oPC)
            && (GetIsEnemy(oScan,oPC)))
            {
            AssignCommand(oScan,ClearAllActions(TRUE));
            AssignCommand(oScan,SetIsTemporaryNeutral(oPC,oScan,TRUE,60.0));
            }
        oScan = GetNextObjectInArea(GetArea(oPC));
        }
    SetLocalInt(oPC,"Bleeding",TRUE);
    SetLocalInt(oPC,"BleedDC",10);
    DelayCommand(6.0,PCBleed(oPC));
}
}
