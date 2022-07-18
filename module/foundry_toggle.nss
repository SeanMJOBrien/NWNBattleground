void main()
{
object oPC = GetLastUsedBy();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sVar = IntToString(iTeam)+"foundry";
int iCP = GetLocalInt(oPC,"cp");
if (iCP<1)
    {
    FloatingTextStringOnCreature("<cþ  >You need 1 CP to give this order.</c>",oPC,FALSE);
    return;
    }
int iState = GetLocalInt(oMod,sVar);
if (iState==1)
    {
    FloatingTextStringOnCreature("<c þ >You turn the foundry off.</c>",oPC,FALSE);
    SetLocalInt(oMod,sVar,0);
    SetLocalInt(oPC,"cp",iCP-1);
    return;
    }
if (iState==0)
    {
    FloatingTextStringOnCreature("<c þ >You turn the foundry on.</c>",oPC,FALSE);
    SetLocalInt(oMod,sVar,1);
    SetLocalInt(oPC,"cp",iCP-1);
    return;
    }
}
