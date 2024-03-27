// returns TRUE if henchman lore skill is better than his master's

int StartingConditional()
{
    object oMaster = GetMaster(OBJECT_SELF);
    int nSwitch = FALSE;
    object oScan = GetFirstItemInInventory(oMaster);
    while (oScan != OBJECT_INVALID)
        {
        if (GetIdentified(oScan) == FALSE)
            {
            nSwitch = TRUE; break;
            }
        oScan = GetNextItemInInventory(oMaster);
        }
    int nHenchmanLore = GetSkillRank(SKILL_LORE, OBJECT_SELF);
    int nMasterLore = GetSkillRank(SKILL_LORE, GetMaster(OBJECT_SELF));

    return ((nHenchmanLore > nMasterLore) && (nSwitch));
}
