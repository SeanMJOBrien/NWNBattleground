void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(OBJECT_SELF,"WPCount",GetLocalInt(OBJECT_SELF,"WPCount")-1);
//SendMessageToPC(GetPCSpeaker(),"oMPOP name: "+GetName(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")))+", nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));
}
