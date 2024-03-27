int StartingConditional()
{
string sSay;
if (GetLocalInt(GetModule(),"MPOP_disable") == 1)
    sSay = "Enable daily processing.";
else sSay = "Disable daily processing.";
SetCustomToken(403,sSay);
return TRUE;
}
