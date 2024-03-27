void main()
{
int iCounter;
int iDiff;
object oScan;
if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer1") == OBJECT_INVALID)
    {
    SpeakString("There are no players in the queue.");
    return;
    }
for (iCounter = 1; iCounter < 9; iCounter ++)
    {
    oScan = GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iCounter));
    if (oScan == OBJECT_INVALID) break;
    SetLocalInt(oScan,"iScore",301);
    }
SpeakString("A game of 301 is beginning. "+GetName(GetLocalObject(GetArea(OBJECT_SELF),"oPlayer1"))+" is up. There is no wager.");
SetLocalInt(GetArea(OBJECT_SELF),"iDartGame",1);

}
