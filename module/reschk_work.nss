void main()
{
object oPC =GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
object oMod = GetModule();
string sTeam = IntToString(iTeam);
string sFarmers =sTeam+"fm";
string sWoods = sTeam+"lj";
string sMiners = sTeam+"mn";
string sCrafts = sTeam+"cm";
string sHunt = sTeam+"ht";
string sStonec = sTeam+"sc";
string sPop = sTeam+"pop";
string sPopMax = sTeam+"popmax";
string sFarmmax = IntToString(GetLocalInt(oMod,sTeam+"fmmax"));
string sLJmax = IntToString(GetLocalInt(oMod,sTeam+"ljmax"));
string sMinermax = IntToString(GetLocalInt(oMod,sTeam+"mnmax"));
string sCMmax = IntToString(GetLocalInt(oMod,sTeam+"cmmax"));
string sHuntmax = IntToString(GetLocalInt(oMod,sTeam+"htmax"));
string sSCmax = IntToString(GetLocalInt(oMod,sTeam+"scmax"));
string sMsg1 = "<c þ >Farmers: "+IntToString(GetLocalInt(oMod,sFarmers))+" out of "+sFarmmax+"</c>";
string sMsg2 = "<cÚ¥#>Woodcutters: "+IntToString(GetLocalInt(oMod,sWoods))+" out of "+sLJmax+"</c>";
string sMsg3 = "<c¥¥¥>Miners: "+IntToString(GetLocalInt(oMod,sMiners))+" out of "+sMinermax+"</c>";
string sMsg4 = "<cþþ >Craftsmen: "+IntToString(GetLocalInt(oMod,sCrafts))+" out of "+sCMmax+"</c>";
string sMsg5 = "<cþ  >Hunters: "+IntToString(GetLocalInt(oMod,sHunt))+" out of "+sHuntmax+"</c>";
string sMsg7 = "<cŒŒŒ>Stonecutters: "+IntToString(GetLocalInt(oMod,sStonec))+" out of "+sSCmax+"</c>";
string sMsg6 = "<c þþ>Population: "+IntToString(GetLocalInt(oMod,sPop))+" out of "+IntToString(GetLocalInt(oMod,sPopMax))+".</c>";
DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg1,oPC,FALSE));
DelayCommand(2.0f,FloatingTextStringOnCreature(sMsg2,oPC,FALSE));
DelayCommand(3.0f,FloatingTextStringOnCreature(sMsg3,oPC,FALSE));
DelayCommand(4.0f,FloatingTextStringOnCreature(sMsg4,oPC,FALSE));
DelayCommand(5.0f,FloatingTextStringOnCreature(sMsg5,oPC,FALSE));
DelayCommand(6.0f,FloatingTextStringOnCreature(sMsg7,oPC,FALSE));
DelayCommand(7.0f,FloatingTextStringOnCreature(sMsg6,oPC,FALSE));
}
