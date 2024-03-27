void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(OBJECT_SELF,"SeedStr",50);
int nPointer = GetLocalInt(OBJECT_SELF,"PopPointer");

string sPops = GetLocalString(GetModule(),"POPS");
SendMessageToPC(oPC,sPops);
SetCustomToken(416,GetSubString(sPops,(nPointer),4));
SetCustomToken(412,GetSubString(sPops,(nPointer+5),4));
SetCustomToken(413,GetSubString(sPops,(nPointer+10),4));
SetCustomToken(414,GetSubString(sPops,(nPointer+15),4));
SetCustomToken(415,GetSubString(sPops,(nPointer+20),4));
}
