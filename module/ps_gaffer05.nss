void main()
{
//object oPC = GetLastClosedBy();
object oPC = GetLocalObject(OBJECT_SELF,"OpenedBy");
object oGaffer = GetNearestObjectByTag("rf_gaffer");
object oWalkC = GetNearestObjectByTag("WALKC");
object oStores = GetObjectByTag("CW_WAREHOUSE_STORES");
int nCount;
object oScan;
if (GetFirstItemInInventory(oStores) == OBJECT_INVALID)
    {
    nCount = 1;
    oScan = GetFirstItemInInventory(OBJECT_SELF);
    while (oScan != OBJECT_INVALID)
        {
        StoreCampaignObject("SHIELD_LANDS","WH_"+GetName(oPC)+IntToString(nCount),oScan);
        nCount ++;
        DestroyObject(oScan);
        oScan = GetNextItemInInventory(OBJECT_SELF);
        }
    }
else
    {
    oScan = GetFirstItemInInventory(OBJECT_SELF);
    while (oScan != OBJECT_INVALID)
        {
        ActionGiveItem(oScan,oStores);
        SetLocalObject(oScan,"Owner",oPC);
        oScan = GetNextItemInInventory(OBJECT_SELF);
        }

    }
object oCrate = OBJECT_SELF;
//DestroyObject(oCrate);
SetLocked(oCrate,TRUE);
DelayCommand(2.0,DestroyObject(oCrate));
//AssignCommand(oGaffer,ActionMoveToObject(oCrate,FALSE,0.5));
//AssignCommand(oGaffer,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0));
//AssignCommand(oGaffer,ActionDoCommand(DestroyObject(oCrate)));
//AssignCommand(oGaffer,ActionMoveToObject(oWalkC,FALSE,0.5));
//AssignCommand(oGaffer,ActionDoCommand(SetFacing(GetFacing(oWalkC))));

}
