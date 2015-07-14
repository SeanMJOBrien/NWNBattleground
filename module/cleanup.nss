void main()
{
object oOwner = GetItemPossessor(OBJECT_SELF);
if (GetIsObjectValid(oOwner)==TRUE) return;
AssignCommand(OBJECT_SELF,DestroyObject(OBJECT_SELF));
}
