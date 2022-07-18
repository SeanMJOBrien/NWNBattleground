#include "nw_i0_generic"
void main()
{
    object oEnemy;
    int iTeam = GetLocalInt(OBJECT_SELF,"team");
    if (iTeam==1) oEnemy = GetObjectByTag("evilmanapool");
    if (iTeam==2) oEnemy = GetObjectByTag("goodmanapool");
    if (oEnemy!=OBJECT_INVALID)
        {
        ActionAttack(oEnemy);
        return;
        }

}
