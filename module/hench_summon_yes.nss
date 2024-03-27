// Auldar: Check if we haven't asked the associate to stop summoning

#include "hench_i0_conv"


int StartingConditional()
{
    return !GetLocalInt(OBJECT_SELF, sHenchDontSummon);
}
