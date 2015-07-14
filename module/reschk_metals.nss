void main()
{
object oPC =GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
object oMod = GetModule();
string sTeam = IntToString(iTeam);
string sIron =sTeam+"ir";
string sSteel = sTeam+"st";
string sCopper = sTeam+"cp";
string sAdam = sTeam+"ad";
string sMith = sTeam+"mt";
string sMsg1 = "<cþŒ >Copper: "+IntToString(GetLocalInt(oMod,sCopper))+"</c>";
string sMsg2 = "<cŒŒŒ>Iron: "+IntToString(GetLocalInt(oMod,sIron))+"</c>";
string sMsg3 = "<c¥¥¥>Steel: "+IntToString(GetLocalInt(oMod,sSteel))+"</c>";
string sMsg4 = "<c  ¥>Mithril: "+IntToString(GetLocalInt(oMod,sMith))+"</c>";
string sMsg5 = "<c   >Adamantine: "+IntToString(GetLocalInt(oMod,sAdam))+"</c>";
DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg1,oPC,FALSE));
DelayCommand(2.0f,FloatingTextStringOnCreature(sMsg2,oPC,FALSE));
DelayCommand(3.0f,FloatingTextStringOnCreature(sMsg3,oPC,FALSE));
DelayCommand(4.0f,FloatingTextStringOnCreature(sMsg4,oPC,FALSE));
DelayCommand(5.0f,FloatingTextStringOnCreature(sMsg5,oPC,FALSE));
}
