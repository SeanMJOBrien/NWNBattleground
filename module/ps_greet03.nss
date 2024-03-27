void main()
{
string sSay;
object oPC = GetPCSpeaker();
string sSirMadam;
if (GetGender(oPC) == GENDER_FEMALE) sSirMadam = "mistress";
else sSirMadam = "master";
if (GetRacialType(oPC) != RACIAL_TYPE_HUMAN)
    {
    switch (GetRacialType(oPC))
        {
        case RACIAL_TYPE_GNOME: case RACIAL_TYPE_HALFLING:
        sSay = "I apologize young "+sSirMadam+", but I am sold out of fresh bread. I can still sell you a biscuit for 3 gold."; break;
        case RACIAL_TYPE_DWARF:
        sSay = "G'day. No more bread for today, but I have biscuits for 3 gold."; break;
        case RACIAL_TYPE_ELF:
        sSay = "Hail noble elf! I'm all out of bread for today but I have bisuits for 3 gold."; break;
        }
    }
else
    {
    switch (d2())
        {
        case 1:
        sSay = "I apologize but I sold out of fresh bread by noon. I still have biscuits of hard tac for 3 gold pieces, though."; break;
        case 2:
        sSay = "Though there is no more fresh bread today, I still have a barrel of hard tac biscuits to sell. They are 3 gold a piece."; break;
        }
    }
SetCustomToken(350,sSay);
}
