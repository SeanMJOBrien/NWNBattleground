void main()
{
string sName = GetName(OBJECT_SELF);
string sHP = IntToString(GetCurrentHitPoints(OBJECT_SELF));
SpeakString("The "+sName+" is under attack! HP = "+sHP,TALKVOLUME_SHOUT);
}
