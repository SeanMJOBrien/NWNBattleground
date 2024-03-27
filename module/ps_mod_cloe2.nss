#include "ps_timestamp"
#include "ps_mod_data"
void Confiscate(object oPC)
{
object oScan;
if ((GetXP(oPC) == 0) && (!GetIsDM(oPC)))
    {
    oScan = GetFirstItemInInventory(oPC);
    while (oScan != OBJECT_INVALID)
        {
        DestroyObject(oScan);
        oScan = GetNextItemInInventory(oPC);
        }
    object oConfiscate = GetObjectByTag("CONFISCATE");
    object oStore = GetObjectByTag("PS_LOADSTORE");
    AssignCommand(oConfiscate,TakeGoldFromCreature(GetGold(oPC),oPC,TRUE));
//    AssignCommand(oConfiscate,GiveGoldToCreature(oPC,30));
    CreateItemOnObject("dmfi_pc_follow",oPC);
    CreateItemOnObject("dmfi_pc_dicebag",oPC);
    CreateItemOnObject("dmfi_pc_emote",oPC);
    CreateItemOnObject("ps_hardtac",oPC);
    CreateItemOnObject("nw_wswdg001",oPC);
    CreateItemOnObject("ps_hardtac",oPC);
//    CreateItemOnObject("ps_hardtac",oPC);
//    SetCommandable(FALSE,oPC);
//    DelayCommand(7.0,SetCommandable(TRUE,oPC));
//    DelayCommand(6.0,OpenStore(oStore,oPC));
//    DelayCommand(8.0,OpenInventory(oPC,oPC));
    }
}

void main()
{
//SpawnScriptDebugger();
object oPC = GetEnteringObject();
object oStores = GetObjectByTag("ps_warehouse");
int nNumber;
string sCRef;
DeleteTimeStamp(oPC,9);
DeleteTimeStamp(oPC,5);
AddJournalQuestEntry("Mechanic1",1,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Mechanic2",1,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Mechanic3",1,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Mechanic4",1,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Mechanic5",1,oPC,FALSE,FALSE,FALSE);
//AddJournalQuestEntry("Mechanic7",1,oPC,FALSE,FALSE,FALSE);
LoadTime(oPC);
DelayCommand(1.0,Confiscate(oPC));
TimeStamp(oPC,5);
PrintString(SayLogTime()+" "+GetName(oPC)+" logged on.");
}
