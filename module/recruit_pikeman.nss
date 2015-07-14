void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<100)
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
int iHide = GetLocalInt(oMod,sTeam+"hd");
if (iHide<4)
    {
    FloatingTextStringOnCreature("<c�  >Requires 4 Hides.</c>",oPC,0);
    return;
    }
int iWood = GetLocalInt(oMod,sTeam+"wd");
if (iWood<2)
    {
    FloatingTextStringOnCreature("<c�  >Requires 2 Wood.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<2)
    {
    FloatingTextStringOnCreature("<c�  >Requires 2 units of Equipment.</c>",oPC,0);
    return;
    }
int iIron = GetLocalInt(oMod,sTeam+"ir");
if (iIron<1)
    {
    FloatingTextStringOnCreature("<c�  >Requires 1 unit of Iron.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<15)
    {
    FloatingTextStringOnCreature("<c�  >That order requires 15 Command Points to carry out.</c>",oPC,0);
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
CreateObject(OBJECT_TYPE_CREATURE,"pikeman"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(100,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-5);
SetLocalInt(oMod,sTeam+"hd",iHide-4);
SetLocalInt(oMod,sTeam+"eq",iEquip-2);
SetLocalInt(oMod,sTeam+"ir",iIron-1);
SetLocalInt(oPC,"cp",iCP-15);
GiveXPToCreature(oPC,20);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+2);
}