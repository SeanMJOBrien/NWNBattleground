void main()
{
object oPC = GetLastClosedBy();
int iSpam = GetLocalInt(OBJECT_SELF,"spamtimer");
if (iSpam==1)
    {
    return;
    }
AssignCommand(OBJECT_SELF,ActionStartConversation(oPC,"conv_forge",FALSE,FALSE));
SetLocalInt(OBJECT_SELF,"spamtimer",1);
DelayCommand(2.0f,DeleteLocalInt(OBJECT_SELF,"spamtimer"));
}
