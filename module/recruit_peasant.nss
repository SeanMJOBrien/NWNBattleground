void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<10)
    {
    FloatingTextStringOnCreature("<cþ  >Not enough gold.</c>",oPC,0);
    return;
    }
int iFood = GetLocalInt(oMod,sTeam+"fd");
if (iFood<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 Food.</c>",oPC,0);
    return;
    }
int iHide = GetLocalInt(oMod,sTeam+"hd");
if (iHide<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires a Hide.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<1)
    {
    FloatingTextStringOnCreature("<cþ  >Requires a unit of Equipment.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<5)
    {
    FloatingTextStringOnCreature("<cþ  >That order requires 5 Command Points to carry out.</c>",oPC,0);
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
CreateObject(OBJECT_TYPE_CREATURE,"peasant"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(10,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-3);
SetLocalInt(oMod,sTeam+"hd",iHide-1);
SetLocalInt(oMod,sTeam+"eq",iEquip-1);
SetLocalInt(oPC,"cp",iCP-5);
GiveXPToCreature(oPC,10);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
}
