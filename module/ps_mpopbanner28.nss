void main()
{
object oPC = GetPCSpeaker();
string sSetDie = GetLocalString(OBJECT_SELF,"SetDie");
SetLocalString(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")),"GROWTH","1D"+sSetDie);
DeleteLocalString(OBJECT_SELF,"SetDie");
//SendMessageToPC(GetPCSpeaker(),"oMPOP name: "+GetName(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")))+", nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));

}
