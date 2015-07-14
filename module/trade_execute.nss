void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int iTeam = GetLocalInt(oPC,"team");
string sTeam = IntToString(iTeam);
string sTrdGet = GetLocalString(OBJECT_SELF,"tradefor");
string sTrdGive = GetLocalString(OBJECT_SELF,"tradegive");
string sGive;
string sGet;
//get give resource amt
if (sTrdGive=="iron") sGive=sTeam+"ir";
else if (sTrdGive=="wood") sGive=sTeam+"wd";
else if (sTrdGive=="hides") sGive=sTeam+"hd";
else if (sTrdGive=="steel") sGive=sTeam+"st";
else if (sTrdGive=="stone") sGive=sTeam+"sn";
else if (sTrdGive=="copper") sGive=sTeam+"cp";
else if (sTrdGive=="equipment") sGive=sTeam+"eq";
int iGive = GetLocalInt(oMod,sGive);
if (iGive<3)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough "+sTrdGive+".</c>",oPC,0);
    return;
    }
//check CP and reduce if good
int iCP = GetLocalInt(oPC,"cp");
if (iCP<5)
    {
    FloatingTextStringOnCreature("<cþ  >You do not have enough CP to make the trade.</c>",oPC,0);
    return;
    }
SetLocalInt(oPC,"cp",iCP-5);
//get trade get resource
if (sTrdGet=="iron") sGet=sTeam+"ir";
else if (sTrdGet=="wood") sGet=sTeam+"wd";
else if (sTrdGet=="hides") sGet=sTeam+"hd";
else if (sTrdGet=="steel") sGet=sTeam+"st";
else if (sTrdGet=="stone") sGet=sTeam+"sn";
else if (sTrdGet=="copper") sGet=sTeam+"cp";
else if (sTrdGet=="equipment") sGet=sTeam+"eq";
else if (sTrdGet=="food") sGet=sTeam+"fd";
int iGet = GetLocalInt(oMod,sGet);
SetLocalInt(oMod,sGive,iGive-3);
SetLocalInt(oMod,sGet,iGet+1);
FloatingTextStringOnCreature("You trade 3 "+sTrdGive+" for a unit of "+sTrdGet+". +20 XP.",oPC,0);
GiveXPToCreature(oPC,20);
}
