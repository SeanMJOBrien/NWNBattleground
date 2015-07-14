void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);

int iStone = GetLocalInt(oMod,sTeam+"sn");
if (iStone<20)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 20 Stone.</c>",oPC,0);
    return;
    }
int iDF = GetLocalInt(oPC,"df");
if (iDF<20)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 20 Divine Favor to carry out.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_g";
else sGE="_e";
int iHas = GetLocalInt(oMod,sGE+"altar");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_altar"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild;
if (iTeam==1) oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"altar_good",GetLocation(oWP));
if (iTeam==2) oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"altar_evil",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
SetLocalInt(oMod,sTeam+"sn",iStone-20);
SetLocalInt(oPC,"df",iDF-20);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"altar",1);
FloatingTextStringOnCreature("<c þ >An altar is built near the temple. +1 Score +50 XP.</c>",oPC,0);
}
