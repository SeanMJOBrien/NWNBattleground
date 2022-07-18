void main()
{
object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
int iDead = GetIsDead(oPC);
object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);

if (oCloak!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("<cþ  >You cannot fly while wearing a cloak.</c>",oPC,TRUE);
    return;
    }


    if (iDead==TRUE) return;

 if(GetAreaFromLocation(lTarget)!=OBJECT_INVALID&&iDead==FALSE)
 {
effect eFly = EffectDisappearAppear(lTarget,1);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFly,oPC,2.0f);
 }
}
