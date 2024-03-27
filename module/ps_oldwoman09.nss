int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetSkillRank(SKILL_HEAL,oPC) > 0) return TRUE;
return FALSE;
}
