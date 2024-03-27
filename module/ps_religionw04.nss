void main()
{
string sDeity = "Boccob";
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"ReligionTarget");
SetDeity(oTarget, sDeity);
SendMessageToPC(oPC, "Target's deity set to "+sDeity+".");
}
