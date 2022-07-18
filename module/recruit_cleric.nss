void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<100)
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
int iHide = GetLocalInt(oMod,sTeam+"hd");
if (iHide<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 1 Hide.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<4)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 4 units of Equipment.</c>",oPC,0);
    return;
    }
int iSteel = GetLocalInt(oMod,sTeam+"st");
if (iSteel<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 1 unit of Steel.</c>",oPC,0);
    return;
    }
int iIron = GetLocalInt(oMod,sTeam+"ir");
if (iIron<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 1 unit of Iron.</c>",oPC,0);
    return;
    }
int iDF = GetLocalInt(oPC,"df");
if (iDF<25)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 25 Divine Favor to carry out.</c>",oPC,0);
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
CreateObject(OBJECT_TYPE_CREATURE,"cleric"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(100,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-5);
SetLocalInt(oMod,sTeam+"hd",iHide-1);
SetLocalInt(oMod,sTeam+"eq",iEquip-4);
SetLocalInt(oMod,sTeam+"st",iSteel-1);
SetLocalInt(oMod,sTeam+"ir",iIron-1);
SetLocalInt(oPC,"df",iDF-25);
GiveXPToCreature(oPC,20);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+2);
}
