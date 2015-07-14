void AwardCP( object oPC )
{
int iCCP = GetLocalInt(oPC,"cp");
int iTeam = GetLocalInt(oPC,"team");
int iHD = GetHitDice(oPC)/3;
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oPC);
int iWIS = GetAbilityModifier(ABILITY_WISDOM,oPC);
int iSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC);
int iINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
int iPer = GetSkillRank(SKILL_PERSUADE,oPC)/5;
int iInt = GetSkillRank(SKILL_INTIMIDATE,oPC)/5;
int iBlf = GetSkillRank(SKILL_BLUFF,oPC)/5;
int iLAW = GetAlignmentLawChaos(oPC);
int iLB;
if (iLAW==ALIGNMENT_LAWFUL) iLB = 3;
int iCB1 = 0;
int iCB2 = 0;
int iCB3 = 0;
DeleteLocalInt(oPC,"canrest");
DeleteLocalInt(oPC,"prayed");
switch (GetClassByPosition(1,oPC))
    {
    case CLASS_TYPE_BARD: iCB1-=3;break;
    case CLASS_TYPE_SORCERER: iCB1-=4;break;
    case CLASS_TYPE_CLERIC: iCB1+=3;break;
    case CLASS_TYPE_FIGHTER: iCB1+=6;break;
    case CLASS_TYPE_PALADIN: iCB1+=4;break;
    case CLASS_TYPE_RANGER: iCB1+=3;break;
    case CLASS_TYPE_WIZARD: iCB1+=1;break;
    }
switch (GetClassByPosition(2,oPC))
    {
    case CLASS_TYPE_CLERIC: iCB1+=1;break;
    case CLASS_TYPE_FIGHTER: iCB1+=2;break;
    case CLASS_TYPE_PALADIN: iCB1+=3;break;
    case CLASS_TYPE_RANGER: iCB1+=2;break;
    case CLASS_TYPE_WIZARD: iCB1+=1;break;
    case CLASS_TYPE_BLACKGUARD: iCB1+=3;break;
    case CLASS_TYPE_DIVINECHAMPION: iCB1+=3;break;
    case CLASS_TYPE_DWARVENDEFENDER: iCB1+=3;break;
    }
switch (GetClassByPosition(3,oPC))
    {
    case CLASS_TYPE_CLERIC: iCB1+=1;break;
    case CLASS_TYPE_FIGHTER: iCB1+=1;break;
    case CLASS_TYPE_PALADIN: iCB1+=1;break;
    case CLASS_TYPE_RANGER: iCB1+=1;break;
    case CLASS_TYPE_WIZARD: iCB1+=1;break;
    case CLASS_TYPE_BLACKGUARD: iCB1+=1;break;
    case CLASS_TYPE_DIVINECHAMPION: iCB1+=1;break;
    case CLASS_TYPE_DWARVENDEFENDER: iCB1+=1;break;
    }
int iCP;
if (iTeam==1) iCP = (iHD+iCHA+iWIS+iCB1+iCB2+iCB3+iPer+iInt+iBlf+iLB)/2;
if (iTeam==2) iCP = (iHD+iSTR+iINT+iCB1+iCB2+iCB3+iPer+iInt+iBlf+iLB)/2;
if (iCP<=0) iCP=1;
SetLocalInt(oPC,"cp",iCP+iCCP);
string sCCP = IntToString(iCCP+iCP);
string sCPT = IntToString(iCP);
DelayCommand(1.0f,FloatingTextStringOnCreature("<c þ >+ "+sCPT+" ***** "+sCCP+" Total CP</c>",oPC,FALSE));
}
void AwardDF( object oPC )
{
int iCDF = GetLocalInt(oPC,"df");
int iHD = GetHitDice(oPC)/4;
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oPC);
int iCB1 = 0;
int iCB2 = 0;
int iCB3 = 0;
switch (GetClassByPosition(1,oPC))
    {
    case CLASS_TYPE_BARD: iCB1-=3;break;
    case CLASS_TYPE_ROGUE: iCB1-=2;break;
    case CLASS_TYPE_CLERIC: iCB1+=5;break;
    case CLASS_TYPE_MONK: iCB1+=4;break;
    case CLASS_TYPE_DRUID: iCB1+=5;break;
    case CLASS_TYPE_FIGHTER: iCB1+=1;break;
    case CLASS_TYPE_PALADIN: iCB1+=5;break;
    case CLASS_TYPE_WIZARD: iCB1+=1;break;
    case CLASS_TYPE_SORCERER: iCB1-=3;break;
    }
switch (GetClassByPosition(2,oPC))
    {
    case CLASS_TYPE_CLERIC: iCB1+=5;break;
    case CLASS_TYPE_DRUID: iCB1+=5;break;
    case CLASS_TYPE_MONK: iCB1+=2;break;
    case CLASS_TYPE_PALADIN: iCB1+=4;break;
    case CLASS_TYPE_BLACKGUARD: iCB1+=3;break;
    case CLASS_TYPE_DIVINECHAMPION: iCB1+=3;break;
    case CLASS_TYPE_DWARVENDEFENDER: iCB1+=1;break;
    }
