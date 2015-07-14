void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<1000)
    {
    FloatingTextStringOnCreature("<cþ  >Not enough gold.</c>",oPC,0);
    return;
    }
int iFood = GetLocalInt(oMod,sTeam+"fd");
if (iFood<5)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 5 Food.</c>",oPC,0);
    return;
    }
int iAdam = GetLocalInt(oMod,sTeam+"ad");
if (iAdam<2)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 2 Adamantine.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 units of Equipment.</c>",oPC,0);
    return;
    }
int iSteel = GetLocalInt(oMod,sTeam+"st");
if (iSteel<2)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 1 unit of Steel.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<30)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 10 Command Points to carry out.</c>",oPC,0);
    return;
    }
int iPop = GetLocalInt(oMod,sTeam+"pop");
int iMaxpop = GetLocalInt(oMod,sTeam+"popmax");
if (iPop>=iMaxpop)
    {
    FloatingTextStringOnCreature("<cþ  >Your population is too high.</c>",oPC,0);
    return;
    }
string sGE;
if (iTeam==1) sGE="_good";
else sGE="_evil";
CreateObject(OBJECT_TYPE_CREATURE,"elite"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(1000,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-5);
SetLocalInt(oMod,sTeam+"ad",iAdam-2);
SetLocalInt(oMod,sTeam+"eq",iEquip-3);
SetLocalInt(oMod,sTeam+"st",iSteel-1);
SetLocalInt(oPC,"cp",iCP-30);
GiveXPToCreature(oPC,50);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+5);
}
