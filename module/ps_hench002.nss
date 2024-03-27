//::///////////////////////////////////////////////
//:: FileName ps_hench002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/29/2005 2:11:53 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF) >= 1)
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_SORCERER, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_WIZARD, OBJECT_SELF) >= 1))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
