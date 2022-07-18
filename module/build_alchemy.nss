void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<200)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough gold.</c>",oPC,0);
    return;
    }
int iMana = GetLocalInt(oPC,"mana");
if (iMana<10)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough Mana.</c>",oPC,0);
    return;
    }
int iWood = GetLocalInt(oMod,sTeam+"wd");
if (iWood<10)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 10 Wood.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<10)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 10 Command Points to carry out.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_g";
else sGE="_e";
int iHas = GetLocalInt(oMod,sGE+"alch");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_alch"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"container9",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
AssignCommand(oPC,TakeGoldFromCreature(200,oPC,1));
SetLocalInt(oMod,sTeam+"wd",iWood-5);
SetLocalInt(oPC,"mana",iMana-10);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"alch",1);
FloatingTextStringOnCreature("<c þ >An alchemy bench is built near the workshop. +1 Score +50 XP.</c>",oPC,0);
}
