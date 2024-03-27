int StartingConditional()
{
string sSay;
object oPC = GetPCSpeaker();
string sSirMadam;
if (GetGender(oPC) == GENDER_FEMALE) sSirMadam = "madam";
else sSirMadam = "sir";
if ((GetRacialType(oPC) != RACIAL_TYPE_HUMAN) || (GetRacialType(oPC) != RACIAL_TYPE_HALFORC))
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING:
        sSay = "Hello young"+sSirMadam+", a loaf of fresh bread is 4 gold, and can help you grow up to be big and strong like me. I also have biscuits, 4 gold for a half-dozen."; break;
        case RACIAL_TYPE_DWARF:
        sSay = "Hello "+sSirMadam+" dwarf. Loaves of bread are 4 gold, and bisuits are 4 gold for a half-dozen."; break;
        case RACIAL_TYPE_ELF:
        sSay = "Greetings. Loaves of bread are 4 gold and bisuits are 4 gold for a half-dozen."; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Would you care to buy any of the Viceroy's fresh bread, "+sSirMadam+"? Due to the ongoing strife and warfare, I cannot sell you a loaf for any less than 4 gold pieces. I also have biscuits of hard tac, 4 gold for a half-dozen."; break;
        case 2:
        sSay = "Ah, good. You're here in time for a fresh batch. Loaves of fresh bread are 4 gold, and biscuits of hard tac, 4 gold for a half-dozen."; break;
        }
    }
SetCustomToken(350,sSay);
//if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
if (GetTimeHour() < 11) return TRUE;
return FALSE;
}
