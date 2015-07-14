void main()
{
object oPC = GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
int iMana = GetLocalInt(oPC,"mana");
string sTeam = IntToString(iTeam);
object oMod = GetModule();
int iCMana = GetLocalInt(oMod,sTeam+"mana");

if (iMana<5)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Mana to do that.</c>",oPC,0);
        return;
        }

FloatingTextStringOnCreature("<c þ >You add 5 mana to you team's mana pool. +25 XP</c>",oPC,0);
SetLocalInt(oMod,sTeam+"mana",iCMana+5);
SetLocalInt(oPC,"mana",iMana-5);
GiveXPToCreature(oPC,25);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+5);
}
