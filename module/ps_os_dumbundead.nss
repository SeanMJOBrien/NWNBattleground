#include "NW_I0_GENERIC"

//::///////////////////////////////////////////////
//:: Name x2_def_spawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script


    2003-07-28: Georg Zoeller:

    If you set a ninteger on the creature named
    "X2_USERDEFINED_ONSPAWN_EVENTS"
    The creature will fire a pre and a post-spawn
    event on itself, depending on the value of that
    variable
    1 - Fire Userdefined Event 1510 (pre spawn)
    2 - Fire Userdefined Event 1511 (post spawn)
    3 - Fire both events

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"

void HumansUseTorches(object oTarget)
{
object oTorch;
if ((GetRacialType(oTarget) == RACIAL_TYPE_HUMAN)
    && ((GetIsNight()) || (!GetIsAreaAboveGround(GetArea(oTarget)))))
        {
        if ((GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget) == OBJECT_INVALID)
            && (d2() == 1)
            && (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget)) !=  BASE_ITEM_BASTARDSWORD|BASE_ITEM_DIREMACE|BASE_ITEM_DOUBLEAXE|BASE_ITEM_HALBERD|BASE_ITEM_HEAVYFLAIL|BASE_ITEM_LONGBOW|BASE_ITEM_SHORTBOW|BASE_ITEM_LIGHTCROSSBOW|BASE_ITEM_HEAVYCROSSBOW|BASE_ITEM_QUARTERSTAFF|BASE_ITEM_SHORTSPEAR))
            {
            oTorch = CreateItemOnObject("ps_torch01",oTarget,1);
            DelayCommand(0.5,AssignCommand(oTarget,ActionEquipItem(oTorch,INVENTORY_SLOT_LEFTHAND)));
            }
        }
}

void main()
{
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    /*  Fix for the new golems to reduce their number of attacks */

    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }

    // Execute default OnSpawn script.
    ExecuteScript("ps_ai_dumbundead", OBJECT_SELF);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }

// MPOP Treasure Types
//SpawnScriptDebugger();
string sGold = GetLocalString(OBJECT_SELF,"GOLD");
int nRoll;
int nCount = 0;
int nDice;
int nDieType;
int nGiveGold = 0;
if (sGold != "")
    {
    nRoll = Random(100)+1;
    if (nRoll <= StringToInt(GetSubString(sGold,0,2)))
        {
        nDice = StringToInt(GetSubString(sGold,3,1));
        nDieType = StringToInt(GetSubString(sGold,5,2));
        for (nCount = 1; nCount <= nDice; nCount ++)
            {
            nGiveGold = nGiveGold + Random(nDieType) + 1;
            }
        if (nGiveGold > 0) GiveGoldToCreature(OBJECT_SELF,nGiveGold);
        }
    }

string sTreasureType = GetLocalString(OBJECT_SELF,"TT");
int nPlace = 0;
nCount = 0;
int nPick;
int nTarget;
int nInvCount;
object oScan;
object oSelf = OBJECT_SELF;
object oChest;
string sCurrent = GetSubString(sTreasureType,nPlace,7);
while (sCurrent != "")
    {
    nRoll = Random(1000) + 1;
    nTarget = StringToInt(GetSubString(sCurrent,4,3));
    if (nRoll <= nTarget)
        {
        oChest = GetObjectByTag(GetSubString(sCurrent,0,4)+"_TT");
        nInvCount =  GetLocalInt(oChest,"COUNT");
        if (nInvCount == 0)
        {
        oScan = GetFirstItemInInventory(oChest);
        nCount = 0;
        while (oScan != OBJECT_INVALID)
            {
            nCount ++;
            oScan = GetNextItemInInventory(oChest);
            }
        }
        else nCount= nInvCount;
        nPick = Random(nCount) + 1;
        nCount = 1;
        oScan = GetFirstItemInInventory(oChest);
        while (oScan != OBJECT_INVALID)
            {
            if (nCount == nPick)
                {
                CopyItem(oScan,oSelf,TRUE);
                if ((GetLocalInt(oScan,"Unique") == 1) || (GetLocalInt(oScan,"QUEST") == 1))
                    {
//                    AssignCommand(oChest,ActionGiveItem(oScan,oSelf));
//                    AssignCommand(oSelf,ActionTakeItem(oScan,oChest));
//                    SetLocalInt(GetModule(),"TreasureChange",TRUE);
                    DestroyObject(oScan);
                    }
                break;
                }
            nCount ++;
            oScan = GetNextItemInInventory(oChest);
            }
        }
    nPlace = nPlace + 8;
    sCurrent = GetSubString(sTreasureType,nPlace,7);
    }
DelayCommand(0.5,HumansUseTorches(OBJECT_SELF));


}
