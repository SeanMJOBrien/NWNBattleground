void main()
{
//slaying weapon
object oPC = OBJECT_SELF;
int iHD = FloatToInt(GetHitDice(oPC)/3.0f);
int iBonus = GetAbilityModifier(ABILITY_CHARISMA,oPC);
object oTarget = GetSpellTargetObject();
int iType = GetObjectType(oTarget);
if (iType!=OBJECT_TYPE_CREATURE) return;
location lHere = GetLocation(oTarget);
effect eEff = EffectDeath();
effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
int iSave = 5+iHD+iBonus;
string sSave = IntToString(iSave);


if (WillSave(oTarget,iSave,SAVING_THROW_TYPE_DEATH)==FALSE)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,oTarget));
}

}
