int StartingConditional()
{
string sSay;
string sMateMiss;
if (GetGender(GetPCSpeaker()) == GENDER_FEMALE) sMateMiss = "miss";
else sMateMiss = "mate";
switch (d8())
    {
    case 1: sSay = "Would'ja take a look at what's in my booth?"; break;
    case 2: sSay = "Lookin' fer bargains, "+sMateMiss+"?"; break;
    case 3: sSay = "If Ralishaz be kind, I'll have what yer lookin' for."; break;
    case 4: sSay = "Please buy something, "+sMateMiss+". I have a wife an' kids back home."; break;
    case 5: sSay = "Bet'cha get a lot of shineys adventuring, eh? Perhaps you might pass some onto me, then?"; break;
    case 6: sSay = "I am just a bloke trying to make an honest living, I am! You might be gracious enough to purchase something."; break;
    case 7: sSay = "Special deals today. A one time offer!"; break;
    case 8: sSay = "I'll tell you, life ain't fair. Me being stuck out in this forsaken borderland."; break;
    }
if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC)
    switch (d4())
        {
        case 1: sSay = "Is that a grin or are you thinking of eating me?"; break;
        case 2: sSay = "I though I smelled something..."; break;
        case 3: sSay = "A miserable lot it is to be dealing with the likes of you."; break;
        case 4: sSay = "What I put up with to pay the landlord *sigh*..."; break;
        }
SetCustomToken(330,sSay);
//if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC) return FALSE;
return TRUE;
}