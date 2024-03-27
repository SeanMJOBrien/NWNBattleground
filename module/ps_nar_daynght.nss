void main()
{
object oPC = GetEnteringObject();
string sTag = GetTag(OBJECT_SELF);
string sBuffer;
string sBufferB;

if ((GetIsPC(oPC)) && (!GetLocalInt(OBJECT_SELF,"Deactivate")))
    {
    sBuffer = GetLocalString(oPC,"NARRATION");
    if (TestStringAgainstPattern("**_"+sTag+"**",sBuffer) == FALSE)
        {
        if ((GetIsDawn()) || (GetIsDay()))
            sBufferB = GetLocalString(OBJECT_SELF,"NARRATION_DAY");
        else if ((GetIsDusk()) || (GetIsNight()))
            sBufferB = GetLocalString(OBJECT_SELF,"NARRATION_NIGHT");
        SendMessageToPC(oPC,sBufferB);
        sBuffer = sBuffer + "_" + sTag;
        SetLocalString(oPC,"NARRATION",sBuffer);
        }
    }
}
