// Auldar: Used to prevent henchmen from summoning in battle

#include "hench_i0_conv"


void main()
{
    SetLocalInt(OBJECT_SELF, sHenchDontSummon, TRUE);
}
