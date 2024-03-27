int StartingConditional()
{
    int nCategory;
    for (nCategory = 1; nCategory <= 16; nCategory++)
    {
        if (GetIsTalentValid(GetCreatureTalentBest(nCategory, 20)))
        {
            return TRUE;
        }
    }
    if (GetIsTalentValid(GetCreatureTalentBest(TALENT_CATEGORY_DRAGONS_BREATH, 20)))
    {
        return TRUE;
    }
    return FALSE;
}
