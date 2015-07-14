void main()
{
object oPC = GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
int iMana = GetLocalInt(oPC,"mana");
string sTeam = IntToString(iTeam);
object oMod = GetModule();
int iCMana = GetLocalInt(oMod,sTeam+"mana");

if (iMana<10)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Mana to do that.</c>",oPC,0);
        return;
        }

FloatingTextStringOnCreature("<c þ >You add 10 mana to you team's mana pool. +50 XP</c>",oPC,0);
SetLocalInt(oMod,sTeam+"mana",iCMana+10);
SetLocalInt(oPC,"mana",iMana-10);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+10);
}
