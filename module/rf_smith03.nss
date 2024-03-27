int StartingConditional()
{
object oContainer = GetLocalObject(GetPCSpeaker(),"Container");
string sChoose = IntToString(GetLocalInt(GetPCSpeaker(),"CraftChoose"));
object oItem = GetLocalObject(oContainer,"Item"+ sChoose);
string sSay = "";
int nMonths = 0;
int nDays = 0;
int nHours = 0;
int nCraftMultiplier = GetLocalInt(GetModule(),"CraftMultiplier");
if (nCraftMultiplier == 0) nCraftMultiplier = 10;
int nValue = GetGoldPieceValue(oItem);
//SendMessageToPC(GetPCSpeaker(),"Tag of oItem :"+GetTag(oItem));
//SendMessageToPC(GetPCSpeaker(),"sChooose :"+sChoose);

//SendMessageToPC(GetPCSpeaker(),"CraftMultipier ="+IntToString(nCraftMultiplier));

nHours = FloatToInt((IntToFloat(nValue) / IntToFloat(nCraftMultiplier)) * 24.0);
//SendMessageToPC(GetPCSpeaker(),"nHours ="+IntToString(nHours));
if (nHours == 0) nHours = 1;
        while (nHours > 23)
            {
            nHours = nHours - 24;
            nDays++;
            }
        while (nDays > 27)
            {
            nDays = nDays - 28;
            nMonths ++;
            }
        if ((nMonths == 0) && (nDays == 0) && (nHours > 0))
            {
            sSay = IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths == 0) && (nDays > 0) && (nHours == 0))
            {
            sSay = IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays == 0) && (nHours == 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays > 0) && (nHours == 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays == 0) && (nHours > 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths == 0) && (nDays > 0) && (nHours > 0))
            {
            sSay = IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
        else if ((nMonths > 0) && (nDays > 0) && (nHours > 0))
            {
            sSay = IntToString(nMonths)+" month";
            if (nMonths > 1) sSay = sSay+"s";
            sSay = sSay+", "+IntToString(nDays)+" day";
            if (nDays > 1) sSay = sSay+"s";
            sSay = sSay+" and "+IntToString(nHours)+" hour";
            if (nHours > 1) sSay = sSay+"s";
            }
    SetCustomToken(302,sSay);
    return TRUE;
    }
