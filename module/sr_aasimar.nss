void main()
{
object oPC = OBJECT_SELF;
AdjustAlignment(oPC,ALIGNMENT_GOOD,100);
object oWidget = GetItemPossessedBy(oPC,"widget");
SetLocalFloat(oWidget,"xpmod",0.8f);
SetLocalInt(oWidget,"subrace",1);
object oHide = GetItemPossessedBy(oPC,"cyberhide");
if (oHide==OBJECT_INVALID)
    {
    oHide = CreateItemOnObject("cyberhide",oPC);
    AssignCommand(oPC,ActionEquipItem(oHide,INVENTORY_SLOT_CARMOUR));
    }


itemproperty ipCHA = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2);
itemproperty ipWIS = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,2);
itemproperty ipSpot = ItemPropertySkillBonus(SKILL_SPOT,2);
itemproperty ipList = ItemPropertySkillBonus(SKILL_LISTEN,2);
itemproperty ipDark = ItemPropertyDarkvision();
itemproperty ipDRa = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5);
itemproperty ipDRc = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5);
itemproperty ipDRe = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_5);
itemproperty ipSave = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,2);



AddItemProperty(DURATION_TYPE_PERMANENT,ipCHA,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipWIS,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSpot,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipList,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDark,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRa,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRc,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipDRe,oHide);
AddItemProperty(DURATION_TYPE_PERMANENT,ipSave,oHide);

CreateItemOnObject("holysword",oPC);
effect eViz;
eViz = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE);
eViz = SupernaturalEffect(eViz);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eViz,oPC);
SetColor(oPC,COLOR_CHANNEL_SKIN,164);
}
