void main()
{
object oPC = GetLastUsedBy();
int iTeam = GetLocalInt(oPC,"team");
int iMyTeam =GetLocalInt(OBJECT_SELF,"team");
if (iTeam!=iMyTeam)
        {
        FloatingTextStringOnCreature("<c�  >Wrong mana pool.</c>",oPC,0);
        return;
        }
AssignCommand(oPC,ActionStartConversation(oPC,"conv_manapool",TRUE,FALSE));
}
