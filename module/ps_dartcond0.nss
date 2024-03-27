// A conditional in the dartboard's conversation

int StartingConditional()
{
int iCounter = GetLocalInt(GetArea(OBJECT_SELF),"iDartGame");
if (iCounter == 0) return TRUE;
    else return FALSE;
}
