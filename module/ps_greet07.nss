void main()
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
}
