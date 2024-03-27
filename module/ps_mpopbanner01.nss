void main()
{
object oSelf = OBJECT_SELF;
object oPC = GetLastUsedBy();
AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC,ActionStartConversation(oSelf,"ps_mpopbanner",TRUE,FALSE));
}
