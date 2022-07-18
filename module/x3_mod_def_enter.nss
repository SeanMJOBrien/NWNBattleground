void main()
{
    object oPC=GetEnteringObject();
    if (GetIsPC(oPC)!=TRUE) return;
    object oWidget;
      if (GetItemPossessedBy(oPC,"widget")==OBJECT_INVALID) CreateItemOnObject("widget",oPC);
      oWidget = GetItemPossessedBy(oPC,"widget");
      int iRank = GetLocalInt(oWidget,"score");
      //int iSubrace = GetLocalInt(oWidget,"subrace");
      int iFirst = GetLocalInt(oWidget,"first");
      int iSkin;
      int iHair;
      int iHead;
      int iPheno;
      int iApp;
//check to see if player was already on a team....if so reset the team
int iTeam = GetLocalInt(OBJECT_SELF,GetName(oPC));
if (iTeam==1)
    {
    SetLocalInt(oPC,"team",1);
    return;
    }
if (iTeam==2)
    {
    SetLocalInt(oPC,"team",2);
    return;
    }
//if they are a subrace, restore them to normal
if (iFirst==1)
     {
      iSkin = GetLocalInt(oWidget,"skin");
      iHair = GetLocalInt(oWidget,"hair");
      iHead = GetLocalInt(oWidget,"head");
      iPheno = GetLocalInt(oWidget,"pheno");
      iApp = GetLocalInt(oWidget,"app");
      SetColor(oPC,COLOR_CHANNEL_SKIN,iSkin);
      SetColor(oPC,COLOR_CHANNEL_HAIR,iHair);
      SetCreatureBodyPart(CREATURE_PART_HEAD,iHead,oPC);
      SetPhenoType(iPheno,oPC);
      SetCreatureAppearanceType(oPC,iApp);
      SetLocalFloat(oWidget,"xpmod",1.0f);
      SetLocalInt(oWidget,"subrace",0);
      object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
      DeleteLocalInt(oPC,"racechoice");
      if (oHide!=OBJECT_INVALID) DestroyObject(oHide);
      SetCreatureTailType(0,oPC);
      SetCreatureWingType(0,oPC);
      //SpeakString("Not the first time script fired.",TALKVOLUME_SHOUT);
      }
//save head, skin color, hair color and pheno and race on first visit
if (iFirst==0)
      {
      iSkin = GetColor(oPC,COLOR_CHANNEL_SKIN);
      iHair = GetColor(oPC,COLOR_CHANNEL_HAIR);
      iHead = GetCreatureBodyPart(CREATURE_PART_HEAD,oPC);
      iPheno = GetPhenoType(oPC);
      iApp = GetAppearanceType(oPC);
      SetLocalInt(oWidget,"skin",iSkin);
      SetLocalInt(oWidget,"hair",iHair);
      SetLocalInt(oWidget,"head",iHead);
      SetLocalInt(oWidget,"pheno",iPheno);
      SetLocalInt(oWidget,"app",iApp);
      SetLocalInt(oWidget,"first",1);
      //SpeakString("First time script fired.",TALKVOLUME_SHOUT);
      }
//if they are dead,res them
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);

//strip all items and xp
SetXP(oPC,0);
      object oItem = GetFirstItemInInventory(oPC);
      while (oItem != OBJECT_INVALID)
      {
        if (GetTag(oItem) != "widget")
        {DestroyObject(oItem);}
        oItem = GetNextItemInInventory(oPC);
      }
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC), 0.0);
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC), 0.0);
      //new outfit
      CreateItemOnObject("robes",oPC);
      object oRobe = GetItemPossessedBy(oPC,"robes");
      DelayCommand(1.0f,(AssignCommand(oPC,(ActionEquipItem(oRobe,INVENTORY_SLOT_CHEST)))));
      string sPCName = GetPCPlayerName(oPC);
      SetLocalInt(oPC,"cp",0);
      SetLocalInt(oPC,"prayed",FALSE);
      int iGold = GetGold(oPC);
      TakeGoldFromCreature(iGold,oPC,TRUE);
      object oStartWP = GetWaypointByTag("wp_start");
      location lStart = GetLocation(oStartWP);
      object oArea = GetArea(oPC);
      string sAreatag = GetTag(oArea);
      SetLocalInt(oPC,"race",0);
      SetCreatureWingType(CREATURE_WING_TYPE_NONE,oPC);
      //add divine focus if they don't have one yet
      if (GetItemPossessedBy(oPC,"divinefocus")==OBJECT_INVALID) CreateItemOnObject("divinefocus",oPC);
      //if not in start area...send them there
      if (sAreatag!="start") AssignCommand(oPC,JumpToLocation(lStart));
      //reset race
      int iRace = GetRacialType(oPC);

      if (iRace==RACIAL_TYPE_HUMAN)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN);
      if (iRace==RACIAL_TYPE_ELF)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ELF);
      if (iRace==RACIAL_TYPE_DWARF)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DWARF);
      if (iRace==RACIAL_TYPE_HALFLING)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING);
      if (iRace==RACIAL_TYPE_GNOME)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GNOME);
      if (iRace==RACIAL_TYPE_HALFELF)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF);
      if (iRace==RACIAL_TYPE_HALFORC)SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC);

      object oGood = GetObjectByTag("goodguy");
      object oEvil = GetObjectByTag("evilguy");
      //reset rep
      AdjustReputation(oPC, oGood, 100);
      AdjustReputation(oPC, oEvil, 100);
      //ExploreAreaForPlayer(GetObjectByTag("Main1"),oPC,TRUE);
      DelayCommand(5.0f,FloatingTextStringOnCreature("<c þþ>Welcome to NWN Battleground. Read your journal for more information.</c>",oPC,FALSE));
      AddJournalQuestEntry("objectives",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("upkeep",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("industries",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("troops",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("commandpts",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("divinefavor",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("mana",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("pctool",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("resources",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("score",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("death",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("rest",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("workers",1,oPC,FALSE,FALSE,FALSE);
      AddJournalQuestEntry("population",1,oPC,FALSE,FALSE,FALSE);
      DeleteLocalInt(oPC,"team");
}






