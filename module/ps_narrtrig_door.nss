void main()
{
object oPC = GetEnteringObject();
object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
string sBuffer;
if ((GetIsPC(oPC)) && (GetLocalInt(oPC,GetTag(oDoor)+"_NAR") == FALSE))
    {
    if ((GetIsDawn()) || (GetIsDay()))
        SendMessageToPC(oPC,GetLocalString(oDoor,"NAR_DAY"));

    else if ((GetIsDusk()) || (GetIsNight()))
        SendMessageToPC(oPC,GetLocalString(oDoor,"NAR_NIGHT"));
    SetLocalInt(oPC,GetTag(oDoor)+"_NAR",TRUE);
    DelayCommand(30.0,DeleteLocalInt(oPC,GetTag(oDoor)+"_NAR"));
    }
}
