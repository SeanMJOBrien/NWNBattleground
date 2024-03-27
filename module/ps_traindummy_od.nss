void main()
{
object oPC = GetLastDamager(OBJECT_SELF);
int nPoints = GetLocalInt(oPC, "TrainXP");
int nLimit = GetHitDice(oPC) * 50;
int nDamage = GetTotalDamageDealt() * 2;
if ((nPoints + nDamage) <= nLimit)
    {
    GiveXPToCreature(oPC, nDamage);
    SetLocalInt(oPC,"TrainXP",(nPoints+nDamage));
    }
else if (((nPoints + nDamage) > nLimit) &&
      (nPoints < nLimit))
    {
    nDamage = nLimit - nPoints;
    GiveXPToCreature(oPC, nDamage);
    SetLocalInt(oPC,"TrainXP",(nPoints+nDamage));
    }
}
