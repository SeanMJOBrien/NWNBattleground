#include "spawn_functions"
void AreaCleanup(object oArea)
{
//SendMessageToAllDMs("AreaCleanup Initiated...");
object oItem;
string sTag;
string sParse;
string sPops = GetLocalString(GetModule(),"POPS");
int nCount;
object oTreasureType;
object oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    if (GetIsPC(oScan)) return;
    oScan = GetNextObjectInArea(oArea);
    }
oScan = GetFirstObjectInArea(oArea);
while (oScan != OBJECT_INVALID)
    {
    sTag = GetStringUpperCase(GetSubString(GetTag(oScan),0,4));
//    SendMessageToAllDMs("Processing "+GetName(oScan)+": "+sTag);
    if (GetHasInventory(oScan))
        {
        oTreasureType = GetObjectByTag(sTag+"_TT");
        oItem = GetFirstItemInInventory(oScan);
        while (oItem != OBJECT_INVALID)
            {
            if (((GetLocalInt(oItem,"Unique"))
                || (GetLocalInt(oItem,"QUEST")))
                && (oTreasureType != OBJECT_INVALID))
                    AssignCommand(oTreasureType,ActionTakeItem(oItem,oScan));
//            else if ((GetObjectType(oScan) != OBJECT_TYPE_CREATURE) ||
//            (GetObjectType(oScan) != OBJECT_TYPE_STORE)) DestroyObject(oItem);
            oItem = GetNextItemInInventory(oScan);
            }
        }

    if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
        && (GetMaster(oScan) == OBJECT_INVALID))
        {
        oTreasureType = GetObjectByTag(sTag+"_TT");
        for (nCount = 0; nCount <= 17; nCount ++)
            {
            oItem = GetItemInSlot(nCount, oScan);

            if (oItem != OBJECT_INVALID)
                {
                if (((GetLocalInt(oItem,"Unique"))
                   || (GetLocalInt(oItem,"QUEST")))
                    && (oTreasureType != OBJECT_INVALID))
                        AssignCommand(oTreasureType,ActionTakeItem(oItem,oScan));
                }
            }
        }
//    if (GetLocalInt(oScan,"DELETE"))
//        {
//        SetIsDestroyable(TRUE,FALSE,FALSE);
//        DelayCommand(5.0,DestroyObject(oScan));
//        }
     if ((GetObjectType(oScan) == OBJECT_TYPE_CREATURE)
            || (GetObjectType(oScan) == OBJECT_TYPE_PLACEABLE))
        {
        nCount = 0;
        sParse = GetSubString(sPops,nCount,4);
        while (sParse != "")
            {
//            SendMessageToAllDMs("sParse= "+sParse);
            if (sTag == sParse)
                {
//                SendMessageToAllDMs("Deleting "+sTag+"...");
//                SetIsDestroyable(TRUE,FALSE,FALSE);
                DelayCommand(5.0,DestroyObject(oScan));
                break;
                }
            nCount = nCount + 5;
            sParse = GetSubString(sPops,nCount,4);
            }
        }
    if ((GetObjectType(oScan) == OBJECT_TYPE_WAYPOINT)
        && (GetSubString(GetName(oScan),0,2) == "SP"))
        {
//        SendMessageToAllDMs("Reset "+GetTag(oScan)+"...");
        SetLocalInt(oScan, "SpawnDeactivated", FALSE);
        SetLocalInt(oScan, "ChildrenSpawned", 0);
        SetLocalInt(oScan, "CurrentProcessTick", 0);
        SetLocalInt(oScan, "SpawnAgeTime", 0);
        }
    oScan = GetNextObjectInArea(oArea);
    }
}


void main()
{
    if ((GetIsPC(GetExitingObject()))
        || (GetIsDM(GetExitingObject())))
        DelayCommand(120.0,AreaCleanup(GetArea(OBJECT_SELF)));
    Spawn_OnAreaExit();
    object oPC = GetExitingObject();
object oBoard = GetNearestObjectByTag("ps_dartboard");
int iCounter;
int nCount = 0;
int nNumber = 0;
object oBuffer;
object oCounter;
for (iCounter = 1; iCounter < 9; iCounter++)
    {
    oCounter = GetLocalObject(OBJECT_SELF,"oPlayer"+IntToString(iCounter));
    if (oCounter != OBJECT_INVALID) nCount++;
    }
object oScan = GetFirstItemInInventory(oPC);;
    while (oScan != OBJECT_INVALID)
        {
        if (GetTag(oScan) == "ps_gamedarts") DestroyObject(oScan);
        oScan = GetNextItemInInventory(oPC);
        }
    if (nCount == 0) return;
        for (iCounter = 1; iCounter < 9; iCounter++)
            {
            oCounter = GetLocalObject(OBJECT_SELF,"oPlayer"+IntToString(iCounter));
            if (oCounter == oPC)
              {
                DeleteLocalInt(oCounter,"iScore");
                nNumber = iCounter;
                nCount -= 1;
                SetLocalInt(OBJECT_SELF,"iNextPlayer",GetLocalInt(OBJECT_SELF,"iNextPlayer")-1);
                AssignCommand(oBoard,SpeakString(GetName(oPC)+" has forfeit their game by leaving the parlor."));
                break;
               }
             }
       for (iCounter = nNumber; iCounter < 9; iCounter ++)
            {
            oBuffer = GetLocalObject(OBJECT_SELF,"oPlayer"+IntToString(iCounter+1));
            SetLocalObject(OBJECT_SELF,"oPlayer"+IntToString(iCounter),oBuffer);
            }
       if (nCount == 0)
            {
            SetLocalInt(OBJECT_SELF,"iDartGame",0);
            SetLocalInt(OBJECT_SELF,"iNextPlayer",1);
            SetLocalInt(OBJECT_SELF,"iToss",1);
            SetLocalInt(OBJECT_SELF,"iRound",1);
            if (GetLocalInt(OBJECT_SELF,"iSummoned") > 0)
                {
                for (iCounter = 1; iCounter < 9; iCounter ++)
                    {
                    oCounter = GetLocalObject(OBJECT_SELF,"oPlayer"+IntToString(iCounter));
                    if ((GetIsPC(oCounter) != TRUE) & (GetTag(oCounter) == "ps_dartkobold"))
                        {
                        location lSummon = GetLocation(oCounter);
                        effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
                        float fDelay = IntToFloat(d4(2)) * 0.3;
                        DelayCommand(fDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lSummon));
                        DelayCommand(fDelay,DestroyObject(oCounter,0.5));
                        DelayCommand(fDelay,SetCommandable(FALSE,oCounter));
                        SetLocalInt(OBJECT_SELF,"iSummoned", GetLocalInt(OBJECT_SELF,"iSummoned")-1);
                        }
                    }
                }

            }

}
