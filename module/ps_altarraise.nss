void main()
{
object oScan = GetFirstItemInInventory(OBJECT_SELF);
object oItem;
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "COMA_PC")
        {
        oItem = oScan;
        break;
        }
    oScan = GetNextItemInInventory(OBJECT_SELF);
    }
if (oItem != OBJECT_INVALID)
    {
    object oOwner = GetLocalObject(oItem,"Owner");
    if ((oOwner != OBJECT_INVALID) && (GetCampaignInt("SHIELD_LANDS","DEAD_"+GetName(oOwner))))
    {
    location lRespawn = GetLocation(GetWaypointByTag("ALTAR_RAISE"));
    DestroyObject(oItem);
    AssignCommand(oOwner,ClearAllActions(TRUE));
    AssignCommand(oOwner,ActionJumpToLocation(lRespawn));
    DeleteCampaignVariable("SHIELD_LANDS","DEAD_"+GetName(oOwner));
    DeleteCampaignVariable("SHIELD_LANDS","BODY_"+GetName(oOwner));
                    if (GetHitDice(oOwner) > 1)
                        {
                        int nHD = GetHitDice(oOwner) -1;
                        int nMax = (((nHD + 1) * nHD) / 2) * 1000;
                        int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
                        int nMid = nMin + ((nMax - nMin) / 2);
                        SetXP(oOwner, nMid);
                        SendMessageToPC(oOwner,"You suffer level loss from being raised.");
                        }
                    else if (GetAbilityScore(oOwner,ABILITY_CONSTITUTION) > 3)
                        {
                        int nRaisePenalty = GetLocalInt(oOwner,"RaisePenalty");
                        nRaisePenalty++;
                        if ((GetAbilityScore(oOwner,ABILITY_CONSTITUTION) - nRaisePenalty) < 3)
                            nRaisePenalty = GetAbilityScore(oOwner,ABILITY_CONSTITUTION) - 3;
                        SetLocalInt(oOwner,"RaisePenalty",nRaisePenalty);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityDecrease(ABILITY_CONSTITUTION,nRaisePenalty),oOwner);
                        if (GetCurrentHitPoints(oOwner) < 1)
                            {
                           int nHeal = abs(GetCurrentHitPoints(oOwner)) + 1;
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nHeal),oOwner);
                           }
                            SendMessageToPC(oOwner,"You are raised but infirm.");
                        }
    oScan = GetFirstItemInInventory(OBJECT_SELF);
        {
        ActionGiveItem(oScan, oOwner);
        oScan = GetNextItemInInventory(OBJECT_SELF);
        }
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HEALING_M),oOwner));
    }
    }
}
