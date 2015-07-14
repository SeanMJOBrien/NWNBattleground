void main()
{
object oPC = GetPCSpeaker();
int iDF = GetLocalInt(oPC,"df");
if (iDF<20)
    {
    FloatingTextStringOnCreature("<cþ  >This requires 20 DF, which you don't have.</c>",oPC,0);
    return;
    }

AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GREATER_RESTORATION,oPC,METAMAGIC_ANY,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
SetLocalInt(oPC,"df",iDF-20);
}
