void main()//every 30 seconds will cull the inventory of the store
{
    object oItem = GetFirstItemInInventory();
    int iDone = GetLocalInt(OBJECT_SELF,"done");
    int iRoll;
    int iItems = 0;

    if (iDone==1) return;

    while(oItem != OBJECT_INVALID)
        {
        iRoll = d4();
        iItems++;
        if (iRoll==1)//sell items off chance
            {
            int iValue = GetGoldPieceValue(oItem)/12;
            int iGold = GetStoreGold(OBJECT_SELF);
            if (GetPlotFlag(oItem)==FALSE)SetStoreGold(OBJECT_SELF,iGold+iValue);
            if (GetPlotFlag(oItem)==FALSE&&GetInfiniteFlag(oItem)==FALSE)DestroyObject(oItem);
            }
        oItem = GetNextItemInInventory();
        }

if (iDone==0)
    {
    SetLocalInt(OBJECT_SELF,"done",1);
    DelayCommand(30.0f,SetLocalInt(OBJECT_SELF,"done",0));
    }
if (iItems<12) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<15) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<20) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<25) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<30) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<35) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<40) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<45) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<50) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<55) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<60) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<65) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<70) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<75) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<80) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<85) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<90) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<95) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<100) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<105) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<110) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<115) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<120) ExecuteScript("store_stocker",OBJECT_SELF);
if (iItems<125) ExecuteScript("store_stocker",OBJECT_SELF);
}
