

void main()
{    
    ClearAllActions();
    SetLocalInt(OBJECT_SELF, "X2_BUFFING_TYPE", 3);
    SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker()));
    ExecuteScript("hench_o0_enhanc", OBJECT_SELF);
}
