#include "_include_main"
void main()
{
object oPC = GetLastDamager(OBJECT_SELF);
int iDamage = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
string sDamage = IntToString(iDamage);
object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (GetIsMeleeWeapon(oWep)==FALSE)
    {
    SendColorMessage(oPC,1,"This is for practicing melee combat.");
    return;
    }
if (iDamage<=0) return;
if (iDamage >= 10 && iDamage<=19)
    {
    DelayCommand(1.0f,SendColorMessage(oPC,2,"A solid hit. 5 XP bonus awarded."));
    GiveXPToCreature(oPC,5);
    }
if (iDamage >= 20 && iDamage<=29)
    {
    DelayCommand(1.0f,SendColorMessage(oPC,2,"A crippling hit. 10 XP bonus awarded."));
    GiveXPToCreature(oPC,10);
    }
if (iDamage >= 30 && iDamage<=39)
    {
    DelayCommand(1.0f,SendColorMessage(oPC,2,"A deadly hit. 15 XP bonus awarded."));
    GiveXPToCreature(oPC,15);
    }
if (iDamage >= 40)
    {
    DelayCommand(1.0f,SendColorMessage(oPC,2,"A devastating hit. 20 XP bonus awarded."));
    GiveXPToCreature(oPC,20);
    }
int iXP = 5;
string sXP = IntToString(iXP);
GiveXPToCreature(oPC,iXP);
SendColorMessage(oPC,2,sXP+" XP earned.");
}
