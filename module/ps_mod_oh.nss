void LootPC(object oLooter, object oPC)
{
//SpawnScriptDebugger();
object oScan;
int nValue;
int nMaxValue;
int nCount;
object oTake;
int nRoll = d4(1);
SetLocalInt(GetModule(),"TreasureChange",TRUE);
object oTreasureType = GetObjectByTag(GetStringUpperCase(GetSubString(GetTag(oLooter),0,4))+"_TT");
if ((oTreasureType != OBJECT_INVALID) && (!GetIsInCombat(oLooter)) && (GetDistanceBetween(oLooter,oPC) <= 5.0) && (GetLocalInt(oPC,"Dead") == 1))
    {
    nValue = GetGold(oPC) / 2;
    AssignCommand(oLooter, TakeGoldFromCreature(nValue,oPC));
    while (nRoll != 0)
        {
        oScan = GetFirstItemInInventory(oPC);
        nValue = GetGoldPieceValue(oScan);
        nMaxValue = 0;
        while (oScan != OBJECT_INVALID)
            {
            if  ((nValue > nMaxValue) && (!GetLocalInt(oScan,"Flagged")))
                {
                oTake = oScan;
                nMaxValue = nValue;
                }

            oScan = GetNextItemInInventory(oPC);
            nValue = GetGoldPieceValue(oScan);
            }
        for (nCount = 0; nCount <= 17; nCount ++)
            {
            oScan = GetItemInSlot(nCount, oPC);
            if (oScan != OBJECT_INVALID)
                {
                nValue = GetGoldPieceValue(oScan);
                if ((nValue > nMaxValue) && (!GetLocalInt(oScan,"Flagged")))
                    {
                    oTake = oScan;
                    nMaxValue = nValue;
                    }
                }
            }
        if (oTake != OBJECT_INVALID)
            {
            SetLocalInt(oTake,"Flagged",1);
            AssignCommand(oTreasureType,ActionTakeItem(oTake,oPC));
            AssignCommand(oTreasureType,ActionDoCommand(DeleteLocalInt(oTake,"Flagged")));
            SetLocalInt(oTake,"Unique",1);
            }
        nRoll = nRoll - 1;
        }
    DestroyObject(oLooter);
    }
}

void main()
{
object oPC = GetFirstPC();
int nDead;
object oScan;
int nCount;
while (oPC != OBJECT_INVALID)
    {
    nDead = GetLocalInt(oPC,"Dead");
    if ((nDead == 1) && (GetLocalInt(oPC,"Looted") == 0))
       {
       nCount = 1;
       oScan = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nCount,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
       while ((GetLocalInt(oScan,"Looter") != 1) || (GetIsInCombat(oScan)) || (!GetObjectSeen(oScan,oPC)))
            {
            oScan = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nCount,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
            if (oScan == OBJECT_INVALID) break;
            nCount ++;
            }
       if (oScan != OBJECT_INVALID)
            {
            SetLocalInt(oPC,"Looted",1);
            DeleteLocalInt(oScan,"Looter");
            AssignCommand(oScan,ClearAllActions(TRUE));
            AssignCommand(oScan,ActionMoveToObject(oPC,TRUE,1.0));
            AssignCommand(oScan,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,20.0));
            AssignCommand(oScan,ActionWait(2.0));
            AssignCommand(oScan,ActionDoCommand(LootPC(oScan,oPC)));
            DelayCommand(30.0,DeleteLocalInt(oPC,"Looted"));
            }
        }
    oPC = GetNextPC();
    }
}
