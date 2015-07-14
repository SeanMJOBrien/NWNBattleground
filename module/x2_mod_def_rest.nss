#include "x3_inc_horse"
void main()
{
object oPC = GetLastPCRested();
int iRest = GetLastRestEventType();
//begin rest script events//////////////////////////////////////////////////////////
if (iRest==REST_EVENTTYPE_REST_STARTED)
    {
    int iRest = GetLocalInt(oPC,"canrest");
    if (iRest==1)
        {
        FloatingTextStringOnCreature("You are not tired enough to rest.",oPC,FALSE);
        AssignCommand(oPC,ClearAllActions());
        return;
        }
    }
if (iRest==REST_EVENTTYPE_REST_CANCELLED)
    {
    AssignCommand(oPC,ClearAllActions());
    return;
    }
if (iRest==REST_EVENTTYPE_REST_FINISHED)
    {
    SetLocalInt(oPC,"canrest",1);
    object oWidget = GetItemPossessedBy(oPC,"widget");
    int iMounted = GetLocalInt(oWidget,"mounted");
    int iPheno =  GetPhenoType(oPC);
    if (iMounted==1)
        {
        if (iPheno == HORSE_PHENOTYPE_MOUNTED_L) SetPhenoType(PHENOTYPE_BIG,oPC);
        else SetPhenoType(PHENOTYPE_NORMAL,oPC);
        SetCreatureTailType(0,oPC);
        SetLocalInt(oWidget,"mounted",0);
        }
    }
}
