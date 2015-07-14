void main()
{
object oPC =GetPCSpeaker();
int iTeam = GetLocalInt(oPC,"team");
object oMod = GetModule();
string sTeam = IntToString(iTeam);
string sState = sTeam+"foundry";
int iState = GetLocalInt(oMod,sState);
string sMsg1 = "<c þ >The foundry is ON.</c>";
string sMsg2 = "<cþ  >The foundry is OFF.</c>";
if (iState==1) DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg1,oPC,FALSE));
else DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg2,oPC,FALSE));
}
