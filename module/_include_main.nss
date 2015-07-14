//Creates a creature with a specific string at a specified location
void CreateObjectVoid(int nObjectType, string sTemplate, location lLoc, int bUseAppearAnimation = FALSE);
//awards XP to all party members
void RewardPartyXP(object oTarget, int iXP);
//returns true if item is a weapon
int GetIsWeapon ( object oItem );
//returns true if weapon is not a ranged weapon
int GetIsMeleeWeapon ( object oItem );
//sends a message to all PCs
void SendMsgToAllPCs(string sMessage);
//sends a message to all PCs in indicated area
void SendMsgToAllArea(string sMessage,object oArea);
//determines differences in alignment on both axes, higher results are yeilded by larger differences
int GetAlignOpposeFactor ( object oSubject1, object oSubject2 );
//adjusts alignment relative to a particular faction
void AdjustFactionRep(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment);
//sends color message 0=white 1=red 2=green 3=blue 4=cyan 5=magenta 6=yellow 7=black 8=dark red
//9= dark green 10=dark blue 11=dark cyan 12=dark magenta 13=dark yellow 14=grey 15=dark grey
//16=orange17=dark orange 18=brown 19=dark brown
void SendColorMessage(object oPC, int iColor, string sMessage);
//awards hourly divine favor to PC
void AwardDF( object oPC );
//awards hourly cp to PC
void AwardCP( object oPC );
//awards an entire team a number of XP
void TeamXP(int iTeam,int iXP);
//create item and return nothing
void CreateItemVoid(object oTarget,string sResref);
//get is edged or sharp weapon
int GetIsSharpWeapon(object oItem);
/////////////////begin function//////////////////////////////////////////////////
void RewardPartyXP(object oTarget, int iXP)
{
//AssignCommand(oTarget, SpeakString("in rewardxp funtion"));
        object oPartyMember = GetFirstFactionMember(oTarget,FALSE);
        while (GetIsObjectValid(oPartyMember) == TRUE)
        {
            GiveXPToCreature(oPartyMember,iXP);
            oPartyMember = GetNextFactionMember(oTarget,FALSE);
            //AssignCommand(oTarget,SpeakString("here your xp sir"));
        }
}
///////////////////////end function////////////////////////////////////////////////
///////////////////////////begin function//////////////////////////////////////////
int DoSkillCheck ( object oPC , string sSkill , int iDC , int iBonus=0)
{
string sSkillXP = GetStringLeft(sSkill,3)+"xp";
object oItem = GetItemPossessedBy(oPC,"pc_info");
int iBonusXP = 25;
int iSkill = GetLocalInt(oItem,sSkill);
int iSkillXP = GetLocalInt(oItem,sSkillXP);
int iRoll = d20();
string sRoll = IntToString(iRoll);
string sBonus = IntToString(iSkill+iBonus);
string sDC = IntToString(iDC);
int iINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
if ((iRoll+iSkill+iBonus)>=iDC)//success
    {
    int iINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    int iXProll = d6();
    int iTotal = iINT+iXProll+iBonusXP;
    if (iTotal<=0) iTotal = 1;
    SetLocalInt(oItem,sSkillXP,iSkillXP+iTotal);
    FloatingTextStringOnCreature(sSkill+" skill roll is ("+sRoll+" + "+sBonus+") vs. DC "+sDC+". Success.",oPC,FALSE);
    if ((iSkillXP+iTotal)>=((iSkill+5)*(iSkill*3)))//skill increase
        {
        SetLocalInt(oItem,sSkill,iSkill+1);
        string sNew = IntToString(iSkill+1);
        DelayCommand(3.0f,FloatingTextStringOnCreature("<c þ >"+sSkill+" skill increased to "+sNew+"</c>",oPC,FALSE));
        SetLocalInt(oItem,sSkillXP,0);
        GiveXPToCreature(oPC,iBonusXP);
        }
    return TRUE;
    }
else//fail skill roll
    {
    FloatingTextStringOnCreature("<cþ  >"+sSkill+" skill roll is ("+sRoll+" + "+sBonus+") vs. DC "+sDC+". Failed.</c>",oPC,FALSE);
    return FALSE;
    }
}
////////////////////////////////////new function////////////////////////////////////////
int GetIsWeapon ( object oItem )
{
int iType = GetBaseItemType(oItem);
if (iType==14||iType==15||iType==16||iType==17||iType==19||iType==20||iType==21||
    iType==25||iType==26||iType==27||iType==36||iType==39||iType==44||iType==46||
    iType==49||iType==52||iType==56||iType==57||iType==74||iType==75||iType==77||
    iType==78||iType==80)
    return FALSE;
    else return TRUE;
}
///////////////////////////////////new function//////////////////////////////////////////
int GetIsMeleeWeapon ( object oItem )
{
int iType = GetBaseItemType(oItem);
if (iType==BASE_ITEM_HEAVYCROSSBOW||
    iType==BASE_ITEM_LIGHTCROSSBOW||
    iType==BASE_ITEM_LONGBOW||
    iType==BASE_ITEM_SHORTBOW||
    iType==BASE_ITEM_SLING||
    iType==BASE_ITEM_DART||
    iType==BASE_ITEM_SHURIKEN||
    iType==BASE_ITEM_THROWINGAXE)
    return FALSE;
    else return TRUE;
}
///////////////////////////////////new function//////////////////////////////////////////
void SendMsgToAllPCs(string sMessage)
{

object oPC = GetFirstPC();
while (oPC!=OBJECT_INVALID)
         {
         FloatingTextStringOnCreature(sMessage,oPC);
         oPC = GetNextPC();
         }
}
/////////////////////////////////////new function/////////////////////////////////////
void SendMsgToAllArea(string sMessage,object oArea)
{

object oPC = GetFirstPC();
while (oPC!=OBJECT_INVALID)
         {
         if (GetArea(oPC)==oArea)FloatingTextStringOnCreature(sMessage,oPC);
         oPC = GetNextPC();
         }
}
////////////////////////////////////new function//////////////////////////////////////
int GetAlignOpposeFactor ( object oSubject1, object oSubject2 )
{
int iGE1 = GetAlignmentGoodEvil(oSubject1);
int iGE2 = GetAlignmentGoodEvil(oSubject2);
int iCL1 = GetAlignmentLawChaos(oSubject1);
int iCL2 = GetAlignmentLawChaos(oSubject2);
int iFactor = 0;

if (iGE1==ALIGNMENT_GOOD)
    {
    switch (iGE2)
        {
        case ALIGNMENT_NEUTRAL: iFactor++;break;
        case ALIGNMENT_EVIL: iFactor=iFactor+2;break;
        }
    }
if (iGE1==ALIGNMENT_NEUTRAL)
    {
    switch (iGE2)
        {
        case ALIGNMENT_GOOD: iFactor++;break;
        case ALIGNMENT_EVIL: iFactor++;break;
        }
    }
if (iGE1==ALIGNMENT_EVIL)
    {
    switch (iGE2)
        {
        case ALIGNMENT_NEUTRAL: iFactor++;break;
        case ALIGNMENT_GOOD: iFactor=iFactor+2;break;
        }
    }
if (iCL1==ALIGNMENT_LAWFUL)
    {
    switch (iCL2)
        {
        case ALIGNMENT_NEUTRAL: iFactor++;break;
        case ALIGNMENT_CHAOTIC: iFactor=iFactor+2;break;
        }
    }
if (iCL1==ALIGNMENT_NEUTRAL)
    {
    switch (iCL2)
        {
        case ALIGNMENT_LAWFUL: iFactor++;break;
        case ALIGNMENT_CHAOTIC: iFactor++; break;
        }
    }
if (iCL1==ALIGNMENT_CHAOTIC)
    {
    switch (iCL2)
        {
        case ALIGNMENT_NEUTRAL: iFactor++;break;
        case ALIGNMENT_LAWFUL: iFactor=iFactor+2;break;
        }
    }
return iFactor;
}
////////////////////////////////////new function//////////////////////////////////////////
void AdjustFactionRep(object oTargetCreature, object oMemberOfSourceFaction, int nAdjustment)
{
    object oFaction = GetFirstFactionMember(oTargetCreature);
    while(GetIsObjectValid(oFaction))
    {
        AdjustReputation(oTargetCreature, oMemberOfSourceFaction, nAdjustment);
        oFaction = GetNextFactionMember(oTargetCreature);
    }
    AdjustReputation(oTargetCreature, oMemberOfSourceFaction, nAdjustment);
}
//////////////////////////////////////new function////////////////////////////////////////
void SendColorMessage(object oPC, int iColor, string sMessage)
{
string sColor;
switch (iColor)
    {
    case 0: sColor="";break;
    case 1: sColor="<cþ  >";break;
    case 2: sColor="<c þ >";break;
    case 3: sColor="<c þþ>";break;
    case 4: sColor="<c þþ>";break;
    case 5: sColor="<cþ þ>";break;
    case 6: sColor="<cþþ >";break;
    case 7: sColor="<c   >";break;
    case 8: sColor="<c¥  >";break;
    case 9: sColor="<c ¥ >";break;
    case 10: sColor="<c  ¥>";break;
    case 11: sColor="<c ¥¥>";break;
    case 12: sColor="<c¥ ¥>";break;
    case 13: sColor="<c¥¥ >";break;
    case 14: sColor="<c¥¥¥>";break;
    case 15: sColor="<cŒŒŒ>";break;
    case 16: sColor="<cþ¥ >";break;
    case 17: sColor="<cþŒ >";break;
    case 18: sColor="<cÚ¥#>";break;
    case 19: sColor="<cÂ† >";break;
    }
FloatingTextStringOnCreature(sColor+sMessage+"</c>",oPC,FALSE);
}
//////////////////////////////////////new function//////////////////////////////////
void AwardCP( object oPC )
{
object oItem = GetItemPossessedBy(oPC,"widget");
int iCCP = GetLocalInt(oItem,"cp");
int iTeam = GetLocalInt(oItem,"team");
int iHD = GetHitDice(oPC)/3;
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oPC);
int iWIS = GetAbilityModifier(ABILITY_WISDOM,oPC);
int iSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC);
int iINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
int iPer = GetSkillRank(SKILL_PERSUADE,oPC)/5;
int iInt = GetSkillRank(SKILL_INTIMIDATE,oPC)/5;
int iBlf = GetSkillRank(SKILL_BLUFF,oPC)/5;
int iLAW = GetAlignmentLawChaos(oPC);
int iLB = 0;
if (iLB==ALIGNMENT_LAWFUL) iLB = 1;
int iCB1 = 0;
int iCB2 = 0;
int iCB3 = 0;
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
if (iTeam==1) iCP = iHD+iCHA+iWIS+iCB1+iCB2+iCB3+iPer+iInt+iBlf+iLB;
if (iTeam==2) iCP = iHD+iSTR+iINT+iCB1+iCB2+iCB3+iPer+iInt+iBlf+iLB;
if (iCP<=0) iCP=1;
SetLocalInt(oItem,"cp",iCP+iCCP);
string sCCP = IntToString(iCCP+iCP);
string sCPT = IntToString(iCP);
DelayCommand(1.0f,FloatingTextStringOnCreature("<c þ >+ "+sCPT+" ***** "+sCCP+" Total CP</c>",oPC,FALSE));
}
////////////////////////////////////////new function/////////////////////////////////
void AwardDF( object oPC )
{
object oItem = GetItemPossessedBy(oPC,"widget");
int iCDF = GetLocalInt(oItem,"df");
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

int iDF = iHD+iCHA+iCB1+iCB2+iCB3;
if (iDF<=0) iDF=1;
SetLocalInt(oItem,"df",iDF+iCDF);
string sCDF = IntToString(iCDF+iDF);
string sDF = IntToString(iDF);
DelayCommand(2.5f,FloatingTextStringOnCreature("<c  þ>+ "+sDF+" ***** "+sCDF+" Total DF</c>",oPC,FALSE));
}
void SaveItemToDB(object oItem, object oArea)
{
    string sDoorID = GetLocalString(oArea, "TempArea");
    int iObjectCount = GetCampaignInt("hh_property", sDoorID + "ItemCount");
    iObjectCount++;
    if (iObjectCount < 1) iObjectCount = 1;
    string sObjectCount = IntToString(iObjectCount);
    SetCampaignInt("hh_property", sDoorID + "ItemCount", iObjectCount);
    SetLocalInt(oItem, "index", iObjectCount);
    StoreCampaignObject("hh_property", sDoorID + sObjectCount, oItem);
    SetCampaignVector("hh_property", sDoorID + sObjectCount + "position", GetPosition(oItem));
    SetCampaignFloat("hh_property", sDoorID + sObjectCount + "facing", GetFacing(oItem));
    SendMessageToPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oItem), sObjectCount + " items in location.");
}
void TeamXP(int iTeam,int iXP)
{
object oPC = GetFirstPC();
object oItem = GetItemPossessedBy(oPC,"pc_info");
int iSide = GetLocalInt(oItem,"team");
while (oPC!=OBJECT_INVALID)
    {
    if (iTeam==iSide) GiveXPToCreature(oPC,iXP);
    oPC = GetNextPC();
    }
}
void TeamXPArea(int iTeam,int iXP,object oArea)
{
object oPC = GetFirstPC();
object oItem = GetItemPossessedBy(oPC,"pc_info");
int iSide = GetLocalInt(oItem,"team");
object oCurArea = GetArea(oPC);
while (oPC!=OBJECT_INVALID)
    {
    if (iTeam==iSide&&oCurArea==oArea) GiveXPToCreature(oPC,iXP);
    oPC = GetNextPC();
    }
}
void CreateItemVoid(object oTarget,string sResref)
{
CreateItemOnObject(sResref,oTarget);
}
int GetIsSharpWeapon(object oItem)
{
int iType = GetBaseItemType(oItem);
if (iType==4||iType==5||iType==9||iType==28||iType==32||iType==35||iType==37||
    iType==47||iType==50||iType==45||iType==6||iType==7||iType==11||iType==8||
    iType==61||iType==111||iType==304||iType==308||iType==317||iType==318)
    return FALSE;
    else return TRUE;
}
int AwardMana(object oPC)
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
int iEnchSkill = GetLocalInt(oItem,"Enchanting");
int iTotal;
iTotal = (iWiz*3)+(iSor*2)+(iBard*2)+iCleric+iDruid+(iAA*2)+iBG+iCoT+iRDD+(iHS*2)
+iPally+(iPM*2)+iRgr+iShft+iSCRank+iInt+iEnchSkill+iHD+1;
if (iESorc==1) iTotal+=3;
if (iEWiz==1) iTotal+=10;
if (iEnch==1) iTotal+=3;
if (iGEnch==1) iTotal+=6;
if (iEEnch==1) iTotal+=9;
if (iMD==1) iTotal+=5;
int iResult = (iTotal*iTotal)*5;
AssignCommand(oPC,SpeakString("I can enchant an item of up to "+IntToString(iResult)+" GP value.",TALKVOLUME_TALK));
return iResult;
}
//void main(){}



