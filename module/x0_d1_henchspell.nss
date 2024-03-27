// the henchman casts their spell

#include "X0_INC_HENAI"


void main()
{
    int nBuffType = GetLocalInt(OBJECT_SELF, "X2_BUFFING_TYPE");
    ClearAllActions();
    if(nBuffType != 0)
    {
            // forward call to hench_o0_enhance
        ExecuteScript("hench_o0_enhanc", OBJECT_SELF);
        return;
    }
    object oPC = GetPCSpeaker();
    object oTarget = GetLocalObject(OBJECT_SELF, "Henchman_Spell_Target");
    SetAssociateState(NW_ASC_IS_BUSY, TRUE);
    int nSpell = GetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast");

    if ((nSpell > 0) && (GetIsObjectValid(oTarget)))
    {
        ClearAllActions();
        ActionCastSpellAtObject(nSpell, oTarget);
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast", 0));
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID));
    }
    else PlayVoiceChat(VOICE_CHAT_CUSS);
    ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY, FALSE));
}
