void main()
{
object oPC = GetItemActivator();
location lHere = GetLocation(oPC);
int iHD = FloatToInt(GetHitDice(oPC)/4.0f)+1;
float fDur = (iHD*6.0f)+12.0f;
effect eSTR = EffectAbilityIncrease(ABILITY_STRENGTH,iHD);
effect eCON = EffectAbilityIncrease(ABILITY_CONSTITUTION,iHD);
effect eAtt = EffectAttackIncrease(iHD,ATTACK_BONUS_MISC);
effect eDam = EffectDamageIncrease(DAMAGE_BONUS_1d4,DAMAGE_TYPE_MAGICAL);
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0));
PlayVoiceChat(VOICE_CHAT_THREATEN,oPC);


ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSTR,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCON,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAtt,oPC,fDur);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDam,oPC,fDur);



}
