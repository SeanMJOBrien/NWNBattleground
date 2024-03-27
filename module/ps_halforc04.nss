int StartingConditional()
{
string sSay;
object oPC = GetPCSpeaker();
string sSirMadam;
if (GetGender(oPC) == GENDER_FEMALE) sSirMadam = "madam";
else sSirMadam = "sir";
if (GetRacialType(oPC) != RACIAL_TYPE_HUMAN)
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING:
        sSay = "How may I be of service, little one?"; break;
        case RACIAL_TYPE_DWARF:
        sSay = "Greetings "+sSirMadam+" dwarf. What can I do for you?"; break;
        case RACIAL_TYPE_ELF:
        sSay = "It is good to see that some elves don't fear the company of humans. How can I help you?"; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "Welcome. I maintain a modest supply of herbs and reagents here, perhaps you'd like me to brew you a potion?"; break;
        case 2:
        sSay = "The Viceroy has ordered a small cache of magical reagents are maintained here to benefit the Crusade."; break;
        }
    }
SetCustomToken(350,sSay);
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}
