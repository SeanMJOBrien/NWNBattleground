void main()
{
object oPC = GetItemActivator();
int iHD = GetHitDice(oPC);
int iCP = GetLocalInt(oPC,"cp");
SetLocalInt(oPC,"cp",iCP+iHD);

effect eViz = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eViz,GetLocation(oPC));
}