switch (GetClassByPosition(3,oPC))
    {
    case CLASS_TYPE_CLERIC: iCB1+=5;break;
    case CLASS_TYPE_DRUID: iCB1+=5;break;
    case CLASS_TYPE_MONK: iCB1+=1;break;
    case CLASS_TYPE_PALADIN: iCB1+=4;break;
    case CLASS_TYPE_BLACKGUARD: iCB1+=3;break;
    case CLASS_TYPE_DIVINECHAMPION: iCB1+=3;break;
    case CLASS_TYPE_DWARVENDEFENDER: iCB1+=1;break;
    }

int iDF = (iHD+iCHA+iCB1+iCB2+iCB3)/2;
if (iDF<=0) iDF=1;
SetLocalInt(oPC,"df",iDF+iCDF);
string sCDF = IntToString(iCDF+iDF);
string sDF = IntToString(iDF);
DelayCommand(2.0f,FloatingTextStringOnCreature("<c  þ>+ "+sDF+" ***** "+sCDF+" Total DF</c>",oPC,FALSE));
}
void AwardMana(object oPC)
{
int iHD = GetHitDice(oPC);
int iWiz = GetLevelByClass(CLASS_TYPE_WIZARD,oPC);
int iSor = GetLevelByClass(CLASS_TYPE_SORCERER,oPC);
int iBard = GetLevelByClass(CLASS_TYPE_BARD,oPC);
int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
int iDruid = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
int iAA = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
int iBG = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
int iCoT = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC);
int iRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
int iHS = GetLevelByClass(CLASS_TYPE_HARPER,oPC);
int iPally = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
int iPM = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC);
int iRgr = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
int iShft = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
int iESorc = GetHasFeat(FEAT_EPIC_SORCERER,oPC);
int iEWiz = GetHasFeat(FEAT_EPIC_WIZARD,oPC);
int iEEnch = GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT,oPC);
int iGEnch = GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT,oPC);
int iEnch = GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT,oPC);
int iInt = GetAbilityScore(oPC,ABILITY_INTELLIGENCE);
int iMD = GetHasFeat(FEAT_MAGIC_DOMAIN_POWER,oPC);
int iSCRank = GetSkillRank(SKILL_SPELLCRAFT,oPC);
object oItem = GetItemPossessedBy(oPC,"widget");
int iTotal;
iTotal = (iWiz*3)+(iSor*2)+(iBard*2)+iCleric+iDruid+(iAA*2)+iBG+iCoT+iRDD+(iHS*2)
+iPally+(iPM*2)+iRgr+iShft+iSCRank+iInt+iHD+1;
if (iESorc==1) iTotal+=3;
if (iEWiz==1) iTotal+=10;
if (iEnch==1) iTotal+=3;
if (iGEnch==1) iTotal+=6;
if (iEEnch==1) iTotal+=9;
if (iMD==1) iTotal+=5;
int iResult = iTotal/10;
string sMana = IntToString(iResult);
int iMT = GetLocalInt(oPC,"mana");
SetLocalInt(oPC,"mana",iMT+iResult);
string sMT = IntToString(iMT+iResult);
DelayCommand(3.0f,FloatingTextStringOnCreature("<cþ þ>+ "+sMana+" ***** "+sMT+" Total Mana</c>",oPC,FALSE));
}
void main()
{
int iSide = GetLocalInt(OBJECT_SELF,"team");
string sTag = GetTag(GetArea(OBJECT_SELF));
if (sTag=="start") return;
object oMod = GetModule();
AwardCP(OBJECT_SELF);
AwardDF(OBJECT_SELF);
AwardMana(OBJECT_SELF);
int iGP;
string sGP;
if (iSide==1)
    {
    iGP = GetLocalInt(oMod,"tax1")/GetLocalInt(oMod,"goodplayers");
    sGP = IntToString(iGP);
    GiveGoldToCreature(OBJECT_SELF,iGP);
    DelayCommand(4.0f,FloatingTextStringOnCreature("<cþ¥ >+ "+sGP+" GP Tax Income.</c>",OBJECT_SELF,FALSE));
    }
if (iSide==2)
    {
    iGP = GetLocalInt(oMod,"tax2")/GetLocalInt(oMod,"evilplayers");
    sGP = IntToString(iGP);
    GiveGoldToCreature(OBJECT_SELF,iGP);
    DelayCommand(4.0f,FloatingTextStringOnCreature("<cþ¥ >+ "+sGP+" GP Tax Income.</c>",OBJECT_SELF,FALSE));
    }
object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
//check for uniform bonus
if (GetLocalInt(oArmor,"uniform")!=TRUE) return;
int iCmd = GetLocalInt(OBJECT_SELF,"cp");
int iUSide = GetLocalInt(oArmor,"team");
if (iUSide!=iSide) return;
SetLocalInt(OBJECT_SELF,"cp",iCmd+1);
DelayCommand(5.0f,FloatingTextStringOnCreature("<cþ¥ >+1 CP for being in uniform.</c>",OBJECT_SELF,FALSE));
//award xp for intelligence and turn number
DeleteLocalInt(OBJECT_SELF,"canrest");
int iInt = GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE,FALSE)+10;
int iTurn = GetLocalInt(oMod,"turn");
object oWidget = GetItemPossessedBy(OBJECT_SELF,"widget");
float fRace = GetLocalFloat(oWidget,"xpmod");
int iXP = FloatToInt(fRace*((iInt*3)+(iTurn*10)));
GiveXPToCreature(OBJECT_SELF,iXP);
}
