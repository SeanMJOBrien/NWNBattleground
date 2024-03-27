#include "nw_i0_plot"

void main()
{
object oPC = GetLastPlayerDied();
location lPC = GetLocation(oPC);
object oAfterlife = GetWaypointByTag("AFTERLIFE");
object oScan;
string sTravel = GetLocalString(oPC,"TRAVEL");
if ((GetName(GetArea(oPC)) == "Wilderness") && (sTravel != "") && (GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oPC) == OBJECT_INVALID))
    {
    lPC = GetLocation(GetWaypointByTag(GetSubString(sTravel,0,4)+"_TRAVELDEST"));
    }
object oRemains = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_remains",lPC,FALSE);
SetLocalObject(oRemains,"Owner",oPC);
SetLocalObject(oPC,"Remains",oRemains);
SetLocalLocation(oPC,"DieLocation",lPC);
RemoveEffects(oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
AssignCommand(oPC,ClearAllActions(TRUE));
AssignCommand(oPC,ActionJumpToLocation(GetLocation(oAfterlife)));
//ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectInvisibility(INVISIBILITY_TYPE_NORMAL),oPC);
//ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectBlindness(),oPC);
//ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneImmobilize(),oPC);
//object oTaker = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_taker",lPC);
//AssignCommand(oPC,ClearAllActions(TRUE));

object oTaker = GetObjectByTag("TAKER");
AssignCommand(oPC,ActionStartConversation(oTaker, "ps_takerconv",TRUE,FALSE));
AssignCommand(oPC,ActionDoCommand(SetCommandable(FALSE,oPC)));
//SendMessageToPC(oPC,"Taker's tag "+GetTag(oTaker));
//SetCommandable(FALSE,oPC);
//SetCutsceneMode(oPC,TRUE);
}
