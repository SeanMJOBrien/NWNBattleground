void main()
{
object oPC = GetPCSpeaker();
int iDF = GetLocalInt(oPC,"df");
if (iDF<1)
    {
    FloatingTextStringOnCreature("<cþ  >This requires 1 DF, which you don't have.</c>",oPC,0);
    return;
    }

AssignCommand(oPC,ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS,oPC,METAMAGIC_ANY,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
SetLocalInt(oPC,"df",iDF-1);
}
