void main()
{
object oPC = GetPCSpeaker();
int iDF = GetLocalInt(oPC,"df");
if (iDF<15)
    {
    FloatingTextStringOnCreature("<c�  >This requires 15 DF, which you don't have.</c>",oPC,0);
    return;
    }

AssignCommand(oPC,ActionCastSpellAtObject(SPELL_HEALING_CIRCLE,oPC,METAMAGIC_ANY,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
SetLocalInt(oPC,"df",iDF-15);
}
