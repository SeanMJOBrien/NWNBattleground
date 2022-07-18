void main()
{
object oPC = GetItemActivator();
object oArea = GetArea(oPC);
string sArea = GetTag(oArea);
if (sArea=="start") return;
object oTarget = GetItemActivatedTarget();
if (oPC==oTarget)
    {
    AssignCommand(oPC,ActionStartConversation(oPC,"conv_dfmenu",FALSE,FALSE));
    }
}
