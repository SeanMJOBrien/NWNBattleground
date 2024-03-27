void main()
{
int nExplode;
location lSelf = GetLocation(OBJECT_SELF);
object oScan = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lSelf);
if (!GetLocalInt(OBJECT_SELF,"Destroyed"))
{
while (oScan != OBJECT_INVALID)
    {
    if (GetIsPC(oScan))
        {
        if ((GetActionMode(oScan,ACTION_MODE_STEALTH)) && ((d20() + GetSkillRank(SKILL_MOVE_SILENTLY,oScan) + GetAbilityModifier(ABILITY_DEXTERITY,oScan)) >= 5))
            {
            oScan = GetNextObjectInShape(SHAPE_SPHERE,15.0,lSelf);
            continue;
            }
        else nExplode = TRUE;
        }
    if (nExplode == TRUE) break;
    oScan = GetNextObjectInShape(SHAPE_SPHERE,15.0,lSelf);
    }
if (nExplode == TRUE)
    {
    location lMush = GetLocation(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),lMush);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HORRID_WILTING),lMush);
    object oScan = GetFirstObjectInShape(SHAPE_SPHERE,20.0,lSelf);
    while (oScan != OBJECT_INVALID)
        {
        if (FortitudeSave(oScan,10,SAVING_THROW_TYPE_POISON) == 0)
            {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSleep(),oScan,(6.0  * IntToFloat(d4())));
            if (GetIsPC(oScan)) SendMessageToPC(oScan,"The spores from the exploding mushrooms rush into your lungs.");
            }
        oScan = GetNextObjectInShape(SHAPE_SPHERE,20.0,lSelf);
        }
    SetLocalInt(OBJECT_SELF,"Destroyed",TRUE);
    DestroyObject(OBJECT_SELF);
    }
}
}
