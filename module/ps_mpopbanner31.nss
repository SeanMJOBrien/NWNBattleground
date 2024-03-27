void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(OBJECT_SELF,"WPCount",GetLocalInt(OBJECT_SELF,"WPCount")+1);
//SendMessageToPC(GetPCSpeaker(),"nWPCount= "+IntToString(GetLocalInt(OBJECT_SELF,"WPCount")));

}
