void main()
{
effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
SetLocalInt(GetArea(OBJECT_SELF),"iSummoned",GetLocalInt(GetArea(OBJECT_SELF),"iSummoned")+1);
location lSummon = GetLocation(GetWaypointByTag("ps_dartsummon"+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iSummoned"))));
int iCounter;
object oCounter;
object oCreate;
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lSummon);
oCreate = CreateObject(OBJECT_TYPE_CREATURE,"ps_dartkobold02",lSummon,FALSE);
for (iCounter = 1; iCounter < 9; iCounter ++)
    {
    oCounter = GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iCounter));
    if (oCounter == OBJECT_INVALID)
        {
        SetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iCounter),oCreate);
        SpeakString(GetName(oCreate)+" is now player "+IntToString(iCounter)+".");
        return;
        }
    }
}
