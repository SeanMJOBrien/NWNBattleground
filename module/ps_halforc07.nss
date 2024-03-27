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
        sSay = "What do you want, child?"; break;
        case RACIAL_TYPE_ELF:
        sSay = "Praise be to Rao, an elf! Before you leave can you sprinkle fairy-dust about the place?"; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Well met. I am the Viceroy's tailor."; break;
        case 2:
        sSay = "Aye?"; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}
