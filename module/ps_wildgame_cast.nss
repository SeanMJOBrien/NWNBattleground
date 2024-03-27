void main()
{
object oAttacker = GetLastSpellCaster();
int nFleeing = GetLocalInt(OBJECT_SELF,"Fleeing");
    if (!nFleeing)
        {
        SetLocalInt(OBJECT_SELF,"Fleeing",TRUE);
        int nCount = 1;
        float fDistance;
//        object oAttacker = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,OBJECT_SELF);
        object oScan = GetFirstObjectInArea(GetArea(OBJECT_SELF));
        object oWPPick;
        while (oScan != OBJECT_INVALID)
            {
            if (GetSubString(GetTag(oScan),0,3) != "WP_")
                {
                if (GetDistanceBetween(oAttacker,oScan) > fDistance)
                    {
                    fDistance = GetDistanceBetween(oAttacker,oScan);
                    oScan = oWPPick;
                    }
                }
            oScan = GetNextObjectInArea(GetArea(OBJECT_SELF));
            }
        object oWPJump;
        if (GetTag(oWPPick) == "WP_N") oWPJump = GetNearestObjectByTag("WP_S");
        else if (GetTag(oWPPick) == "WP_NE") oWPJump = GetNearestObjectByTag("WP_SW");
        else if (GetTag(oWPPick) == "WP_E") oWPJump = GetNearestObjectByTag("WP_W");
        else if (GetTag(oWPPick) == "WP_SE") oWPJump = GetNearestObjectByTag("WP_NW");
        else if (GetTag(oWPPick) == "WP_S") oWPJump = GetNearestObjectByTag("WP_N");
        else if (GetTag(oWPPick) == "WP_SW") oWPJump = GetNearestObjectByTag("WP_NE");
        else if (GetTag(oWPPick) == "WP_W") oWPJump = GetNearestObjectByTag("WP_E");
        else if (GetTag(oWPPick) == "WP_NW") oWPJump = GetNearestObjectByTag("WP_SE");
        object oPost = GetNearestObjectByTag("POST"+IntToString(d4()));
        ClearAllActions(TRUE);
        ActionMoveToObject(oWPPick,TRUE,2.0);
        ActionJumpToObject(oWPJump,FALSE);
        ActionDoCommand(DeleteLocalInt(OBJECT_SELF,"Fleeing"));
        ActionMoveToObject(oPost,FALSE,3.0);

        }
}
