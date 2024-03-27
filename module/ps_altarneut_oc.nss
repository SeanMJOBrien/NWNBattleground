void main()
{
object oPC = GetLastClosedBy();
object oScan = GetFirstItemInInventory(OBJECT_SELF);
object oSparks = GetNearestObjectByTag("SPARKS");
object oSound = GetNearestObjectByTag("SPARKSOUND");
float fDuration;
int nValue = GetGold(OBJECT_SELF);
int nTithe = GetCampaignInt("SHIELD_LANDS","TITHE_"+GetName(oPC));
if (((GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)
    || (GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 0)
    || (GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 0)
    || (GetLevelByClass(CLASS_TYPE_RANGER,oPC) > 0))
    && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
    {
    while (oScan != OBJECT_INVALID)
        {
        nValue += GetGoldPieceValue(oScan);
        DestroyObject(oScan);
        oScan = GetNextItemInInventory();
        }
    if (nValue > 0)
        {
        nTithe += nValue;
        SetCampaignInt("SHIELD_LANDS","TITHE_"+GetName(oPC),nTithe);
        if (oSparks != OBJECT_INVALID)
            {
            fDuration = IntToFloat(nTithe) * 0.2;
            if (fDuration < 1.0) fDuration = 1.0;
            string sBlueprint;
            if (nTithe > 300) sBlueprint = "plc_flamelarge";
            else if (nTithe > 100) sBlueprint = "plc_flamemedium";
            else sBlueprint = "plc_flamesmall";
            object oSparksB = CreateObject(OBJECT_TYPE_PLACEABLE,sBlueprint,GetLocation(oSparks));
            RecomputeStaticLighting(GetArea(OBJECT_SELF));
            DelayCommand(fDuration,DestroyObject(oSparksB));
            DelayCommand((fDuration+0.01),RecomputeStaticLighting(GetArea(OBJECT_SELF)));
            }
        SendMessageToPC(oPC,"You have made a sacrifice. Your current account with your deity is "+IntToString(nTithe)+" gold pieces.");
        }
    }
}
