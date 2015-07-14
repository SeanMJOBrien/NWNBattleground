void main()
{
object oPC = GetLastKiller();
GiveXPToCreature(oPC,25);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iScore = GetLocalInt(oWidget,"score");
int iCP = GetLocalInt(oPC,"cp");
SetLocalInt(oWidget,"score",iScore+1);
SetLocalInt(oPC,"cp",iCP+1);
/////////roll for result of mining check
int iBonus = 0;
int iRace = GetRacialType(oPC);
if (iRace==RACIAL_TYPE_DWARF) iRace+=10;
int iCA = GetSkillRank(SKILL_CRAFT_ARMOR,oPC,FALSE);
int iCW = GetSkillRank(SKILL_CRAFT_WEAPON,oPC,FALSE);
if (iCA>iCW) iBonus = iCA;
else iBonus = iCW;
int iRoll = d100()+iBonus+iRace;
string sResRef;
string sResource;
if (iRoll<=40) {sResource="Copper";sResRef="copper";}
if (iRoll<90&&iRoll>40) {sResource="Iron";sResRef="iron";}
if (iRoll<95&&iRoll>90) {sResource="Mithril";sResRef="mith";}
if (iRoll<100&&iRoll>95) {sResource="Adamantine";sResRef="adam";}
if (iRoll<105&&iRoll>100) {sResource="Iron";sResRef="iron";}
if (iRoll<125&&iRoll>105) {sResource="Mithril";sResRef="mith";}
if (iRoll>=125) {sResource="Adamantine";sResRef="adam";}
//respawn code
location lHere = GetLocation(OBJECT_SELF);
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_p",lHere);
SetLocalString(oSpawner,"resref",sRes);
AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_p",oSpawner)));
//message stuff
FloatingTextStringOnCreature("You gather a unit of "+sResource+". +1 CP. +25 XP. +1 Score.",oPC,FALSE);
CreateItemOnObject(sResRef,oPC);
if (d8()==1)
    {
    DelayCommand(1.0f,FloatingTextStringOnCreature("You find a gem amidst the rubble.",oPC,FALSE));
    CreateItemOnObject("nw_it_gem00"+IntToString(Random(9)+1),oPC);
    return;
    }
if (d8()==1)
    {
    DelayCommand(2.0f,FloatingTextStringOnCreature("You find a gem amidst the rubble.",oPC,FALSE));
    CreateItemOnObject("nw_it_gem0"+IntToString(Random(6)+10),oPC);
    return;
    }
if (d8()==1)
    {
    DelayCommand(3.0f,FloatingTextStringOnCreature("You find a mana crystal amidst the rubble.",oPC,FALSE));
    CreateItemOnObject("manacrystal",oPC);
    return;
    }
if (d8()==1)
    {
    DelayCommand(4.0f,FloatingTextStringOnCreature("You find some gold nuggets in the rubble.",oPC,FALSE));
    GiveGoldToCreature(oPC,d100()+20);
    return;
    }
}
