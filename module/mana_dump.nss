void main()
{
object oPC = GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
int iMana = GetLocalInt(oPC,"mana");
string sTeam = IntToString(iTeam);
object oMod = GetModule();
int iCMana = GetLocalInt(oMod,sTeam+"mana");
string sMana = IntToString(iMana);

if (iMana<1)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have any Mana.</c>",oPC,0);
        return;
        }

string sXP = IntToString(iMana*5);
FloatingTextStringOnCreature("<c þ >You add "+sMana+" mana to you team's mana pool. +"+sXP+" XP</c>",oPC,0);
SetLocalInt(oMod,sTeam+"mana",iCMana+iMana);
SetLocalInt(oPC,"mana",0);
GiveXPToCreature(oPC,iMana*5);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+iMana);
effect eViz = EffectVisualEffect(VFX_FNF_STRIKE_HOLY,FALSE);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,OBJECT_SELF);
}
