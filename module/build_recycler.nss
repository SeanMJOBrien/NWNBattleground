void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<300)
    {
    FloatingTextStringOnCreature("<c�  >You do not have enough gold.</c>",oPC,0);
    return;
    }
int iIron = GetLocalInt(oMod,sTeam+"ir");
if (iIron<2)
    {
    FloatingTextStringOnCreature("<c�  >Requires 2 Iron.</c>",oPC,0);
    return;
    }
int iCopper = GetLocalInt(oMod,sTeam+"cp");
if (iCopper<5)
    {
    FloatingTextStringOnCreature("<c�  >Requires 5 Copper.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<10)
    {
    FloatingTextStringOnCreature("<c�  >That order requires 10 Command Points to carry out.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_g";
else sGE="_e";
int iHas = GetLocalInt(oMod,sGE+"recycler");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<c�  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_recycle"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"recycle",GetLocation(oWP));
SetLocalInt(oBuild,"team",iTeam);
AssignCommand(oPC,TakeGoldFromCreature(300,oPC,1));
SetLocalInt(oMod,sTeam+"ir",iIron-2);
SetLocalInt(oMod,sTeam+"cp",iCopper-5);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"recycler",1);
FloatingTextStringOnCreature("<c � >A gnomish recyclotron is built near the workshop. +1 Score +50 XP.</c>",oPC,0);
}
