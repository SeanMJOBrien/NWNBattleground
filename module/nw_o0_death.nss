//::///////////////////////////////////////////////
//:: Death Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2008 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies.

    BK: October 8 2002: Overriden for Expansion

    Deva Winblood:  April 21th, 2008: Modified to
    handle dismounts when PC dies while mounted.

*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////



 /*
void ClearAllFactionMembers(object oMember, object oPlayer)
{
//    AssignCommand(oMember, SpeakString("here"));
    AdjustReputation(oPlayer, oMember, 100);
    SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
    object oClear = GetFirstFactionMember(oMember, FALSE);
    while (GetIsObjectValid(oClear) == TRUE)
    {
        ClearPersonalReputation(oPlayer, oClear);
        oClear = GetNextFactionMember(oMember, FALSE);
    }
}   */
void Raise(object oPlayer)
{
        effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    //Remove effect if it is negative.
                    RemoveEffect(oPlayer, eBad);
                }
            eBad = GetNextEffect(oPlayer);
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}


///////////////////////////////////////////////////////////////[ MAIN ]/////////
void main()
{
    object oPlayer = GetLastPlayerDied();
    // * make friendly to Each of the 3 common factions
    AssignCommand(oPlayer, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
    }

    DelayCommand(2.5, PopUpGUIPanel(oPlayer,GUI_PANEL_PLAYER_DEATH));
    //reset team faction
int iSide = GetLocalInt(oPlayer,"team");
if (iSide==1)
    {
    AdjustReputation(oPlayer,GetObjectByTag("goodguyx"),100);
    }
    if (iSide==2)
    {
    AdjustReputation(oPlayer,GetObjectByTag("evilguyx"),100);
    }

    object oKiller = GetLastHostileActor(oPlayer);
    if (GetIsPC(oKiller)==FALSE) return;
    string sName = GetName(oPlayer);
    string sKiller = GetName(oKiller);
    object oWidget = GetItemPossessedBy(oKiller,"widget");
    int iKills = GetLocalInt(oWidget,"kills");
    int iPKs = GetLocalInt(oWidget,"pks");
    int iPCHD = GetHitDice(oPlayer);
    int iKHD = GetHitDice(oKiller);
    int iXP = 200*(iPCHD/iKHD);
    if (iXP<=0) iXP=1;
    if (iXP>=400) iXP=400;
    if (iKHD>=(iPCHD+5))
    {
    FloatingTextStringOnCreature("Easy kill. No award.",oKiller,0);
    SetLocalInt(oWidget,"kills",iKills+1);
    SetLocalInt(oWidget,"pks",iPKs+1);
    return;
    }
    if (GetIsPC(oKiller)==TRUE)
    {
    string sXP = IntToString(iXP);
    DelayCommand(2.5f,FloatingTextStringOnCreature("You killed "+sName+". "+sXP+" XP bonus. +5 Command Points. +10 Score.",oKiller));
    GiveXPToCreature(oKiller,iXP);
    int iCPK = GetLocalInt(oKiller,"cp");
    SetLocalInt(oKiller,"cp",iCPK+5);
    object oWidget = GetItemPossessedBy(oKiller,"widget");
    int iRank = GetLocalInt(oWidget,"score");
    SetLocalInt(oWidget,"pks",iPKs+1);
    SetLocalInt(oWidget,"kills",iKills+1);
    SetLocalInt(oWidget,"score",iRank+10);
    }

    object oPC = GetFirstPC();

    while (oPC!=OBJECT_INVALID)
    {
            int iTeam;
            iTeam = GetLocalInt(oPC,"team");


                   if (iTeam!=iSide)
                                   {
                                   DelayCommand(1.5f,FloatingTextStringOnCreature(sName+" was killed by "+sKiller+". 25 XP bonus.",oPC));
                                   GiveXPToCreature(oPC,25);
                                   }





    oPC = GetNextPC();
    }

}
///////////////////////////////////////////////////////////////[ MAIN ]/////////



