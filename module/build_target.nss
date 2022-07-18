void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<100)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough gold.</c>",oPC,0);
    return;
    }
int iWood = GetLocalInt(oMod,sTeam+"wd");
if (iWood<2)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 2 Wood.</c>",oPC,0);
    return;
    }
int iHides = GetLocalInt(oMod,sTeam+"hd");
if (iHides<5)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 5 Hides.</c>",oPC,0);
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
int iHas = GetLocalInt(oMod,sGE+"special2");
if (iHas==1)
    {
    FloatingTextStringOnCreature("<cþ  >That has already been built.</c>",oPC,0);
    return;
    }
string sWP = "wp_arch"+sGE;
object oWP = GetWaypointByTag(sWP);
object oBuild = CreateObject(OBJECT_TYPE_PLACEABLE,"special2",GetLocation(oWP));
SetLocalInt(oBuild,"ignore",1);
AssignCommand(oPC,TakeGoldFromCreature(100,oPC,1));
SetLocalInt(oMod,sTeam+"wd",iWood-2);
SetLocalInt(oMod,sTeam+"hd",iHides-5);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,50);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
SetLocalInt(oMod,sGE+"archtarg",1);
FloatingTextStringOnCreature("<c þ >An archery target is built near the hunt camp. +1 Score +50 XP.</c>",oPC,0);
}
