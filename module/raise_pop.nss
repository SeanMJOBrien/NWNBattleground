void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);

int iFood = GetLocalInt(oMod,sTeam+"fd");
if (iFood<30)
    {
    FloatingTextStringOnCreature("<cþ  >Requires 30 Food.</c>",oPC,0);
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
if (iMaxpop>=50)
    {
    FloatingTextStringOnCreature("<cþ  >You may not raise your population limit any higher.</c>",oPC,0);
    return;
    }
SetLocalInt(oMod,sTeam+"fd",iFood-30);
SetLocalInt(oPC,"cp",iCP-10);
GiveXPToCreature(oPC,25);
SetLocalInt(oMod,sTeam+"popmax",iMaxpop+1);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"score",iRank+1);
FloatingTextStringOnCreature("You have increased your maximum population. +25 XP and +1 Score.",oPC,0);
}
