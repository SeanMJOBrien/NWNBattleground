void main()
{
object oPC =GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
object oMod = GetModule();
string sTeam = IntToString(iTeam);
string sFood =sTeam+"fd";
string sWood = sTeam+"wd";
string sHides = sTeam+"hd";
string sEquip = sTeam+"eq";
string sStone = sTeam+"sn";
string sMsg1 = "<c � >Food: "+IntToString(GetLocalInt(oMod,sFood))+"</c>";
string sMsg2 = "<cڥ#>Wood: "+IntToString(GetLocalInt(oMod,sWood))+"</c>";
string sMsg3 = "<c�� >Hides: "+IntToString(GetLocalInt(oMod,sHides))+"</c>";
string sMsg4 = "<c���>Equipment: "+IntToString(GetLocalInt(oMod,sEquip))+"</c>";
string sMsg5 = "<c���>Stone: "+IntToString(GetLocalInt(oMod,sStone))+"</c>";
DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg1,oPC,FALSE));
DelayCommand(2.0f,FloatingTextStringOnCreature(sMsg2,oPC,FALSE));
DelayCommand(3.0f,FloatingTextStringOnCreature(sMsg3,oPC,FALSE));
DelayCommand(4.0f,FloatingTextStringOnCreature(sMsg4,oPC,FALSE));
DelayCommand(5.0f,FloatingTextStringOnCreature(sMsg5,oPC,FALSE));
}
