#include "hench_i0_generic"


int HenchTalentSummonAllies(int nForce = FALSE)
{
    talent tUse;

    if(!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED))
        && (nForce || !GetLocalInt(OBJECT_SELF, sHenchDontSummon)))
    {
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
        if(GetIsTalentValid(tUse))
        {
            ClearAllActions();
            
            object oRealMaster = GetRealMaster();
            //This is for henchmen wizards, so they do no run off and get killed
            //summoning in allies.
            if(GetIsObjectValid(oRealMaster))
            {
                ActionUseTalentAtLocation(tUse, GetLocation(oRealMaster));
            }
            else
            {
                ActionUseTalentAtLocation(tUse, GetLocation(OBJECT_SELF));
            }
            return TRUE;
        }
    }
    return FALSE;
}


void main()
{
    HenchTalentSummonAllies(TRUE);
}
