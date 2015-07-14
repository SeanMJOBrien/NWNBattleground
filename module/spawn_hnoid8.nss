void main()
{
int iRoll = Random(29)+1;
object oMod = GetModule();
int iDepth = GetLocalInt(oMod,"avglevel");
string sType = "";
string sMsg = "";
object oWP = GetWaypointByTag("wp_center");//get center of map
location lHere = GetLocation(GetNearestObjectByTag("wp_spawn",oWP,d8()));
int iLevelmin;
switch(iRoll)
    {
    case 1: iLevelmin=3;sType="yti";sMsg="<c�� >A group of Yaun-Ti have been spotted in the area. An attack is likely.</c>";break;
    case 2: iLevelmin=0;sType="hob";sMsg="<c�� >A group of Hobgoblins are moving in and are very hostile.</c>";break;
    case 3: iLevelmin=0;sType="kob";sMsg="<c�� >A group of Kobolds have begun a raid. We must be vigilant.</c>";break;
    case 4: iLevelmin=0;sType="orc";sMsg="<c�� >Orcs are ravaging the countryside. To arms.</c>";break;
    case 5: iLevelmin=0;sType="ske";sMsg="<c�� >A group of skeletons are marauding through the area. Destroy them.</c>";break;
    case 6: iLevelmin=2;sType="trg";sMsg="<c�� >A group of Troglodytes have come to the aid of the evil army.</c>";break;
    case 7: iLevelmin=0;sType="ban";sMsg="<c�� >A group of bandits have come to the aid of the evil army.</c>";break;
    case 8: iLevelmin=0;sType="adv";sMsg="<c�� >A group of adventurers have come to the aid of the good army.</c>";break;
    case 9: iLevelmin=2;sType="gth";sMsg="<c�� >A band of Githyanki astral pirates are here to plunder. Kill them on sight.</c>";break;
    case 10: iLevelmin=0;sType="ict";sMsg="<c�� >A pack of Ichthyoids have surfaced from the depths looking for treasure. Kill them all.</c>";break;
    case 11: iLevelmin=0;sType="liz";sMsg="<c�� >A tribe of Lizardfolk are trying to claim this land as their own. They will not be reasoned with.</c>";break;
    case 12: iLevelmin=2;sType="tie";sMsg="<c�� >A group of evil outsiders are here to sow the seeds of destruction.</c>";break;
    case 13: iLevelmin=0;sType="zmb";sMsg="<c�� >When hell is full, the dead shall walk the earth.</c>";break;
    case 14: iLevelmin=0;sType="sti";sMsg="<c�� >A group of Stingers have denounced our very existance and have vowed to kill us all.</c>";break;
    case 15: iLevelmin=0;sType="svi";sMsg="<c�� >A group of Svirfneblin have come to the aid of the good army.</c>";break;
    case 16: iLevelmin=2;sType="drw";sMsg="<c�� >A group of Drow have journeyed from the Underdark to punish us.</c>";break;
    case 17: iLevelmin=2;sType="dur";sMsg="<c�� >A group of Deurgar are here to find slaves for the Illithid. Kill them all.</c>";break;
    case 18: iLevelmin=2;sType="bug";sMsg="<c�� >A group of Bugbears have come to the aid of the evil army.</c>";break;
    case 19: iLevelmin=2;sType="gnl";sMsg="<c�� >A group of Gnolls have come to the aid of the evil army.</c>";break;
    case 20: iLevelmin=3;sType="hdr";sMsg="<c�� >A group of Half-dragons claim this area as their ancestral nesting grounds. They intend to kill us all.</c>";break;
    case 21: iLevelmin=3;sType="drd";sMsg="<c�� >A group of Driders are here to kill everything with less than six legs.</c>";break;
    case 22: iLevelmin=4;sType="min";sMsg="<c�� >A gang of Minotaurs have come to take all of our hard-earned gold. They'll get our blades.</c>";break;
    case 23: iLevelmin=2;sType="azr";sMsg="<c�� >A group of Azer marauders are here for our gems. They can pry them from our cold, dead hands.</c>";break;
    case 24: iLevelmin=10;sType="vmp";sMsg="<c�� >The Vampires are thirsting for blood, and are on the hunt.</c>";break;
    case 25: iLevelmin=0;sType="gob";sMsg="<c�� >A group of Goblins are here to do as much damage as possible. Kill the little miscreants quickly.</c>";break;
    case 26: iLevelmin=0;sType="sat";sMsg="<c�� >A herd of Satyrs want us to leave this land. They threaten us with death if we do not.</c>";break;
    case 27: iLevelmin=0;sType="imp";sMsg="<c�� >Impkin from the outer planes are here to murder and burn things.</c>";break;
    case 28: iLevelmin=0;sType="elf";sMsg="<c�� >A group of Elves have come to the aid of the good army.</c>";break;
    case 29: iLevelmin=0;sType="hlf";sMsg="<c�� >A group of Halflings have come to the aid of the good army.</c>";break;
    }
if (iLevelmin>iDepth) return;
///////////////////////////////////////////////////////////////////////////////////
//init vars
object oSpawn1;
object oSpawn2;
object oSpawn3;
object oSpawn4;
object oSpawn5;
object oSpawn6;
object oSpawn7;
object oSpawn8;
object oSpawn9;
object oSpawn10;
object oSpawn11;
object oSpawn12;
object oSpawn13;
//create main warriors
oSpawn1 = CreateObject(OBJECT_TYPE_CREATURE,sType+"main",lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn1));
oSpawn2 = CreateObject(OBJECT_TYPE_CREATURE,sType+"main",lHere);
DelayCommand(0.2f,ExecuteScript("level_up",oSpawn2));
oSpawn3 = CreateObject(OBJECT_TYPE_CREATURE,sType+"main",lHere);
DelayCommand(0.3f,ExecuteScript("level_up",oSpawn3));
oSpawn4 = CreateObject(OBJECT_TYPE_CREATURE,sType+"alt",lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn4));
oSpawn5 = CreateObject(OBJECT_TYPE_CREATURE,sType+"alt",lHere);
DelayCommand(0.2f,ExecuteScript("level_up",oSpawn5));
oSpawn6 = CreateObject(OBJECT_TYPE_CREATURE,sType+"alt",lHere);
DelayCommand(0.3f,ExecuteScript("level_up",oSpawn6));
oSpawn7 = CreateObject(OBJECT_TYPE_CREATURE,sType+"fem",lHere);
oSpawn8 = CreateObject(OBJECT_TYPE_CREATURE,sType+"kid",lHere);
oSpawn9 = CreateObject(OBJECT_TYPE_CREATURE,sType+"pet",lHere);
oSpawn10 = CreateObject(OBJECT_TYPE_CREATURE,sType+"add",lHere);
DelayCommand(0.4f,ExecuteScript("level_up",oSpawn10));
oSpawn11 = CreateObject(OBJECT_TYPE_CREATURE,sType+"wiz",lHere);
DelayCommand(0.5f,ExecuteScript("level_up",oSpawn10));
oSpawn12 = CreateObject(OBJECT_TYPE_CREATURE,sType+"main",lHere);
DelayCommand(0.1f,ExecuteScript("level_up",oSpawn12));
oSpawn13 = CreateObject(OBJECT_TYPE_CREATURE,sType+"alt",lHere);
DelayCommand(0.3f,ExecuteScript("level_up",oSpawn13));
//announce the event to the PCs
object oPC = GetFirstPC();
while(oPC!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature(sMsg,oPC);
    oPC=GetNextPC();
    }
}
