//::///////////////////////////////////////////////
//:: FileName ps_gaffer03
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/13/2005 7:30:00 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("critwallpawn");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
