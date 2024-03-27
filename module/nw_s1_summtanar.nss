//::///////////////////////////////////////////////
//:: Summon Tanarri
//:: NW_S0_SummSlaad
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a Quasit to aid the threatened Demon
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001

void main()
{
    object oCaster = GetLastSpellCaster();
    string sBlueprint = "";
        int nRoll = d100();
        if (nRoll < 50) { sBlueprint = ""; }
        else if (nRoll <= 90) { sBlueprint = "demn_004"; }
        else sBlueprint = GetResRef(oCaster);
    //Declare major variables
    effect eSummon = EffectSummonCreature(sBlueprint,VFX_FNF_GAS_EXPLOSION_EVIL);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Apply the VFX impact and summon effect
    //ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    if (sBlueprint != "")
        {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
        }
}
