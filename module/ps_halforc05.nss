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
        sSay = "Hail "+sSirMadam+" gnome! I am the cobbler for these humans, at the moment, though I can fashion other leather goods."; break;
        case RACIAL_TYPE_HALFLING: case RACIAL_TYPE_DWARF:
        sSay = "Good to see someone of normal height. I have been hired to be a cobbler here, but I am capable of fashioning other goods."; break;
        case RACIAL_TYPE_ELF:
        sSay = "Greetings fellow forest-dweller. Perhaps I could interest you in some leather goods?"; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Could I interest you in some leather goods?"; break;
        case 2:
        sSay = "I am paid by the Viceroy to make boots for the army. But I am capable of fashioning other leather goods for you."; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}
