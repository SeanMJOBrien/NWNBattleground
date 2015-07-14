void main()
{
object oPC = GetLastUnlocked();
int iDC = GetLockUnlockDC(OBJECT_SELF);
int iHD = GetHitDice(oPC);
int iXP = iDC+iHD+d6();
GiveXPToCreature(oPC,iXP);
}
