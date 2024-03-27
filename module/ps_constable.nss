int StartingConditional()
{
string sSay;
object oPC = GetPCSpeaker();
int nTopic = GetLocalInt(oPC,"Topic");
int nEntry = GetLocalInt(oPC,"Entry");

if ((nTopic == 0) && (nEntry != 0))
    {
    nEntry = 0;
    DeleteLocalInt(oPC,"Entry");
    }
if (nTopic == 0)
    {
    nTopic = d4();
    SetLocalInt(oPC,"Topic",nTopic);
    }
if ((nTopic == 1) && (nEntry == 0))
    {
    sSay = "If you wish I can tell you of the various services in Critwall you may find useful.";
    SetLocalInt(oPC,"Entry",1);
    }
else if ((nTopic == 1) && (nEntry == 1))
    {
    sSay = "Adjacent to the market square in the northwest of the city are the apocethary, bakery and smithy.";
    SetLocalInt(oPC,"Entry",2);
    }
else if ((nTopic == 1) && (nEntry == 2))
    {
    sSay = "Across from the main gate on the north side of the city is a house the Viscount has converted into a free hostel for adventurers. You are certainly welcome to stay there.";
    SetLocalInt(oPC,"Entry",3);
    }
else if ((nTopic == 1) && (nEntry == 3))
    {
    sSay = "Besides the hold, the south of Critwall contains a warehouse and a dart parlor.";
    SetLocalInt(oPC,"Entry",4);
    }
else if ((nTopic == 1) && (nEntry == 4))
    {
    sSay = "The warehouse is especially useful for keeping things out of the hands of pickpockets. Also, the Gaffer may sell an item you're storing at both a profit to you and the city. Such commerce is encouraged.";
    SetLocalInt(oPC,"Entry",5);
    }
else if ((nTopic == 1) && (nEntry == 5))
    {
    sSay = "There're two shrines within our walls. We encourage that you tithe to these but do not require it.";
    SetLocalInt(oPC,"Entry",6);
    }
else if ((nTopic == 1) && (nEntry == 6))
    {
    sSay = "The altar in the Hold was donated by the Archcleric of Veluna, a stalwart ally of ours.";
    SetLocalInt(oPC,"Entry",7);
    }
else if ((nTopic == 1) && (nEntry == 7))
    {
    sSay = "The font in the northern courtyard is even older than the Knights of the Holy Shielding. Many of the common folk offer prayers to it as it is connected with the Old Faith.";
    SetLocalInt(oPC,"Entry",8);
    }
else if ((nTopic == 1) && (nEntry == 8))
    {
    sSay = "If you wish a mercenary to accompany you, which is certainly not unwise. They can be found at the public house in the northern part of the city.";
    SetLocalInt(oPC,"Entry",9);
    }
else if ((nTopic == 1) && (nEntry == 9))
    {
    sSay = "Across from the pub is our cobbler. Besides shoes, she may be willing to fashion you some armor or other leather goods.";
    SetLocalInt(oPC,"Entry",10);
    }
else if ((nTopic == 1) && (nEntry == 10))
    {
    sSay = "Lastly, the tailor resides in a cottage a few hundred yards north of town.";
    DeleteLocalInt(oPC,"Topic");
    DeleteLocalInt(oPC,"Entry");
    }
else if ((nTopic == 2) && (nEntry == 0))
    {
    sSay = "I think this Iuz fellow has the wool over everyone's eyes!";
    SetLocalInt(oPC,"Entry",1);
    }
else if ((nTopic == 2) && (nEntry == 1))
    {
    sSay = "He isn't nearly as scary when you consider that it is likely a succession of four or five bandit chiefs calling themselves Iuz.";
    SetLocalInt(oPC,"Entry",2);
    }
else if ((nTopic == 2) && (nEntry == 2))
    {
    sSay = "Exposing this fraud is what adventurer's should concentrate on.";
    DeleteLocalInt(oPC,"Topic");
    DeleteLocalInt(oPC,"Entry");
    }
else if ((nTopic == 3) && (nEntry == 0))
    {
    sSay = "The keep on Scragholme Isle, a few miles downriver from Critwall, is where where many of the knights and aristocrats are housed. Commoners and adventurers are generally not allowed there.";
    SetLocalInt(oPC,"Entry",1);
    }
else if ((nTopic == 3) && (nEntry == 1))
    {
    sSay = "Immediately outside of town lies Foxglove Downs, a ruined thorpe likely to be infested with some manner of nasty creatures.";
    SetLocalInt(oPC,"Entry",2);
    }
else if ((nTopic == 3) && (nEntry == 2))
    {
    sSay = "As well as Southbrook, which was an old mill.";
    SetLocalInt(oPC,"Entry",3);
    }
else if ((nTopic == 3) && (nEntry == 3))
    {
    sSay = "The Ritensa lowlands are dense and labyrinthine. Many a careless adventurer has been devoured by the denziens of that fenn.";
    SetLocalInt(oPC,"Entry",4);
    }
else if ((nTopic == 3) && (nEntry == 4))
    {
    sSay = "Beyond the lowlands is Beggarstaff Hill, the site of an old watchtower overlooking the Ritensa River. I would advise that you avoid the northeastern side of the hill, as the river has carved out a cave in the hillside which is deep and black as ink.";
    SetLocalInt(oPC,"Entry",5);
    }
else if ((nTopic == 3) && (nEntry == 5))
    {
    sSay = "And beyond Beggarstaff Hill lies the fortress of Caer Mabon, and Briarton Ferry.";
    SetLocalInt(oPC,"Entry",6);
    }
else if ((nTopic == 3) && (nEntry == 6))
    {
    sSay = "Various settlements and fortresses dot the old road which follows the Ritensa River north until it reaches the Felreev Forest.";
    DeleteLocalInt(oPC,"Topic");
    DeleteLocalInt(oPC,"Entry");
    }
else if ((nTopic == 4) && (nEntry == 0))
    {
    sSay = "Stay out of trouble and you'll not be meeting the business end of my cudgel.";
    DeleteLocalInt(oPC,"Topic");
    DeleteLocalInt(oPC,"Entry");
    }


ActionWait(6.0);
SetCustomToken(420,sSay);
return TRUE;
}
