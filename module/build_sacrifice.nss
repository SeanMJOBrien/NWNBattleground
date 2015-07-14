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
int iIron = GetLocalInt(oMod,sTeam+"ir");
if (iIron<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 Iron.</c>",oPC,0);
    return;
    }
int iWood = GetLocalInt(oMod,sTeam+"wd");
if (iWood<2)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 2 Wood.</c>",oPC,0);
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
int iHas = GetLocalInt(oMod,sGE+"sacbraz");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_sacbraz"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"sacrifice",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
AssignCommand(oPC,TakeGoldFromCreature(200,oPC,1));
SetLocalInt(oMod,sTeam+"ir",iIron-3);
SetLocalInt(oMod,sTeam+"wd",iWood-2);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"sacbraz",1);
FloatingTextStringOnCreature("<c þ >A sacrificial brazier is built near the workshop. +1 Score +50 XP.</c>",oPC,0);
}
