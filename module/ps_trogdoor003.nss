void main()
{
object oPC = GetLastUnlocked();
object oKey = GetItemPossessedBy(oPC,"ps_trogkey001");
if (oKey != OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("The wooden key snaps.",oPC,FALSE);
    DestroyObject(oKey,0.0);
    }
DelayCommand(30.0,SetLocked(OBJECT_SELF,TRUE));
}
