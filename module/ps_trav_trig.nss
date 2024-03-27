void main()
{
object oPC = GetLastUsedBy();
object oSelf = OBJECT_SELF;
string sTag = GetLocalString(OBJECT_SELF,"CODE");
if (sTag == "") sTag = GetSubString(GetTag(OBJECT_SELF),0,4);
//object oEnemySeen = GetNearestCreature(CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,oPC,1,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,CREATURE_TYPE_IS_ALIVE,TRUE);
//if  ((GetIsInCombat(oPC)) ||
//       ((oEnemySeen != OBJECT_INVALID) && (!GetIsDead(oEnemySeen)) && (GetDistanceBetween(oPC,oEnemySeen) <= 15.0)))
//    {
//    if ((!GetLocalInt(oPC,"FleeFail")
//        && ((d20() + GetAbilityModifier(ABILITY_DEXTERITY,oPC)) > (d20() + GetAbilityModifier(ABILITY_DEXTERITY,oEnemySeen)))))
//        SetLocalInt(oPC,"Flee",1);
//    else if (!GetLocalInt(oPC,"FleeFail"))
//        {
//        SendMessageToPC(oPC,"You were unsuccessful in you attempt to flee.");
//        SetLocalInt(oPC,"FleeFail",1);
//        DelayCommand(12.0,DeleteLocalInt(oPC,"FleeFail"));
//        return;
//        }
//    else return;
//    }
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
}
