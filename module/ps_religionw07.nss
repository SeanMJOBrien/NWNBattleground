void main()
{
string sDeity = "Rao";
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"ReligionTarget");
SetDeity(oTarget, sDeity);
SendMessageToPC(oPC, "Target's deity set to "+sDeity+".");
}
