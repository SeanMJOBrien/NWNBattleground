/* place this script in a container's onOpen event, edit _cfg_lootnotify */

#include "_cfg_lootnotify"
#include "inc_givewtgold"

int NotifyType;
float NotifyDistance;
int DMNotify;
int EnableHiddenPocket;
int StealthModeType;
int StealthSpotPenalty;
int CombatSpotPenalty;
int SpottedNotifyType;
int AutoDistributeGold;

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
    cfg_LootNotify();

    /* check if enabled, quick exit */
    if (AutoDistributeGold == 0) return;
    else SetLocalInt(oMod,"doa_lootnotify_autogold",AutoDistributeGold);

    object oPC = GetLastOpenedBy(); //GetLastUsedBy();
    object oMember;
    int iAmount, iContinue;

    /* check if in party, quick exit */
    oMember = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oMember)) {
        iContinue++; if (iContinue > 1) break;
        oMember = GetNextFactionMember(oPC);
    }
    if (!bModDebug && iContinue < 2) return;

    /* is there gold to distribute? quick exit */
    iAmount = GetGold(OBJECT_SELF);
    iContinue = FALSE;
    if (iAmount) {
        iContinue = TRUE;
        if (AutoDistributeGold == 3) { // alpha party level setting
            oMember = GetItemPossessedBy(GetFactionLeader(oPC), "doa_pset");
            iContinue = FALSE; // have item, is it set?
            if (GetIsObjectValid(oMember)) {
                if (GetLocalInt(oMember, "bAutoGold")) {
                    iContinue = TRUE;
                }
            }
        }
    }
    if (!iContinue) return; // party setting on, auto-gold off

    /* notify party members to receive gold */
    object oArea = GetArea(oPC);
    oMember = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oMember)) {
        iContinue = TRUE;
        if (AutoDistributeGold == 1 && oArea != GetArea(oMember)) iContinue = FALSE;
        if (iContinue) SendMessageToPC(oMember, "[Party] "+IntToString(iAmount)+" gold pieces auto-distributed...");
        oMember = GetNextFactionMember(oPC);
    }

    /* take and distribute gold */
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
    oMember = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oMember)) {
        if (GetStringLowerCase(GetTag(oMember)) == "nw_it_gold001") {
            DestroyObject(oMember);
            break;
        }
        oMember = GetNextItemInInventory(OBJECT_SELF);
    }
    AutoDistributeGold--; // lib_function assumes 0 is default split, 1 area, etc...
    GiveWtGoldToParty(oPC, iAmount, AutoDistributeGold);
}

