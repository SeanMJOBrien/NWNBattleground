void main()
{
object oPC = GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
int iMana = GetLocalInt(oPC,"mana");
string sTeam = IntToString(iTeam);
object oMod = GetModule();
int iCMana = GetLocalInt(oMod,sTeam+"mana");

if (iMana<1)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Mana to do that.</c>",oPC,0);
        return;
        }

FloatingTextStringOnCreature("<c þ >You add 1 mana to you team's mana pool. +5 XP</c>",oPC,0);
SetLocalInt(oMod,sTeam+"mana",iCMana+1);
SetLocalInt(oPC,"mana",iMana-1);
GiveXPToCreature(oPC,5);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
}
