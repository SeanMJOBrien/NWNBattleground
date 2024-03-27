int StartingConditional()
{
object oPC = GetPCSpeaker();
int nClass1 = GetClassByPosition(1,oPC);
int nClass2 = GetClassByPosition(2,oPC);
int nClass3 = GetClassByPosition(3,oPC);
if ((nClass1 == CLASS_TYPE_ROGUE) || (nClass2 == CLASS_TYPE_ROGUE) || (nClass3 == CLASS_TYPE_ROGUE) ||
    (nClass1 == CLASS_TYPE_BARD) || (nClass2 == CLASS_TYPE_BARD) || (nClass3 == CLASS_TYPE_BARD))
    return TRUE;
return FALSE;

}
