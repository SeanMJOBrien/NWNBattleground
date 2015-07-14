void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;


string sName = GetName(oPC);
object oMod = GetModule();

//count team levels
int iGoodHD;
int iEvilHD;
int iTeam;
int iHD;

object oPlayer = GetFirstPC();

    while(oPlayer!=OBJECT_INVALID)
        {
        iTeam = GetLocalInt(oPlayer,"team");
        iHD = GetHitDice(oPlayer);
            if (iTeam==1) iGoodHD+=iHD;
            if (iTeam==2) iEvilHD+=iHD;
        oPlayer = GetNextPC();
        }

if (iGoodHD>iEvilHD)
     {
     FloatingTextStringOnCreature("This team is too strong right now, try the other team.",oPC);
     return;
     }

SetLocalInt(oPC,"team",1);
object oTarget;
oTarget = GetObjectByTag("evilguyx");

AdjustReputation(oPC, oTarget, -100);
ActionSpeakString(sName+" has joined the Army of Light.",TALKVOLUME_SHOUT);
location lTarget;
oTarget = GetWaypointByTag("wp_goodenter");

lTarget = GetLocation(oTarget);

object oTeam = GetFirstPC();


while(oTeam!=OBJECT_INVALID)
        {
        int iSide = GetLocalInt(oTeam,"team");
        int iMyside = 1;
        if (iSide==iMyside)
             {
             AddToParty(oPC,oTeam);
             }
        if (iSide!=iMyside)
             {
             SetPCDislike(oPC,oTeam);
             }

        oTeam = GetNextPC();
        }

//int iGold = GetGold(oPC);
      //TakeGoldFromCreature(iGold,oPC,TRUE);



if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));
CreateItemOnObject("good_key",oPC);
int iGold = GetGold(oPC);
TakeGoldFromCreature(iGold,oPC,TRUE);
//bonuses for rank and game in progress
object oWidget = GetItemPossessedBy(oPC,"widget");
int iRank = GetLocalInt(oWidget,"score");
SetLocalInt(oWidget,"lastteam",1);
if (iRank>99)
{
int iBonus = FloatToInt(iRank/100.0f);
int iGold = FloatToInt(iRank/100.0f);
string sRank = IntToString(iGold);
string sBonus = IntToString(iBonus);
GiveXPToCreature(oPC,iBonus);
DelayCommand(15.0f,FloatingTextStringOnCreature(sBonus+" XP bonus for score.",oPC));
GiveGoldToCreature(oPC,iGold);
DelayCommand(20.0f,FloatingTextStringOnCreature(sRank+" GP bonus for score.",oPC));
}
int iTurn = GetLocalInt(oMod,"turn");
int iMult = iTurn+iTurn*30;
//game in progress bonus if necessary
string sNames = GetLocalString(GetModule(),GetName(oPC));
      if (sNames == "")
      {
      SetLocalInt(oPC,"joined",1);
      SetLocalInt(oMod,GetName(oPC),1);
      int iAvg = GetLocalInt(oMod,"avglevel");
      GiveXPToCreature(oPC,iMult*iAvg);
      GiveGoldToCreature(oPC,iMult*iAvg);
      string sGIPXP = IntToString(iMult);
      string sGIPGP = IntToString(iMult);
      DelayCommand(10.0f,FloatingTextStringOnCreature("Game in progress bonus is "+sGIPXP+" XP and "+sGIPGP+" GP.",oPC));
      SetLocalString(GetModule(),GetName(oPC),GetName(oPC));
      }
//create starting gear
CreateItemOnObject("start_dagger",oPC);
SetLocalInt(oPC,"mylevel",5);
if (GetItemPossessedBy(oPC,"divinefocus")==OBJECT_INVALID) CreateItemOnObject("divinefocus",oPC);
ExecuteScript("createmwitem",oPC);
int iClass = GetClassByPosition(1,oPC);
int iRace = GetRacialType(oPC);
int iSmall;
if (iRace==RACIAL_TYPE_HALFLING||iRace==RACIAL_TYPE_GNOME) iSmall = TRUE;
if (iSmall==TRUE) ExecuteScript("create_wep_sml",oPC);
if (iClass==CLASS_TYPE_BARBARIAN)
    {
    CreateItemOnObject("leathergood",oPC);
    if (d6()==1) CreateItemOnObject("get_mount",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_wep_brb",oPC);
    CreateItemOnObject("goodhelmet",oPC);
    GiveGoldToCreature(oPC,50+d20(1));
    }
if (iClass==CLASS_TYPE_BARD)
    {
    CreateItemOnObject("good_bard",oPC);
    ExecuteScript("create_wep_rog",oPC);
    ExecuteScript("create_wand",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,50+d20(5));
    }
if (iClass==CLASS_TYPE_CLERIC)
    {
    CreateItemOnObject("leathergood",oPC);
    ExecuteScript("create_wep_clr",oPC);
    CreateItemOnObject("goodshield",oPC);
    CreateItemOnObject("goodhelmet",oPC);
    GiveGoldToCreature(oPC,50+d20(1));
    }
if (iClass==CLASS_TYPE_DRUID)
    {
    CreateItemOnObject("leathergood",oPC);
    ExecuteScript("create_wep_drd",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,50+d20(1));
    }
if (iClass==CLASS_TYPE_FIGHTER)
    {
    CreateItemOnObject("chainmailgood",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_wep_ftr",oPC);
    CreateItemOnObject("goodshield",oPC);
    CreateItemOnObject("goodhelmet",oPC);
    GiveGoldToCreature(oPC,50+d20(5));
    if (d6()==1) CreateItemOnObject("get_mount",oPC);
    }
if (iClass==CLASS_TYPE_MONK)
    {
    CreateItemOnObject("monkhabitgood",oPC);
    ExecuteScript("create_mnkgloves",oPC);
    ExecuteScript("create_mnkrobe",oPC);
    ExecuteScript("create_wep_mnk",oPC);
    GiveGoldToCreature(oPC,20+d20(1));
    }
if (iClass==CLASS_TYPE_PALADIN)
    {
    CreateItemOnObject("chainmailgood",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_wep_ftr",oPC);
    CreateItemOnObject("goodshield",oPC);
    CreateItemOnObject("goodhelmet",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,20+d20(1));
    if (d6()==1) CreateItemOnObject("get_mount",oPC);
    }
if (iClass==CLASS_TYPE_RANGER)
    {
    CreateItemOnObject("leathergood",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_wep_ftr",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_bow",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,30+d20(1));
    if (d6()==1) CreateItemOnObject("get_mount",oPC);
    }
if (iClass==CLASS_TYPE_ROGUE)
    {
    CreateItemOnObject("leathergood",oPC);
    if (iSmall!=TRUE) ExecuteScript("create_wep_rog",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,50+d20(5));
    }
if (iClass==CLASS_TYPE_SORCERER)
    {
    CreateItemOnObject("good_cloth",oPC);
    ExecuteScript("create_lxbow",oPC);
    ExecuteScript("create_wand",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,50+d20(1));
    }
if (iClass==CLASS_TYPE_WIZARD)
    {
    CreateItemOnObject("good_cloth",oPC);
    ExecuteScript("create_lxbow",oPC);
    ExecuteScript("create_staff",oPC);
    CreateItemOnObject("goodcloak",oPC);
    GiveGoldToCreature(oPC,50+d20(1));
    }
//apply subrace if any
int iSubrace = GetLocalInt(oPC,"racechoice");
if (iSubrace==1) ExecuteScript("sr_aasimar",oPC);
if (iSubrace==4) ExecuteScript("sr_lizfolk",oPC);
}

