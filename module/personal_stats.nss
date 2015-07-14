void main()
{
object oPC =GetPCSpeaker();
object oWidget = GetItemPossessedBy(oPC,"widget");
int iScore = GetLocalInt(oWidget,"score");
string sScore = IntToString(iScore);
int iKills = GetLocalInt(oWidget,"kills");
string sKills = IntToString(iKills);
int iPCKills = GetLocalInt(oWidget,"pks");
string sPCKills = IntToString(iPCKills);
string sCP = IntToString(GetLocalInt(oPC,"cp"));
string sDF = IntToString(GetLocalInt(oPC,"df"));
string sMana = IntToString(GetLocalInt(oPC,"mana"));

string sMsg1 = "Current Score is "+sScore+".";
string sMsg2 = "Number of kills is "+sKills+".";
string sMsg3 = "Number of PC kills is "+sPCKills+".";
string sMsg4 = "<c þ >CP: "+sCP+"</c>";
string sMsg5 = "<c  þ>DF: "+sDF+"</c>";
string sMsg6 = "<cþ þ>Mana: "+sMana+"</c>";

DelayCommand(1.0f,FloatingTextStringOnCreature(sMsg1,oPC,FALSE));
DelayCommand(2.0f,FloatingTextStringOnCreature(sMsg2,oPC,FALSE));
DelayCommand(3.0f,FloatingTextStringOnCreature(sMsg3,oPC,FALSE));
DelayCommand(4.0f,FloatingTextStringOnCreature(sMsg4,oPC,FALSE));
DelayCommand(5.0f,FloatingTextStringOnCreature(sMsg5,oPC,FALSE));
DelayCommand(6.0f,FloatingTextStringOnCreature(sMsg6,oPC,FALSE));
}
