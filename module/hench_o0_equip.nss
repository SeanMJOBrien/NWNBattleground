#include "hench_i0_equip"


void main()
{
    if (!HenchEquipAppropriateWeapons(OBJECT_SELF, -5., TRUE, GetHasEffect(EFFECT_TYPE_POLYMORPH)))
    {
        ActionDoCommand(ActionContinueEquip(OBJECT_SELF, TRUE, 2));
    }
}
