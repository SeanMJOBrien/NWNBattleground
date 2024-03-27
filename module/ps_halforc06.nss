int StartingConditional()
{
string sSay;
object oPC = GetPCSpeaker();
string sSirMadam;
if (GetGender(oPC) == GENDER_FEMALE) sSirMadam = "girl";
else sSirMadam = "boy";
if (GetRacialType(oPC) != RACIAL_TYPE_HUMAN)
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING:
        sSay = "Greetings little "+sSirMadam+"."; break;
        case RACIAL_TYPE_DWARF: case RACIAL_TYPE_ELF:
        sSay = "How may I serve you, oh spirit of Oerth?"; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "May I forge you something?"; break;
        case 2:
        sSay = "G'day!"; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}
