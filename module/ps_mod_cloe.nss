#include "ps_timestamp"
#include "ps_mod_data"

void main()
{
object oPC = GetEnteringObject();
object oStores = GetObjectByTag("ps_warehouse");
object oScan;
int nNumber;
string sCRef;

LoadTime(oPC);

int nOnlyPC = TRUE;
oScan = GetFirstPC();
while (oScan != OBJECT_INVALID)
    {
    if (oScan != oPC)
        {
        nOnlyPC = FALSE;
        return;
        }
    oScan = GetNextPC();
    }
int nSavedDay = GetCampaignInt("SHIELD_LANDS","TD_"+GetName(oPC));

if ((GetXP(oPC) == 0))
    {
    oScan = GetFirstItemInInventory(oPC);
    while (oScan != OBJECT_INVALID)
        {
        DestroyObject(oScan);
        oScan = GetNextItemInInventory(oPC);
        }
    object oConfiscate = GetObjectByTag("CONFISCATE");
    AssignCommand(oConfiscate,TakeGoldFromCreature(GetGold(oPC),oPC,TRUE));
    AssignCommand(oConfiscate,GiveGoldToCreature(oPC,30));
    }
int nDead = GetCampaignInt("SHIELD_LANDS","DEAD_"+GetName(oPC));
location lBody = GetCampaignLocation("SHIELD_LANDS","BODY_"+GetName(oPC));
if ((nOnlyPC == TRUE) && (nDead == 1))
    {
    object oAltar = GetWaypointByTag("ALTAR_RESPAWN");
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionJumpToObject(oAltar));
    DeleteCampaignVariable("SHIELD_LANDS","DEAD_"+GetName(oPC));
    DeleteCampaignVariable("SHIELD_LANDS","BODY_"+GetName(oPC));
    nNumber = d100();
    AdvanceTimeInHours(nNumber);
    if (GetHitDice(oPC) > 1)
        {
        int nHD = GetHitDice(oPC) -1;
        int nMax = (((nHD + 1) * nHD) / 2) * 1000;
        int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
        int nMid = nMin + ((nMax - nMin) / 2);
        SetXP(oPC, nMid);
        SendMessageToPC(oPC,"As you are the only PC logged on, you will be raised at the cost of a level. It is "+SayHours(nNumber)+" later. "+SayGreyhawkDateTime());
        }
    else if (GetAbilityScore(oPC,ABILITY_CONSTITUTION) > 3)
        {
        int nRaisePenalty = GetCampaignInt("SHIELD_LANDS","RAISE_"+GetName(oPC));
        nRaisePenalty++;
        if ((GetAbilityScore(oPC,ABILITY_CONSTITUTION) - nRaisePenalty) < 3)
            nRaisePenalty = GetAbilityScore(oPC,ABILITY_CONSTITUTION) - 3;
        SetLocalInt(oPC,"RaisePenalty",nRaisePenalty);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_CONSTITUTION,nRaisePenalty),oPC);
        if (GetCurrentHitPoints(oPC) < 1)
            {
            int nHeal = abs(GetCurrentHitPoints(oPC)) + 1;
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oPC);
            }
        SendMessageToPC(oPC,"As you are the only PC logged on, you will be raised but infirm. It is "+SayHours(nNumber)+" later. "+SayGreyhawkDateTime());
        }
    }
else if ((nOnlyPC != TRUE) && (nDead == 1))
    {
    if (GetGender(oPC) == GENDER_FEMALE) sCRef = "ps_comatosepc_f";
    else sCRef = "ps_comatosepc_m";
    object oCorpse = CreateObject(OBJECT_TYPE_ITEM,sCRef,lBody,FALSE);
    SetLocalObject(oCorpse,"Owner",oPC);
    SetLocalObject(oPC,"Corpse",oCorpse);
    SetLocalInt(oPC,"Dead",1);
    object oComa = GetWaypointByTag("COMA_RESPAWN");
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionJumpToObject(oComa));
    SendMessageToPC(oPC,"You are still in a coma.");
    }
PrintString(SayLogTime()+" "+GetName(oPC)+" logged on.");
}
