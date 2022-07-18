//::///////////////////////////////////////////////
//:: FileName nonarcanecheck01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/29/04 11:33:41 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) >= 1)
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_FIGHTER, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_MONK, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_RANGER, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_BARBARIAN, GetPCSpeaker()) >= 1))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
