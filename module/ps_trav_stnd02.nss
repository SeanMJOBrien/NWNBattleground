void main()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
string sRoute = GetSubString(sTravel,0,4);
object oTravelDest = GetWaypointByTag(sRoute+"_TRAVELDEST");
object oMPOP = GetNearestObjectByTag("MPOP",oTravelDest);
object oStandard = GetItemPossessedBy(oPC,"SHLD_STANDARD");
int nCount = 1;
string sPopScan;
int nSHLDStr;
int nStandardStr;
if (oMPOP == OBJECT_INVALID)
    {
    oMPOP = GetNearestObjectByTag("MPOP",GetWaypointByTag(GetTag(GetArea(oTravelDest))));
    }
if ((oMPOP != OBJECT_INVALID) && (oStandard != OBJECT_INVALID))
    {
    nStandardStr = GetLocalInt(oStandard,"FORCE");
    sPopScan = GetLocalString(oMPOP, "Pop"+IntToString(nCount));
    while ((GetSubString(sPopScan,0,4) != "SHLD"))
        {
        if (sPopScan == "") break;
        nCount ++;
        sPopScan = GetLocalString(oMPOP, "Pop"+IntToString(nCount));
        }
    if (GetSubString(sPopScan,0,4) == "SHLD")
        {
        nSHLDStr = StringToInt(GetSubString(sPopScan,5,3)) + nStandardStr;
//        DeleteLocalInt(oStandard,"FORCE");
        DestroyObject(oStandard);
        }
    else if (sPopScan == "")
        {
        SetLocalString(oMPOP,"Pop"+IntToString(nCount),"SHLD_"+IntToString(nStandardStr));
        DestroyObject(oStandard);
        }
    }
}
