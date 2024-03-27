//:: Name x2_def_endcombat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modified Combat Round End script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
// Modified by Pete Smith for the Troglodyte's
// stench effect. Nov. '04

void main()
{
object oScan = GetFirstObjectInShape(SHAPE_SPHERE,10.0,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
effect eDrain;
int iRoll;
effect ePuff = EffectVisualEffect(VFX_IMP_DISEASE_S,FALSE);
effect eSucceed = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE ,FALSE);
while (GetIsObjectValid(oScan))
    {
    if ((GetIsReactionTypeHostile(oScan) == TRUE) && (GetLocalInt(oScan,"iTrogStench") != 1))
        {
        if (FortitudeSave(oScan,13,SAVING_THROW_TYPE_DISEASE) > 0)
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eSucceed,oScan);
            }
        else
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,ePuff,oScan);
            iRoll = d6(1);
            eDrain = EffectAbilityDecrease(ABILITY_STRENGTH, iRoll);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDrain,oScan,60.0);
            FloatingTextStringOnCreature("The troglodyte's stench has nauseated you.",oScan,FALSE);
            }
        SetLocalInt(oScan,"iTrogStench",1);
        AssignCommand(oScan,DelayCommand(60.0,DeleteLocalInt(OBJECT_SELF,"iTrogStench")));
        }
    oScan = GetNextObjectInShape(SHAPE_SPHERE,10.0,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
    }

    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
