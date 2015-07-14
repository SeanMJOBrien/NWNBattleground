void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
int iGP = GetGold(oPC);
if (iGP<50)
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
if (iHide<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 Hides.</c>",oPC,0);
    return;
    }
int iEquip = GetLocalInt(oMod,sTeam+"eq");
if (iEquip<3)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 3 units of Equipment.</c>",oPC,0);
    return;
    }
int iCP = GetLocalInt(oPC,"cp");
if (iCP<10)
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
CreateObject(OBJECT_TYPE_CREATURE,"trader"+sGE,GetLocation(oPC));
AssignCommand(oPC,TakeGoldFromCreature(50,oPC,1));
SetLocalInt(oMod,sTeam+"fd",iFood-5);
SetLocalInt(oMod,sTeam+"hd",iHide-3);
SetLocalInt(oMod,sTeam+"eq",iEquip-3);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,20);
SetLocalInt(oMod,sTeam+"pop",iPop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
}
