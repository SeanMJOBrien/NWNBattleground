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
        case RACIAL_TYPE_ELF: case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING: case RACIAL_TYPE_DWARF:
        sSay = "Hello, strange one."; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Greetings, I am the proprietor of this warehouse. What do you need"; break;
        case 2:
        sSay = "What can I do for you?"; break;
        }
    }
SetCustomToken(350,sSay);
}
