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

int iDF = iHD+iCHA+iCB1+iCB2+iCB3;
if (iDF<=0) iDF=1;
SetLocalInt(oPC,"df",iDF+iCDF);
string sCDF = IntToString(iCDF+iDF);
string sDF = IntToString(iDF);
DelayCommand(2.0f,FloatingTextStringOnCreature("<c  þ>+ "+sDF+" ***** "+sCDF+" Total DF</c>",oPC,FALSE));
}
void main()
{
//set up bonus roll
object oPC = GetLastUsedBy();
int iAlign = GetAlignmentGoodEvil(oPC);
int iTeam = GetLocalInt(oPC,"team");
int iAlTeam = GetLocalInt(OBJECT_SELF,"team");
//kick out if at wrong altar
if (iTeam!=iAlTeam)
    {
    FloatingTextStringOnCreature("<cþ  >You are praying at the wrong altar.</c>",oPC);
    return;
    }
//kick out if praying too soon
int iPrayed = GetLocalInt(oPC,"prayed");
if (iPrayed==TRUE)
    {
    FloatingTextStringOnCreature("<cþ  >Your prayers fall on deaf ears. Try again later.</c>",oPC);
    return;
    }
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0f,6.0f));
SetLocalInt(oPC,"prayed",TRUE);
AwardDF(oPC);
int iXP = 1;
int iHD = GetHitDice(oPC);
int iLaw = GetAlignmentLawChaos(oPC);
int iCHA = GetAbilityModifier(ABILITY_CHARISMA,oPC);
int iWIS = GetAbilityModifier(ABILITY_WISDOM,oPC);
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

object oWidget = GetItemPossessedBy(oPC,"widget");
int iFame = GetLocalInt(oWidget,"score");

int iPlus = 0;
if (iFame>10) iPlus+=1;
if (iFame>32) iPlus+=1;
if (iFame>64) iPlus+=1;
if (iFame>128) iPlus+=1;
if (iFame>256) iPlus+=1;
if (iFame>512) iPlus+=1;
if (iFame>1024) iPlus+=1;
if (iFame>2048) iPlus+=1;

iXP = iHD+iCB1+iCB2+iCB3+iCHA+iWIS+iPlus+10;
if (iLaw==ALIGNMENT_LAWFUL) iXP+=1;
if (iXP<=0) iXP=1;
GiveXPToCreature(oPC,iXP);
}
