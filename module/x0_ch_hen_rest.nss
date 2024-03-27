#include "x0_i0_henchman"
#include "ps_timestamp"

void main()
{

    object oPC = GetLastMaster();
    object oSelf = OBJECT_SELF;
int nLevel = GetLevelByPosition(1,oSelf) + GetLevelByPosition(2,oSelf) + GetLevelByPosition(3,oSelf);
int nHeal = nLevel + GetAbilityModifier(ABILITY_CONSTITUTION,oSelf);
int nMaxHP = GetMaxHitPoints(oSelf);
int nCurrentHP = GetCurrentHitPoints(oSelf);
int nTargetHP;
int nDayBuffer;
int nBestFood = 0; // tagged BESTFOOD
int nGoodFood = 0; // tagged GOODFOOD
int nFood = 0; // tagged FOOD
        int nNumber = FALSE; // TRUE if any food present after scanning.
        object oScan = GetFirstItemInInventory(oSelf);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "BESTFOOD")
                {
                if (GetIsLaterThan(oScan) == 1)
                    {
                    SendMessageToPC(oPC,"Your hireling's "+GetName(oScan)+" has spoiled.");
                    DestroyObject(oScan);
                    //CreateItemOnObject("ps_spoiledfood",oPC);
                    }
                    else
                        {
                        nBestFood ++;
                        nNumber = TRUE;
                        }
                }
            oScan = GetNextItemInInventory(oSelf);
            } // while ...
        oScan = GetFirstItemInInventory(oSelf);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "GOODFOOD")
                {
                if (GetIsLaterThan(oScan) == 1)
                    {
                    SendMessageToPC(oPC,"Your hireling's "+GetName(oScan)+" has spoiled.");
                    DestroyObject(oScan);
                    //CreateItemOnObject("ps_spoiledfood",oPC);
                    }
                    else
                        {
                        nGoodFood ++;
                        nNumber = TRUE;
                        }
                }
            oScan = GetNextItemInInventory(oSelf);
            } // while ...
        oScan = GetFirstItemInInventory(oSelf);
        while (oScan != OBJECT_INVALID)
            {
            if (GetTag(oScan) == "FOOD")
                {
                nFood ++;
                nNumber = TRUE;
                }
            oScan = GetNextItemInInventory(oSelf);
            } // while ...

        if (nNumber == FALSE) // PC has no food!
            {
            AssignCommand(oSelf,ClearAllActions());
            SendMessageToPC(oPC,"Your henchman doesn't have any food.");
            return;
            }
        else if (((nMaxHP - nCurrentHP) > (nHeal * 2)) && (nBestFood > 0))
            {
            // PC has best food and could use it
            SetLocalObject(oSelf,"RestFood",GetItemPossessedBy(oSelf,"BESTFOOD"));
            }
        else if (((nMaxHP - nCurrentHP) > (nHeal)) && (nGoodFood > 0))
            {
            // PC has good food and could use it.
            SetLocalObject(oSelf,"RestFood",GetItemPossessedBy(oSelf,"GOODFOOD"));
            }
        else if (nFood > 0)
            {
            SetLocalObject(oSelf,"RestFood",GetItemPossessedBy(oSelf,"FOOD"));
            }
        else if (nGoodFood > 0)
            { // PC doesn't need good food but that's what is available
            SetLocalObject(oSelf,"RestFood",GetItemPossessedBy(oSelf,"GOODFOOD"));
            }
        else if (nBestFood > 0)
            { // PC doesn't need best food but that's what's available
            SetLocalObject(oSelf,"RestFood",GetItemPossessedBy(oSelf,"BESTFOOD"));
            }
        SetLocalInt(oSelf,"RestHP",nCurrentHP);
}
