// I am not casting spells during melee

#include "hench_i0_conv"

int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(OBJECT_SELF,sHenchDontCastMelee);
    return iResult;
}
