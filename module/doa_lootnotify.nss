/* place this script in a container's onDisturbed event, edit _cfg_lootnotify */

#include "inc_lootnotify"
void main() {
    object oMod = GetModule();
    /* register with other scripts */
    int bModDebug = GetLocalInt(oMod,"bModDebug");
    if (!GetLocalInt(oMod,"doa_lootnotify")) {
        if (bModDebug) SendMessageToPC(GetFirstPC(),"Registering doa_lootnotify...");
        SetLocalInt(oMod,"doa_lootnotify",1);
    }
    /* exit if null object calling - probably registration */
    if (OBJECT_SELF == OBJECT_INVALID) return;
    /* run */
    object oItem = GetInventoryDisturbItem();
    object oPC = GetLastDisturbed();
    if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED) lootNotify(oItem, oPC);
}
