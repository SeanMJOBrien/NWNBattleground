void main()
{
object oPC = GetItemActivator();
object oTarget = GetItemActivatedTarget();
int iHD = GetHitDice(oPC);
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oPC);
int iPER = GetSkillRank(SKILL_PERFORM,oPC,FALSE);
int iDC = iCHA+iPER;
string sDC = IntToString(iDC);
effect eStun = EffectStunned();
effect eViz = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
float fDur = iHD*6.0f;
effect eSong = EffectVisualEffect(VFX_DUR_BARD_SONG);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSong,oPC,18.0f);

if (WillSave(oTarget,iDC,SAVING_THROW_TYPE_NONE)==0)
        {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStun,oTarget,fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eViz,oTarget,fDur);
        FloatingTextStringOnCreature("Will save failed vs. DC "+sDC,oPC,TRUE);
        }
else
        {
        FloatingTextStringOnCreature("Will save successful vs. DC "+sDC,oPC,TRUE);
        }



}
