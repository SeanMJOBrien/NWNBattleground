//::///////////////////////////////////////////////
//:: Generic On Pressed Respawn Button
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// * June 1: moved RestoreEffects into plot include
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   November
//:://////////////////////////////////////////////
#include "nw_i0_plot"
#include "x3_inc_horse"

// * Applies an XP and GP penalty
// * to the player respawning

void main()
{
    object oRespawner = GetLastRespawnButtonPresser();
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);
    //* Return PC to temple
    int iSide = GetLocalInt(oRespawner,"team");
    int iPPt = GetLocalInt(oRespawner,"cp");
    int iDFt = GetLocalInt(oRespawner,"df");
    int iManat = GetLocalInt(oRespawner,"mana");
    int iRoll = d3();
    //determine 20% penalty from totals and set strings
    int iPP = (iPPt/5);
    int iDF = (iDFt/5);
    int iMana = (iManat/5);
    string sPP = IntToString(iPP);
    string sDF = IntToString(iDF);
    string sMana = IntToString(iMana);
    ForceRest(oRespawner);
    object oWidget = GetItemPossessedBy(oRespawner,"widget");
    int iMounted = GetLocalInt(oWidget,"mounted");
    int iPheno =  GetPhenoType(oRespawner);
    if (iMounted==1)
        {
        if (iPheno == HORSE_PHENOTYPE_MOUNTED_L) SetPhenoType(PHENOTYPE_BIG,oRespawner);
        else SetPhenoType(PHENOTYPE_NORMAL,oRespawner);
        SetCreatureTailType(0,oRespawner);
        SetLocalInt(oWidget,"mounted",0);
        }

    if (iSide == 2)
         {
         object oSpawnPoint = GetObjectByTag("wp_evilstart");
         AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
         if (iRoll==1) SetLocalInt(oRespawner,"cp",iPPt-iPP);
         if (iRoll==2) SetLocalInt(oRespawner,"df",iDFt-iDF);
         if (iRoll==3) SetLocalInt(oRespawner,"mana",iManat-iMana);
         object oEvilguy = GetObjectByTag("evilguyx");
         object oGoodguy = GetObjectByTag("goodguyx");
         AdjustReputation(oRespawner, oEvilguy, 100);
         AdjustReputation(oRespawner, oGoodguy, -100);
         effect eSanc = EffectSanctuary(99);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSanc,oRespawner,30.0f);
         if (iRoll==1) DelayCommand(2.0f,FloatingTextStringOnCreature("The local priest revives you. Respawn penalty is "+sPP+" Command Points.",oRespawner,FALSE));
         if (iRoll==2) DelayCommand(2.0f,FloatingTextStringOnCreature("Your diety brings you back from the brink of death. Respawn penalty is "+sDF+" Divine Favor.",oRespawner,FALSE));
         if (iRoll==3) DelayCommand(2.0f,FloatingTextStringOnCreature("A wizard reanimates you. You live again. Respawn penalty is "+sMana+" Mana.",oRespawner,FALSE));
         }
         else
         {
         object oSpawnPoint = GetObjectByTag("wp_goodstart");
         AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
         if (iRoll==1) SetLocalInt(oRespawner,"cp",iPPt-iPP);
         if (iRoll==2) SetLocalInt(oRespawner,"df",iDFt-iDF);
         if (iRoll==3) SetLocalInt(oRespawner,"mana",iManat-iMana);
         object oEvilguy = GetObjectByTag("evilguyx");
         object oGoodguy = GetObjectByTag("goodguyx");
         AdjustReputation(oRespawner, oEvilguy, -100);
         AdjustReputation(oRespawner, oGoodguy, 100);
         effect eSanc = EffectSanctuary(99);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSanc,oRespawner,30.0f);
         if (iRoll==1) DelayCommand(2.0f,FloatingTextStringOnCreature("The local priest revives you. Respawn penalty is "+sPP+" Command Points.",oRespawner,FALSE));
         if (iRoll==2) DelayCommand(2.0f,FloatingTextStringOnCreature("Your diety brings you back from the brink of death. Respawn penalty is "+sDF+" Divine Favor.",oRespawner,FALSE));
         if (iRoll==3) DelayCommand(2.0f,FloatingTextStringOnCreature("A wizard reanimates you. You live again. Respawn penalty is "+sMana+" Mana.",oRespawner,FALSE));
         }
 }
