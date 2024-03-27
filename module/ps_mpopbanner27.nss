void main()
{
object oPC = GetPCSpeaker();
DeleteLocalString(GetObjectByTag("MPOP",GetLocalInt(OBJECT_SELF,"WPCount")),"GROWTH");
}
