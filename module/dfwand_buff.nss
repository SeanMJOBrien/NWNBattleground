void main()
{
object oPC = GetPCSpeaker();
int iFactor = (GetHitDice(oPC)/5);
if (iFactor<1) iFactor = 1;
int iDF = GetLocalInt(oPC,"df");
if (iDF<20)
    {
    FloatingTextStringOnCreature("<cþ  >This requires 20 DF, which you don't have.</c>",oPC,0);
    return;
    }

effect eAC = EffectACIncrease(iFactor,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
effect eRegen  = EffectRegenerate(iFactor,6.0f);
effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL,iFactor,SAVING_THROW_TYPE_ALL);
effect eViz = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY,FALSE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oPC,300.0f);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oPC,300.0f);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaves,oPC,300.0f);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oPC);
SetLocalInt(oPC,"df",iDF-20);
}
