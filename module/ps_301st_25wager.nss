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
    if (GetGold(oScan) < 25)
        {
        SpeakString(GetName(oScan)+" cannot afford the wager and is being dropped from the player queue.");
        for (iDiff = iCounter; iDiff < 8; iDiff ++)
            {
            if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iDiff)) == OBJECT_INVALID) break;
            SetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iDiff),GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iDiff+1)));
            }
        iCounter = iCounter -1;
        }
    if (GetGold(oScan) >= 25)
        {
        TakeGoldFromCreature(25,oScan,TRUE);
        SetLocalInt(GetArea(OBJECT_SELF),"iPotSize",GetLocalInt(GetArea(OBJECT_SELF),"iPotSize")+25);
        }
    }
if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer1") == OBJECT_INVALID)
    {
    SpeakString("There are no players left in the queue. The game is aborted.");
    return;
    }

SpeakString("A game of 301 is beginning. "+GetName(GetLocalObject(GetArea(OBJECT_SELF),"oPlayer1"))+" is up. The pot is "+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iPotSize"))+" gold pieces.");
SetLocalInt(GetArea(OBJECT_SELF),"iDartGame",1);

}
