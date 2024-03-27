void SendCreature(object oCreature, object oDest)
{
    if(oCreature != OBJECT_INVALID)
    {
        AssignCommand(oCreature, ClearAllActions());
        AssignCommand(oCreature, ActionJumpToObject(oDest,FALSE));
    }
}

void main()
{
    object oidUser;
    object oidDest;
    string sDest;

            oidUser = GetPCSpeaker();
            oidDest = GetObjectByTag("MAPROOM_EXIT");

            AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));
            object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oidUser);
            object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oidUser);
            object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oidUser);
            object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oidUser);
            object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oidUser);

            SendCreature(oAnimal, oidDest);
            SendCreature(oDominated, oidDest);
            SendCreature(oFamiliar, oidDest);
            SendCreature(oHenchman, oidDest);
            SendCreature(oSummoned, oidDest);
}


