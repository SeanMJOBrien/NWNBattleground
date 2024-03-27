int StartingConditional()
{
object oPC = GetPCSpeaker();
int nClass1 = GetClassByPosition(1,oPC);
int nClass2 = GetClassByPosition(2,oPC);
int nClass3 = GetClassByPosition(3,oPC);
if ((nClass1 == CLASS_TYPE_WIZARD) || (nClass2 == CLASS_TYPE_WIZARD) || (nClass3 == CLASS_TYPE_WIZARD) ||
    (nClass1 == CLASS_TYPE_BARD) || (nClass2 == CLASS_TYPE_BARD) || (nClass3 == CLASS_TYPE_BARD) ||
    (nClass1 == CLASS_TYPE_SORCERER) || (nClass2 == CLASS_TYPE_SORCERER) || (nClass3 == CLASS_TYPE_SORCERER))
    return TRUE;
return FALSE;
}
