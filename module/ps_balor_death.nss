//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
        object oMPOP = GetNearestObjectByTag("MPOP",OBJECT_SELF);
        if (oMPOP == OBJECT_INVALID)
            {
            object oSurrogate = GetWaypointByTag(GetTag(GetArea(OBJECT_SELF)));
            oMPOP = GetNearestObjectByTag("MPOP",oSurrogate);
            }
        if (oMPOP != OBJECT_INVALID)
            {
            string sBasePop = GetStringUpperCase(GetSubString(GetTag(OBJECT_SELF),0,4));
//            int nSubtract = GetLocalInt(GetModule(),sBasePop+"_DEATH");
            int nHD = GetHitDice(OBJECT_SELF);
            int nSubtract = nHD * 2;
            if (nSubtract < 2) nSubtract = 2;
            int nCount = 1;
            int nPopStr;
            int nBuffer2; string sBufferD;
            string sSlotScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
            while (sSlotScan != "")
                {
                if (GetSubString(sSlotScan,0,4) == sBasePop)
                    {
                    nPopStr = StringToInt(GetSubString(sSlotScan,5,3));
                    nPopStr -= nSubtract;
                    if (nPopStr <= 0)
                        {
                        DeleteLocalString(oMPOP,"Pop"+IntToString(nCount));
                        for (nBuffer2 = nCount + 1; nBuffer2 < 7; nBuffer2++)
                            {
                            sBufferD = GetLocalString(oMPOP,"Pop"+IntToString(nBuffer2));
                           if (sBufferD != "")
                                {
                                SetLocalString(oMPOP,"Pop"+IntToString(nBuffer2 - 1),sBufferD);
                                DeleteLocalString(oMPOP,"Pop"+IntToString(nBuffer2));
                                break;
                                }
                            }
                        }
                    else
                        {
                        SetLocalString(oMPOP,"Pop"+IntToString(nCount),sBasePop+"_"+IntToString(nPopStr));
                        }
//                    object oPCToHear = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,OBJECT_SELF);
//                    SendMessageToPC(oPCToHear,"Population "+sBasePop+" at MPOP waypoint "+GetName(oMPOP)+" loses "+IntToString(nSubtract)+".");
                    }
                nCount++;
                sSlotScan = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
                }
            }
    ExecuteScript("nw_s3_balordeth", OBJECT_SELF);

}
