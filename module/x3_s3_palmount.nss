void main()
{
object oPC=OBJECT_SELF;
FloatingTextStringOnCreature("Use the Horse Whistle to summon your mount.",oPC,FALSE);
if (GetItemPossessedBy(oPC,"get_mount")==OBJECT_INVALID)
    {
    CreateItemOnObject("get_mount",oPC);
    }
}
