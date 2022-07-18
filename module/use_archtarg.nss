#include "_include_main"
void main()
{
object oPC = GetLastDamager(OBJECT_SELF);
int iDamage = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
string sDamage = IntToString(iDamage);
object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (iDamage<=0) return;
if (GetIsMeleeWeapon(oWep)==TRUE)
    {
    SendColorMessage(oPC,1,"This is for practicing ranged combat.");
    return;
    }
if (iDamage>=6)
    {
    DelayCommand(1.0f,SendColorMessage(oPC,2,"Bullseye! 20 XP bonus awarded."));
    GiveXPToCreature(oPC,5);
    }
int iXP = 5;
string sXP = IntToString(iXP);
GiveXPToCreature(oPC,iXP);
SendColorMessage(oPC,2,sXP+" XP earned.");
}
