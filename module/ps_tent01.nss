void main()
{
object oPC = GetLastUsedBy();
//FloatingTextStringOnCreature(GetName(oPC)+" packs up the tent.",oPC,TRUE);
PlaySound("as_sw_clothcl1");
CreateItemOnObject("ps_tentit",oPC);
AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0));
DestroyObject(OBJECT_SELF);
}
