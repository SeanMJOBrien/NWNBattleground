void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<250)
    {
    FloatingTextStringOnCreature("<c�  >Not enough gold.</c>",oPC,0);
    return;
    }
int iFood = GetLocalInt(oMod,sTeam+"fd");
if (iFood<5)
    {
    FloatingTextStringOnCreature("<c�  >Requires 5 Food.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<1)
    {
    FloatingTextStringOnCreature("<c�  >Requires 1 unit of Equipment.</c>",oPC,0);
    return;
    }
int iMith = GetLocalInt(oMod,sTeam+"mt");
if (iMith<2)
    {
    FloatingTextStringOnCreature("<c�  >Requires 1 unit of Mithril.</c>",oPC,0);
    return;
    }
int iSteel = GetLocalInt(oMod,sTeam+"st");
if (iSteel<3)
    {
    FloatingTextStringOnCreature("<c�  >Requires 1 units of Steel.</c>",oPC,0);
    return;
    }
int iMana = GetLocalInt(oPC,"mana");
if (iMana<10)
    {
    FloatingTextStringOnCreature("<c�  >That order requires 10 Mana to carry out.</c>",oPC,0);
    return;
    }
int iPop = GetLocalInt(oMod,sTeam+"pop");
int iMaxpop = GetLocalInt(oMod,sTeam+"popmax");
if (iPop>=iMaxpop)
    {
    FloatingTextStringOnCreature("<c�  >Your population is too high.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_good";
else sGE="_evil";
CreateObject(OBJECT_TYPE_CREATURE,"wizard"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(250,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-5);
SetLocalInt(oMod,sTeam+"eq",iEquip-1);
SetLocalInt(oMod,sTeam+"mt",iMith-1);
SetLocalInt(oMod,sTeam+"st",iSteel-1);
SetLocalInt(oPC,"mana",iMana-10);
GiveXPToCreature(oPC,30);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+3);
}
