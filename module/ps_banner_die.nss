void main()
{
object oPC = GetLastUsedBy();
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,FALSE),oPC);
}
