#include "x3_inc_horse"
void main()
{
object oPC = GetItemActivator();
int iPheno =  GetPhenoType(oPC);
object oWidget = GetItemPossessedBy(oPC,"widget");
int iMounted = GetLocalInt(oWidget,"mounted");
int iHorse = GetLocalInt(oPC,"horsenum");
int iApp = GetAppearanceType(oPC);
int iAllow;
if (iApp==APPEARANCE_TYPE_ELF||iApp==APPEARANCE_TYPE_DWARF||iApp==APPEARANCE_TYPE_GNOME||
iApp==APPEARANCE_TYPE_HUMAN||iApp==APPEARANCE_TYPE_HALF_ELF||iApp==APPEARANCE_TYPE_HALF_ORC||
iApp==APPEARANCE_TYPE_HALFLING) iAllow = TRUE;
if (iAllow!=TRUE)
    {
    FloatingTextStringOnCreature("<cþ  >The mount is terrified of you.</c>",oPC,0);
    return;
    }
if (iHorse == 0)
    {
    iHorse = Random(79)+16;
    SetLocalInt(oPC,"horsenum",iHorse);
    }
// toggle mounted
if (iMounted==0) SetLocalInt(oWidget,"mounted",1);
else SetLocalInt(oWidget,"mounted",0);
//if not mounted do this:
if (iMounted==0)
    {
    if (iPheno == PHENOTYPE_BIG) SetPhenoType(HORSE_PHENOTYPE_MOUNTED_L,oPC);
    else SetPhenoType(HORSE_PHENOTYPE_MOUNTED_N,oPC);
    int iRide = GetSkillRank(SKILL_RIDE,oPC,FALSE) + d20();
    effect eRide = EffectMovementSpeedIncrease(30+iRide);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eRide,oPC);
    SetCreatureTailType(iHorse,oPC);
    }
if (iMounted==1)
    {
    if (iPheno == HORSE_PHENOTYPE_MOUNTED_L) SetPhenoType(PHENOTYPE_BIG,oPC);
    else SetPhenoType(PHENOTYPE_NORMAL,oPC);
    SetCreatureTailType(0,oPC);
    }
}
