int StartingConditional()
{
string sSay;
object oPC = GetPCSpeaker();
string sSirMadam;
if (GetGender(oPC) == GENDER_FEMALE) sSirMadam = "sister";
else sSirMadam = "brother";
if (GetRacialType(oPC) != RACIAL_TYPE_HUMAN)
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING: case RACIAL_TYPE_DWARF:
        sSay = "Hello, little one."; break;
        case RACIAL_TYPE_ELF:
        sSay = "It is an honor to be able to serve one of Boccob's chosen."; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "What do you require?"; break;
        case 2:
        sSay = "Yes?"; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;

int nClass1 = GetClassByPosition(1,oPC);
int nClass2 = GetClassByPosition(2,oPC);
int nClass3 = GetClassByPosition(3,oPC);
if ((nClass1 == CLASS_TYPE_WIZARD) || (nClass2 == CLASS_TYPE_WIZARD) || (nClass3 == CLASS_TYPE_WIZARD) ||
    (nClass1 == CLASS_TYPE_SORCERER) || (nClass2 == CLASS_TYPE_SORCERER) || (nClass3 == CLASS_TYPE_SORCERER) ||
    (nClass1 == CLASS_TYPE_BARD) || (nClass2 == CLASS_TYPE_BARD) || (nClass3 == CLASS_TYPE_BARD))
    return TRUE;
return FALSE;

}
