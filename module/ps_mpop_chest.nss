#include "nw_o2_coninclude"
void SelfDestruct(object oChest)
{
if (GetFirstItemInInventory(oChest) == OBJECT_INVALID)
    {
    DestroyObject(oChest);
    }

}

void main()
{
if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
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
        if (nGiveGold > 0) CreateItemOnObject("nw_it_gold001",OBJECT_SELF,nGiveGold);
        }
    }

string sTreasureType = GetLocalString(OBJECT_SELF,"TT");
int nPlace = 0;
nCount = 0;
int nPick;
int nTarget;
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
        oScan = GetFirstItemInInventory(oChest);
        nCount = 0;
        while (oScan != OBJECT_INVALID)
            {
            nCount ++;
            oScan = GetNextItemInInventory(oChest);
            }
        nPick = Random(nCount) + 1;
        nCount = 1;
        oScan = GetFirstItemInInventory(oChest);
        while (oScan != OBJECT_INVALID)
            {
            if (nCount == nPick)
                {
                if ((GetLocalInt(oScan,"Unique") == 1) || (GetLocalInt(oScan,"QUEST") == 1))
                    {
//                    AssignCommand(oChest,ActionGiveItem(oScan,oSelf));
                    AssignCommand(oSelf,ActionTakeItem(oScan,oChest));
//                    DestroyObject(oScan);
                    SetLocalInt(GetModule(),"TreasureChange",TRUE);
                    }
                else CopyItem(oScan,oSelf,TRUE);
                break;
                }
            nCount ++;
            oScan = GetNextItemInInventory(oChest);
            }
        }
    nPlace = nPlace + 8;
    sCurrent = GetSubString(sTreasureType,nPlace,7);
    }
SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
DelayCommand(0.5,SelfDestruct(OBJECT_SELF));
int nLock = GetLocalInt(OBJECT_SELF,"LOCK");
int nTrap = GetLocalInt(OBJECT_SELF,"TRAP");
if (nLock != 0)
    {
    if (d100() <= nLock) SetLocked(OBJECT_SELF,1);
    else SetLocked(OBJECT_SELF,0);
    }
if (nTrap != 0)
    {
    if (d100() <= nTrap) SetTrapActive(OBJECT_SELF,1);
    else
    {
    SetTrapActive(OBJECT_SELF,0);
    SetTrapDetectable(OBJECT_SELF,FALSE);
    SetTrapRecoverable(OBJECT_SELF,FALSE);
    }
    }

//ShoutDisturbed();

}
