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
        case RACIAL_TYPE_GNOME:
        case RACIAL_TYPE_HALFLING: case RACIAL_TYPE_DWARF:
        sSay = "Greetings, short one. I am the Viceroy's bowyer."; break;
        case RACIAL_TYPE_ELF:
        sSay = "Hello fair elf, I am the local bowyer."; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Might you be interested in a bow, crossbow or ammunition?"; break;
        case 2:
        sSay = "G'day."; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}
