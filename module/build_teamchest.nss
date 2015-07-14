void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<20)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough gold.</c>",oPC,0);
    return;
    }
int iWood = GetLocalInt(oMod,sTeam+"ir");
if (iWood<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 Wood.</c>",oPC,0);
    return;
    }
int iCopper = GetLocalInt(oMod,sTeam+"cp");
if (iCopper<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 1 Copper.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<5)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 5 Command Points to carry out.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_g";
else sGE="_e";
int iHas = GetLocalInt(oMod,sGE+"teamchest");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_teambox"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"teamchest",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
AssignCommand(oPC,TakeGoldFromCreature(20,oPC,1));
SetLocalInt(oMod,sTeam+"wd",iWood-3);
SetLocalInt(oMod,sTeam+"cp",iCopper-1);
SetLocalInt(oPC,"cp",iCP-5);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"teamchest",1);
FloatingTextStringOnCreature("<c þ >A chest is built near the temple. +1 Score +50 XP.</c>",oPC,0);
}
