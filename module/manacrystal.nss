void main()
{
object oPC = GetItemActivator();
object oItem = GetItemActivated();
int iMana = GetLocalInt(oPC,"mana");
int iRoll = d6(2);
string sRoll = IntToString(iRoll);
SetLocalInt(oPC,"mana",iMana+iRoll);
DestroyObject(oItem);
effect eViz = EffectVisualEffect(VFX_FNF_IMPLOSION);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oPC);
FloatingTextStringOnCreature("<cþ þ>You absorb "+sRoll+" mana.</c>",oPC,FALSE);
}
