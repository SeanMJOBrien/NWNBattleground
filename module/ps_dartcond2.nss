// A conditional in the dartboard's conversation

int StartingConditional()
{
int iCounter = GetLocalInt(GetArea(GetPCSpeaker()),"iDartGame");
if (iCounter == 2) return TRUE;
    else return FALSE;
}
