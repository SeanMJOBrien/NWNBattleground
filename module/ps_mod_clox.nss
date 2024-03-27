void main()
{
object oPC = GetExitingObject();
object oStores = GetObjectByTag("ps_warehouse");
object oScan;
string sFile = "sl_"+GetName(oPC);
int nCount;

int nRaisePenalty = GetLocalInt(oPC,"RaisePenalty");
if (nRaisePenalty != 0) SetCampaignInt(sFile,"RaisePenalty",nRaisePenalty);

int nOnlyPC = TRUE;
oScan = GetFirstPC();
while (oScan != OBJECT_INVALID)
    {
    if (oScan != oPC)
        {
        nOnlyPC = FALSE;
        return;
        }
    oScan = GetNextPC();
    }

if (GetLocalInt(oPC,"Dead") == 1)
    {
    object oCorpse = GetLocalObject(oPC,"Corpse");
    if (oCorpse != OBJECT_INVALID)
        {
        location lCorpse;
        if (GetItemPossessor(oCorpse) != OBJECT_INVALID) lCorpse = GetLocation(GetItemPossessor(oCorpse));
        else lCorpse = GetLocation(oCorpse);
        SetCampaignInt(sFile,"Dead",1);
        SetCampaignLocation(sFile,"CorpseLocation",lCorpse);
        DestroyObject(oCorpse);
        }
    }

nCount = 1;
int nStack;
string sBuffer;
oScan = GetFirstItemInInventory(oStores);
while (oScan != OBJECT_INVALID)
    {
    if (GetLocalString(oScan,"Owner") == GetName(oPC))
        {
        sBuffer = GetResRef(oScan);
        nStack = GetItemStackSize(oScan);
        DestroyObject(oScan);
        SetCampaignString(sFile,"WH"+IntToString(nCount),sBuffer);
        SetCampaignInt(sFile,"WHST"+IntToString(nCount),nStack);
        nCount++;
        }
    oScan = GetNextItemInInventory(oStores);
    }


}
