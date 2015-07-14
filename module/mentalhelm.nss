void main()
{
object oPC = GetItemActivator();
object oTarget = GetItemActivatedTarget();
int iHD = GetHitDice(oPC);
int iINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)*2;
int iCON = FloatToInt(GetSkillRank(SKILL_CONCENTRATION,oPC,FALSE)/3.0f);
int iDC = d20()+iINT+iCON;
int iDUM = GetAbilityModifier(ABILITY_INTELLIGENCE,oTarget)*2;
int iDUH = FloatToInt(GetSkillRank(SKILL_CONCENTRATION,oTarget,FALSE)/3.0f);
int iDef = d20()+iDUM+iDUH;
effect eZap = EffectBeam(VFX_BEAM_EVIL,oPC,BODY_NODE_CHEST);

if (iDef==iDC)
         {
         FloatingTextStringOnCreature("Nothing happens.",oPC);
         return;
         }
if (iDef>iDC)
         {
         int iResult = iDef-iDC;
         float fDur = IntToFloat(iResult);
         FloatingTextStringOnCreature("Mind attack backfires.",oPC);
         effect eDer = EffectAbilityDecrease(ABILITY_INTELLIGENCE,d6(2));
         effect eDam = EffectDamage(iResult,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL);
         effect eViz = EffectVisualEffect(VFX_IMP_DOOM);
         effect eBam = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
         effect eSalt = EffectDazed();
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDer,oPC,fDur);
         ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
         ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oPC);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBam,oPC,fDur);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSalt,oPC,fDur);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eZap,oTarget,1.0f);
         return;
         }
if (iDC>iDef)
         {
         int iResult = iDC-iDef;
         float fDur = IntToFloat(iResult);
         FloatingTextStringOnCreature("Mind attack success.",oPC);
         effect eDer = EffectAbilityDecrease(ABILITY_INTELLIGENCE,d6(2));
         effect eDam = EffectDamage(iResult,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL);
         effect eViz = EffectVisualEffect(VFX_IMP_DOOM);
         effect eBam = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
         effect eSalt = EffectDazed();
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDer,oTarget,fDur);
         AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oTarget));
         ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBam,oTarget,fDur);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSalt,oTarget,fDur);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eZap,oTarget,1.0f);
         GiveXPToCreature(oPC,iResult);
         return;
         }



}
