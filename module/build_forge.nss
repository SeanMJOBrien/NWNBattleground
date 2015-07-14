void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<1000)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough gold.</c>",oPC,0);
    return;
    }
int iStone = GetLocalInt(oMod,sTeam+"sn");
if (iStone<20)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 20 Stone.</c>",oPC,0);
    return;
    }
int iIron = GetLocalInt(oMod,sTeam+"ir");
if (iIron<10)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 10 Iron.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<10)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 10 Command Points to carry out.</c>",oPC,0);
    return;
    }
int iMana = GetLocalInt(oPC,"mana");
if (iMana<10)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough Mana.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_g";
else sGE="_e";
int iHas = GetLocalInt(oMod,sGE+"forge");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_forge"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"mysticalforge",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
AssignCommand(oPC,TakeGoldFromCreature(1000,oPC,1));
SetLocalInt(oMod,sTeam+"ir",iIron-10);
SetLocalInt(oMod,sTeam+"sn",iStone-20);
SetLocalInt(oPC,"cp",iCP-10);
SetLocalInt(oPC,"mana",iMana-10);
GiveXPToCreature(oPC,200);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+5);
SetLocalInt(oMod,sGE+"forge",1);
FloatingTextStringOnCreature("<c þ >A mystic forge is built near the workshop. +5 Score +200 XP.</c>",oPC,0);
}
