#include "nw_i0_generic"
void main()
{
//if (GetIsInCombat(OBJECT_SELF)==FALSE) return;
object oEnemy = GetNearestEnemy(OBJECT_SELF,1);
//if (oEnemy==OBJECT_INVALID) return;
//if (GetDistanceToObject(oEnemy)>30.0f) return;
AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_MAGIC_MISSILE,oEnemy));
}
