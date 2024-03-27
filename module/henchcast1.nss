// I am casting spells even during melee

#include "hench_i0_conv"

int StartingConditional()
{
    int iResult;

    iResult = 1-GetLocalInt(OBJECT_SELF,sHenchDontCastMelee);
    return iResult;
}
