#include "x2_inc_itemprop"

void main()
{
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////
object oItem = CreateItemOnObject("mbook",OBJECT_SELF);

int iLevel = iHD+d20();
int iTimes = iHD+d20();
int iUses;

if (iTimes<=14) iUses = 2;
if (iTimes>=15&&iTimes<=22) iUses = 3;
if (iTimes>=23&&iTimes<=28) iUses = 4;
if (iTimes>=29&&iTimes<=34) iUses = 5;
if (iTimes>=35&&iTimes<=39) iUses = 6;
if (iTimes>=40&&iTimes<=45) iUses = 8;
if (iTimes>=46&&iTimes<=51) iUses = 9;
if (iTimes>=52&&iTimes<=54) iUses = 10;
if (iTimes>=55&&iTimes<=57) iUses = 11;
if (iTimes==58||iTimes==59) iUses = 12;
if (iTimes>=60) iUses = 13;

int iSpell;
string sLName;

switch(iLevel)
        {
        case 2: iSpell=IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1;sLName=" of Minor Curing";break;
        case 3: iSpell=IP_CONST_CASTSPELL_LIGHT_5;sLName=" of Light";break;
        case 4: iSpell=IP_CONST_CASTSPELL_FLARE_1;sLName=" of Flare";break;
        case 5: iSpell=IP_CONST_CASTSPELL_DAZE_1;sLName=" of Dazing";break;
        case 6: iSpell=IP_CONST_CASTSPELL_SHIELD_5;sLName=" of Shield";break;
        case 7: iSpell=IP_CONST_CASTSPELL_DOOM_5;sLName=" of Doom";break;
        case 8: iSpell=IP_CONST_CASTSPELL_AMPLIFY_5;sLName=" of Amplification";break;
        case 9: iSpell=IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5;sLName=" of Cure Light Wounds";break;
        case 10: iSpell=IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5;sLName=" of Lesser Infliction";break;
        case 11: iSpell=IP_CONST_CASTSPELL_ENDURE_ELEMENTS_2;sLName=" of Elemental Endurance";break;
        case 12: iSpell=IP_CONST_CASTSPELL_MAGE_ARMOR_2;sLName=" of Mage Armor";break;
        case 13: iSpell=IP_CONST_CASTSPELL_SLEEP_2;sLName=" of Sleep";break;
        case 14: iSpell=IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2;sLName=" of Lesser Summoning";break;
        case 15: iSpell=IP_CONST_CASTSPELL_MAGIC_MISSILE_3;sLName=" of Magic Missile";break;
        case 16: iSpell=IP_CONST_CASTSPELL_FEAR_5;sLName=" of Fear";break;
        case 17: iSpell=IP_CONST_CASTSPELL_COLOR_SPRAY_2;sLName=" of Color Spray";break;
        case 18: iSpell=IP_CONST_CASTSPELL_SOUND_BURST_3;sLName=" of Sound Burst";break;
        case 19: iSpell=IP_CONST_CASTSPELL_BULLS_STRENGTH_3;sLName=" of Bull's Strength";break;
        case 20: iSpell=IP_CONST_CASTSPELL_CATS_GRACE_3;sLName=" of Cat's Grace";break;
        case 21: iSpell=IP_CONST_CASTSPELL_ENDURANCE_3;sLName=" of Bear's Endurance";break;
        case 22: iSpell=IP_CONST_CASTSPELL_FOXS_CUNNING_3;sLName=" of Fox's Cunning";break;
        case 23: iSpell=IP_CONST_CASTSPELL_OWLS_WISDOM_3;sLName=" of Owl's Wisdom";break;
        case 24: iSpell=IP_CONST_CASTSPELL_EAGLE_SPLEDOR_3;sLName=" of Eagle's Splendor";break;
        case 25: iSpell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3;sLName=" of Healing";break;
        case 26: iSpell=IP_CONST_CASTSPELL_BURNING_HANDS_2;sLName=" of Burning Hands";break;
        case 27: iSpell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_3;sLName=" of Deathray";break;
        case 28: iSpell=IP_CONST_CASTSPELL_PRAYER_5;sLName=" of Prayer";break;
        case 29: iSpell=IP_CONST_CASTSPELL_LESSER_RESTORATION_3;sLName=" of Lesser Restoration";break;
        case 30: iSpell=IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7;sLName=" of Wounding";break;
        case 31: iSpell=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5;sLName=" of Greater Healing";break;
        case 32: iSpell=IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3;sLName=" of Summoning";break;
        case 33: iSpell=IP_CONST_CASTSPELL_SANCTUARY_2;sLName=" of Santuary";break;
        case 34: iSpell=IP_CONST_CASTSPELL_SEARING_LIGHT_5;sLName=" of Searing Light";break;
        case 35: iSpell=IP_CONST_CASTSPELL_HOLD_PERSON_3;sLName=" of Paralyzation";break;
        case 36: iSpell=IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3;sLName=" of Ghostly Visage";break;
        case 37: iSpell=IP_CONST_CASTSPELL_DISMISSAL_7;sLName=" of Dismissal";break;
        case 38: iSpell=IP_CONST_CASTSPELL_DEATH_WARD_7;sLName=" of Death Ward";break;
        case 39: iSpell=IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3;sLName=" of Blindness/Deafness";break;
        case 40: iSpell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_7;sLName=" of Major Healing";break;
        case 41: iSpell=IP_CONST_CASTSPELL_INVISIBILITY_3;sLName=" of Invisibility";break;
        case 42: iSpell=IP_CONST_CASTSPELL_LESSER_DISPEL_5;sLName=" of Lesser Dispelling";break;
        case 43: iSpell=IP_CONST_CASTSPELL_BARKSKIN_6;sLName=" of Barkskin";break;
        case 44: iSpell=IP_CONST_CASTSPELL_WEB_3;sLName=" of Shelob";break;
        case 45: iSpell=IP_CONST_CASTSPELL_ANIMATE_DEAD_5;sLName=" of the Undead";break;
        case 46: iSpell=IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;sLName=" of Freedom";break;
        case 47: iSpell=IP_CONST_CASTSPELL_HOLD_MONSTER_7;sLName=" of Greater Paralysis";break;
        case 48: iSpell=IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5;sLName=" of Greater Summoning";break;
        case 49: iSpell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5;sLName=" of Negativity";break;
        case 50: iSpell=IP_CONST_CASTSPELL_CALL_LIGHTNING_5;sLName=" of Call Lightning";break;
        case 51: iSpell=IP_CONST_CASTSPELL_WALL_OF_FIRE_9;sLName=" of the Firewall";break;
        case 52: iSpell=IP_CONST_CASTSPELL_RESTORATION_7;sLName=" of Restoration";break;
        case 53: iSpell=IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_7;sLName=" of Smiting";break;
        case 54: iSpell=IP_CONST_CASTSPELL_FLAME_ARROW_5;sLName=" of Flame Arrows";break;
        case 55: iSpell=IP_CONST_CASTSPELL_ICE_STORM_9;sLName=" of Ice Storm";break;
        case 56: iSpell=IP_CONST_CASTSPELL_LIGHTNING_BOLT_5;sLName=" of Lightning Bolts";break;
        case 57: iSpell=IP_CONST_CASTSPELL_FIREBALL_5;sLName=" of Fireballs";break;
        case 58: iSpell=IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9;sLName=" of Acid Arrows";break;
        case 59: iSpell=IP_CONST_CASTSPELL_PHANTASMAL_KILLER_7;sLName=" of the Reaper";break;
        case 60: iSpell=IP_CONST_CASTSPELL_ISAACS_LESSER_MISSILE_STORM_13;sLName=" of Missile Storm";break;
        }
SetName(oItem,"Book "+sLName);
itemproperty ipSpell = ItemPropertyCastSpell(iSpell,iUses);
IPSafeAddItemProperty(oItem,ipSpell,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

object oSimple = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(10)+1,TRUE);
DestroyObject(oItem);
DelayCommand(2.6f,ActionEquipItem(oSimple,INVENTORY_SLOT_NECK));
SetLocalInt(oSimple,"itemlevel",iHD);
SetIdentified(oSimple,TRUE);
DelayCommand(0.2f,ExecuteScript("name_color",oSimple));
}
