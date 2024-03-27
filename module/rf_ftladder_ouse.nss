
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

            object oidUser = GetLastUsedBy();
            object oidDest = GetWaypointByTag("RF_FTLADDER");
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
