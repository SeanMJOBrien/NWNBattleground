void main()
{
object oPC = GetPCSpeaker();
object oWidget =  GetItemPossessedBy(oPC,"widget");
int iSkin = GetLocalInt(oWidget,"skin");
int iHair = GetLocalInt(oWidget,"hair");
int iHead = GetLocalInt(oWidget,"head");
int iPheno = GetLocalInt(oWidget,"pheno");
int iApp = GetLocalInt(oWidget,"app");
      SetColor(oPC,COLOR_CHANNEL_SKIN,iSkin);
      SetColor(oPC,COLOR_CHANNEL_HAIR,iHair);
      SetCreatureBodyPart(CREATURE_PART_HEAD,iHead,oPC);
      SetPhenoType(iPheno,oPC);
      SetCreatureAppearanceType(oPC,iApp);
      SetLocalInt(oWidget,"subrace",0);
object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
      DeleteLocalInt(oPC,"racechoice");
if (oHide!=OBJECT_INVALID) DestroyObject(oHide);
}
