void main()
{
object oPC = GetLastOpenedBy();
if (GetIsPC(oPC)==FALSE) return;
int iOpened = GetLocalInt(OBJECT_SELF,"opened");
if (iOpened==TRUE) return;
object oMod = GetModule();
int iHD = GetLocalInt(oMod,"avglevel");
location lWP = GetLocation(GetWaypointByTag("wp_dummychest"));
object oDummy = CreateObject(OBJECT_TYPE_PLACEABLE,"dummychest",lWP);
SetLocalObject(oDummy,"mychest",OBJECT_SELF);
SetLocalInt(oDummy,"mylevel",iHD);
SetLocalInt(OBJECT_SELF,"opened",TRUE);
//create treasure
if (d20()==1) ExecuteScript("create_amulet",oDummy);
if (d4()==1) ExecuteScript("create_gems",oDummy);
if (d20()==1) ExecuteScript("create_arrows",oDummy);
if (d6()==1) ExecuteScript("create_misc",oDummy);
if (d100()==1) ExecuteScript("create_barmor",oDummy);
if (d20()==1) ExecuteScript("create_belt",oDummy);
if (d12()==1) ExecuteScript("create_bolts",oDummy);
if (d20()==1) ExecuteScript("create_boots",oDummy);
if (d20()==1) ExecuteScript("create_bow",oDummy);
if (d20()==1) ExecuteScript("create_bracers",oDummy);
if (d12()==1) ExecuteScript("create_bullets",oDummy);
if (d20()==1) ExecuteScript("create_chshirt",oDummy);
if (d20()==1) ExecuteScript("create_cloak",oDummy);
if (d20()==1) ExecuteScript("create_gloves",oDummy);
if (d20()==1) ExecuteScript("create_helmet",oDummy);
if (d20()==1) ExecuteScript("create_hide",oDummy);
if (d20()==1) ExecuteScript("create_light",oDummy);
if (d20()==1) ExecuteScript("create_mnkgloves",oDummy);
if (d20()==1) ExecuteScript("create_mnkrobe",oDummy);
if (d20()==1) ExecuteScript("create_plate",oDummy);
if (d6()==1) ExecuteScript("create_potion",oDummy);
if (d12()==1) ExecuteScript("create_ring",oDummy);
if (d20()==1) ExecuteScript("create_robe",oDummy);
if (d20()==1) ExecuteScript("create_sbow",oDummy);
if (d20()==1) ExecuteScript("create_shield",oDummy);
if (d20()==1) ExecuteScript("create_sling",oDummy);
if (d20()==1) ExecuteScript("create_staff",oDummy);
if (d20()==1) ExecuteScript("create_thrown",oDummy);
if (d20()==1) ExecuteScript("create_wep_brb",oDummy);
if (d20()==1) ExecuteScript("create_wep_clr",oDummy);
if (d20()==1) ExecuteScript("create_wep_drd",oDummy);
if (d20()==1) ExecuteScript("create_wep_ftr",oDummy);
if (d20()==1) ExecuteScript("create_wep_mnk",oDummy);
if (d20()==1) ExecuteScript("create_wep_rog",oDummy);
if (d20()==1) ExecuteScript("create_xbow",oDummy);
if (d20()==1) ExecuteScript("create_wand",oDummy);
if (d20()==1) ExecuteScript("create_book",oDummy);
if (d10()==1) ExecuteScript("create_scroll",oDummy);
if (d4()==1) ExecuteScript("create_misc",oDummy);
CreateItemOnObject("nw_it_gold001",oDummy,d20(iHD)+d6(3));
//transfer items
DelayCommand(1.0f,ExecuteScript("chest_xfer",oDummy));
//DelayCommand(1.2f,ExecuteScript("unidall",OBJECT_SELF));
DelayCommand(300.0f,SetLocalInt(OBJECT_SELF,"opened",FALSE));
}
