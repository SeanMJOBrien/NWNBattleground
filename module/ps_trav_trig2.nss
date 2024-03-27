void main()
{
object oPC = GetLastUsedBy();
object oSelf = OBJECT_SELF;
string sTag = GetTag(OBJECT_SELF);
if (GetIsInCombat(oPC))
    {
    SendMessageToPC(oPC,"You may not travel while in combat.");
    return;
    }
if (StringToInt(GetSubString(sTag,5,4)) <= 0)
    {
    SetLocalString(oPC,"TRAVEL",GetSubString(sTag,0,4) + "_000");
    }
else
    {
    SetLocalString(oPC,"TRAVEL",sTag);
    }
AssignCommand(oPC,ClearAllActions(FALSE));
AssignCommand(oPC,ActionStartConversation(oSelf,"ps_travel",TRUE,FALSE));
DelayCommand(60.0,ActionCloseDoor(OBJECT_SELF));
}
