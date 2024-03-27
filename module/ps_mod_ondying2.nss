#include "NW_I0_GENERIC"
#include "ps_mod_data"

void HenchmanSave()
{
ResetHenchmenState();
if(TalentCureCondition()) {DelayCommand(2.0, VoiceCanDo()); return;}
if(TalentHeal(TRUE)) {DelayCommand(2.0, VoiceCanDo()); return;}
DelayCommand(2.5, VoiceCannotDo());

}
void PCRecover(object oTarget)
{
if (GetLocalInt(oTarget,"Dead") == TRUE) return;
if (GetCurrentHitPoints(oTarget) <= -10)
    {
    effect eDeath = EffectDeath(FALSE, FALSE);
    DeleteLocalInt(oTarget,"Recovering");
//    SetImmortal(oTarget,FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
    return;
    }
if (GetLocalInt(oTarget,"Recovering"))
    {
    if (GetCurrentHitPoints(oTarget) < 1) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oTarget);
//    if (GetCurrentHitPoints(oTarget) < 1) DelayCommand(30.0,PCRecover(oTarget));
    if (GetCurrentHitPoints(oTarget) < 1) DelayCommand(12.0,PCRecover(oTarget));
    else
        {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSanctuary(100),oTarget,40.0);
        DeleteLocalInt(oTarget,"Recovering");
        }
    SaveTime(oTarget);
    }
}

void PCBleed(object oPC)
{
int nLastHP = GetLocalInt(oPC,"LastHP");
int nBleedDC = GetLocalInt(oPC,"BleedDC");
if (GetLocalInt(oPC,"Bleeding") == TRUE)
    {
    if (GetCurrentHitPoints(oPC) > 0)
        {
        DeleteLocalInt(oPC,"Bleeding");
        DeleteLocalObject(oPC,"LastHostile");
        return;
        }
    if ((d10() <= 2) || (GetCurrentHitPoints(oPC) > nLastHP))
        {
        SendMessageToPC(oPC,"You have stabilized and will recover 1 hit point every 12 seconds.");
        SetLocalInt(oPC,"Recovering",1);
        DelayCommand(12.0,PCRecover(oPC));
        DeleteLocalInt(oPC,"Bleeding");
//        SetImmortal(oPC,FALSE);
        return;
        }
//    SetImmortal(oPC,FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY),oPC);
//    SetImmortal(oPC,TRUE);
    if (GetCurrentHitPoints(oPC) <= -10)
        {
       effect eDeath = EffectDeath(FALSE, FALSE);
//       SetImmortal(oPC,FALSE);
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
    SaveTime(oPC);
    DelayCommand(6.0,PCBleed(oPC));
    }
}

void main()
{
object oPC = GetLastPlayerDying();
object oScan;
int nCount;
//effect eSanctuary = EffectSanctuary(100);
object oLastHostile = GetLastHostileActor(oPC);
SetLocalObject(oPC,"LastHostile",oLastHostile);
if ((GetLocalInt(oPC,"Bleeding") != TRUE)
    && (GetLocalInt(oPC,"Dead") != TRUE))
{
    object oScan = GetFirstObjectInArea(GetArea(oPC));
    while (oScan != OBJECT_INVALID)
        {
//        if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
//            && (GetAttackTarget(oScan) == oPC)
//            && (GetIsEnemy(oScan,oPC))
//            && (GetAttackTarget(oScan) == oPC))
            if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
                && (GetIsEnemy(oScan,oPC)))
            {
//            SendMessageToPC(oPC,"oScan: "+GetName(oScan));
            SetCommandable(TRUE,oScan);
            AssignCommand(oScan,ClearAllActions(TRUE));
            SetIsTemporaryNeutral(oPC,oScan,TRUE,24.0);
//            SetIsTemporaryNeutral(oPC,oScan,TRUE,60.0);
            AssignCommand(oScan,DetermineCombatRound());
            }
        oScan = GetNextObjectInArea(GetArea(oPC));
        }
    if (GetCurrentHitPoints(oPC) <= -10)
        {
       effect eDeath = EffectDeath(FALSE, FALSE);
//       RemoveEffect(oPC,eSanctuary);
//       SetImmortal(oPC,FALSE);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
       DeleteLocalInt(oPC,"Bleeding");
       DeleteLocalInt(oPC,"BleedDC");
       return;
       }
    object oHenchman = GetHenchman(oPC);
    if ((oHenchman != OBJECT_INVALID) && (GetObjectSeen(oPC,oHenchman)))
        {
        SetCommandable(TRUE,oHenchman);
        AssignCommand(oPC,HenchmanSave());
        }
    SetLocalInt(oPC,"LastHP",GetCurrentHitPoints(oPC));
    if (GetLocalInt(oPC,"Bleeding") == FALSE)
        {
        DelayCommand(6.0,PCBleed(oPC));
        SetLocalInt(oPC,"Bleeding",TRUE);
        }
//    SetImmortal(oPC,TRUE);
//    if (!GetHasEffect(EFFECT_TYPE_SANCTUARY, oPC))ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSanctuary, oPC, 60.0);
}
}
