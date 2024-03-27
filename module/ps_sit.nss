void main()
{
object oPC = GetLastUsedBy();
object oChair = OBJECT_SELF;
AssignCommand(oPC,ActionSit(oChair));
}
