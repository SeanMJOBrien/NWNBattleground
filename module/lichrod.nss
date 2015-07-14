void main()
{
//SpeakString("Script fired.",TALKVOLUME_SHOUT);
object oLich =  GetItemActivator();
object oVictim = GetItemActivatedTarget();
int iHD = GetHitDice(oLich);
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oLich);
int iDC = FloatToInt((iHD/2.0f)+iCHA);
float fDur = iHD*2.0f;
string sDC = IntToString(iDC);
//SpeakString("DC is "+sDC+".",TALKVOLUME_SHOUT);

if(FortitudeSave(oVictim,iDC,SAVING_THROW_TYPE_NONE)==1||FortitudeSave(oVictim,iDC,SAVING_THROW_TYPE_NONE)==2)
{
FloatingTextStringOnCreature("Fortitude save successful vs. DC "+sDC+".",oVictim,TRUE);
return;
}

effect ePara = EffectParalyze();
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePara,oVictim,fDur);
effect eViz = EffectVisualEffect(VFX_DUR_PARALYZED);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eViz,oVictim,fDur);
}
