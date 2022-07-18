void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iAvg = GetLocalInt(oMod,"avglevel");
int iFactor;
if (iAvg>=10) iFactor+= 1;
if (iAvg>=12) iFactor+= 2;
if (iAvg>=14) iFactor+= 3;
if (iAvg>=16) iFactor+= 4;
if (iAvg>=18) iFactor+= 6;
if (iAvg>=20) iFactor+= 8;

int iDF = GetLocalInt(oPC,"df");
if (iDF<10)
    {
    FloatingTextStringOnCreature("<cþ  >This requires 10 DF, which you don't have.</c>",oPC,0);
    return;
    }

effect eSR = EffectSpellResistanceIncrease(iFactor+10+iAvg);
effect eViz = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY,FALSE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSR,oPC,600.0f);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oPC);
SetLocalInt(oPC,"df",iDF-10);
}
