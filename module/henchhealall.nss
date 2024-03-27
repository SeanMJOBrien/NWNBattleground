

void main()
{
    ClearAllActions();
    SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID);
    ExecuteScript("hench_o0_heal", OBJECT_SELF);
}
