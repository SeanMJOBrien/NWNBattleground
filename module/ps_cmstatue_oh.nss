void SendCreature(object oCreature, object oDest)
{
    if(oCreature != OBJECT_INVALID)
    {
        AssignCommand(oCreature, ClearAllActions());
        AssignCommand(oCreature, ActionJumpToObject(oDest,FALSE));
    }
}
void SendTarget(object oTarget, object oDest)
{
            object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oTarget);
            object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oTarget);
            object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oTarget);
            object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget);
            object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget);

            SendCreature(oTarget,oDest);
            SendCreature(oAnimal, oDest);
            SendCreature(oDominated, oDest);
            SendCreature(oFamiliar, oDest);
            SendCreature(oHenchman, oDest);
            SendCreature(oSummoned, oDest);

}
void main()
{
int nNumber = 1;
object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nNumber);
while (oTarget != OBJECT_INVALID)
{
if ((GetDistanceToObject(oTarget) <= 7.0)
    && (GetDistanceToObject(oTarget) != -1.0))
    {
    int nSave = ReflexSave(oTarget,18);
    int nMiss;
    if (nSave == 0) nMiss = FALSE;
    else nMiss = TRUE;
    effect eBeam = EffectBeam(VFX_BEAM_EVIL,OBJECT_SELF,BODY_NODE_CHEST,nMiss);
    effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
    object oDest = GetWaypointByTag("CMPORT"+IntToString(d6()));
    location lTarget = GetLocation(oTarget);
    float fDelay = IntToFloat(d10()) * 0.1;
    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0));
    if (nMiss == FALSE)
        {
        DelayCommand((fDelay+2.25),SendTarget(oTarget,oDest));
        DelayCommand((fDelay+2.5),ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lTarget));
        DelayCommand((fDelay+2.5),ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,GetLocation(oDest)));
        }
    }
nNumber ++;
oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nNumber);
}
}
