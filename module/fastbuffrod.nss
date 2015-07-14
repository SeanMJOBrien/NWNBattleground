void main()
{
object oPC = GetItemActivator();
location lHere = GetLocation(oPC);
int iHD = GetHitDice(oPC);
float fDur = iHD*12.0f;
effect eAC = EffectACIncrease(4,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
effect eCon = EffectConcealment(10,MISS_CHANCE_TYPE_NORMAL);
effect eDR = EffectDamageReduction(5,DAMAGE_POWER_ENERGY,0);
effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL);
effect eWizz = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
effect eBang = EffectVisualEffect(VFX_FNF_LOS_NORMAL_10);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCon,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDR,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSave,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eWizz,oPC,fDur);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBang,lHere);


}
