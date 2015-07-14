void main()
{
//dagger of woe and blessings
object oTarget = GetSpellTargetObject();
location lHere = GetLocation(oTarget);
effect eEff;
effect eVFX;
effect eViz;
int iRoll=Random(38)+1;
int iInst;
float fDur = IntToFloat(6*d6());
int iHD = GetHitDice(OBJECT_SELF)+3;

if (iHD<=d20(3)) return;

switch(iRoll)
        {
        case 1:
        eEff=EffectAbilityDecrease(d6(),d6());
        eVFX=EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        eViz=EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
        iInst=0;
        break;
        case 2:
        eEff=EffectAbilityIncrease(d6(),d6());
        eVFX=EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        eViz=EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);
        iInst=0;
        break;
        case 3:
        eEff=EffectBlindness();
        eVFX=EffectVisualEffect(VFX_FNF_BLINDDEAF);
        eViz=EffectVisualEffect(VFX_DUR_BLIND);
        iInst=0;
        break;
        case 4:
        eEff=EffectCharmed();
        eVFX=EffectVisualEffect(VFX_IMP_CHARM);
        eViz=EffectVisualEffect(VFX_DUR_AURA_ODD);
        iInst=0;
        break;
        case 5:
        eEff=EffectConcealment(50,MISS_CHANCE_TYPE_NORMAL);
        eVFX=EffectVisualEffect(VFX_IMP_CHARM);
        eViz=EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE_NO_SOUND);
        iInst=0;
        break;
        case 6:
        eEff=EffectConfused();
        eVFX=EffectVisualEffect(VFX_IMP_CONFUSION_S);
        eViz=EffectVisualEffect(VFX_DUR_BUBBLES);
        iInst=0;
        break;
        case 7:
        eEff=EffectCurse(d6(),d6(),d6(),d6(),d6(),d6());
        eVFX=EffectVisualEffect(VFX_IMP_EVIL_HELP);
        eViz=EffectVisualEffect(VFX_DUR_AURA_PULSE_PURPLE_BLACK);
        iInst=0;
        break;
        case 8:
        eEff=EffectDamage(d20(),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL);
        eVFX=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        iInst=1;
        break;
        case 9:
        eEff=EffectDamage(d20(),DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL);
        eVFX=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        iInst=1;
        break;
        case 10:
        eEff=EffectDamage(d20(),DAMAGE_TYPE_SONIC,DAMAGE_POWER_NORMAL);
        eVFX=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        iInst=1;
        break;
        case 11:
        eEff=EffectDamage(d20(),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL);
        eVFX=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        iInst=1;
        break;
        case 12:
        eEff=EffectDamageShield(4,DAMAGE_BONUS_1d6,DAMAGE_TYPE_MAGICAL);
        eVFX=EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT);
        eViz=EffectVisualEffect(VFX_DUR_ICESKIN);
        iInst=0;
        break;
        case 13:
        eEff=EffectDazed();
        eVFX=EffectVisualEffect(VFX_IMP_DAZED_S);
        eViz=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        iInst=0;
        break;
        case 14:
        eEff=EffectDeaf();
        eVFX=EffectVisualEffect(VFX_FNF_SOUND_BURST);
        eViz=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        iInst=0;
        break;
        case 15:
        eEff=EffectDeath();
        eVFX=EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
        iInst=1;
        break;
        case 16:
        eEff=EffectDisease(DISEASE_RED_SLAAD_EGGS);
        eVFX=EffectVisualEffect(VFX_IMP_DISEASE_S);
        iInst=1;
        break;
        case 17:
        eEff=EffectDispelMagicAll(d20());
        eVFX=EffectVisualEffect(VFX_FNF_DISPEL);
        iInst=1;
        break;
        case 18:
        eEff=EffectDominated();
        eVFX=EffectVisualEffect(VFX_IMP_DOMINATE_S);
        eViz=EffectVisualEffect(VFX_DUR_PIXIEDUST);
        iInst=0;
        break;
        case 19:
        eEff=EffectEthereal();
        eVFX=EffectVisualEffect(VFX_IMP_AC_BONUS);
        eViz=EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
        iInst=0;
        break;
        case 20:
        eEff=EffectFrightened();
        eVFX=EffectVisualEffect(VFX_IMP_DOOM);
        eViz=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        iInst=0;
        break;
        case 21:
        eEff=EffectHaste();
        eVFX=EffectVisualEffect(VFX_FNF_LOS_NORMAL_10);
        eViz=EffectVisualEffect(VFX_DUR_AURA_RED);
        iInst=0;
        break;
        case 22:
        eEff=EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
        eVFX=EffectVisualEffect(VFX_IMP_DEATH_WARD);
        iInst=0;
        break;
        case 23:
        eEff=EffectKnockdown();
        iInst=0;
        break;
        case 24:
        eEff=EffectMovementSpeedDecrease(d20(5)-1);
        eVFX=EffectVisualEffect(VFX_IMP_FROST_S);
        eViz=EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE);
        iInst=0;
        break;
        case 25:
        eEff=EffectMovementSpeedIncrease(d20(5)-1);
        eVFX=EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
        eViz=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
        iInst=0;
        break;
        case 26:
        eEff=EffectNegativeLevel(d6(),FALSE);
        eVFX=EffectVisualEffect(VFX_IMP_HARM);
        eViz=EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
        iInst=0;
        break;
        case 27:
        eEff=EffectParalyze();
        eVFX=EffectVisualEffect(VFX_IMP_HARM);
        eViz=EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
        iInst=0;
        break;
        case 28:
        eEff=EffectPetrify();
        eVFX=EffectVisualEffect(VFX_IMP_HEAD_EVIL);
        eViz=EffectVisualEffect(VFX_DUR_PARALYZED);
        iInst=0;
        break;
        case 29:
        eEff=EffectPoison(d12());
        eVFX=EffectVisualEffect(VFX_IMP_POISON_S);
        iInst=1;
        break;
        case 30:
        eEff=EffectPolymorph(Random(40)+1);
        eVFX=EffectVisualEffect(VFX_IMP_POLYMORPH);
        iInst=0;
        break;
        case 31:
        eEff=EffectRegenerate(d6(),6.0f);
        eVFX=EffectVisualEffect(VFX_IMP_RESTORATION);
        eViz=EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_ORANGE);
        iInst=0;
        break;
        case 32:
        eEff=EffectSanctuary(d20(2));
        eVFX=EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
        eViz=EffectVisualEffect(VFX_DUR_SANCTUARY);
        iInst=0;
        break;
        case 33:
        eEff=EffectSilence();
        eVFX=EffectVisualEffect(VFX_IMP_SILENCE);
        eViz=EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
        iInst=0;
        break;
        case 34:
        eEff=EffectSleep();
        eVFX=EffectVisualEffect(VFX_IMP_SLEEP);
        eViz=EffectVisualEffect(VFX_DUR_PARALYZED);
        iInst=0;
        break;
        case 35:
        eEff=EffectSlow();
        eVFX=EffectVisualEffect(VFX_IMP_SLOW);
        eViz=EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
        iInst=0;
        break;
        case 36:
        eEff=EffectStunned();
        eVFX=EffectVisualEffect(VFX_IMP_SLOW);
        eViz=EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_YELLOW);
        iInst=0;
        break;
        case 37:
        eEff=EffectTemporaryHitpoints(d100());
        eVFX=EffectVisualEffect(VFX_IMP_HOLY_AID);
        iInst=1;
        break;
        case 38:
        eEff=EffectTrueSeeing();
        eVFX=EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
        eViz=EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
        iInst=0;
        break;
        }

if (iInst==1)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,oTarget);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFX,lHere);
        return;
        }

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEff,oTarget,fDur);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFX,lHere);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oTarget,fDur);

}
