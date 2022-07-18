#include "x2_inc_itemprop"
void main()
{
object oPC =  GetItemActivator();
object oItem = GetItemActivatedTarget();
int iObjType = GetObjectType(oItem);
int iProp = GetLocalInt(oItem,"drain");
string sName = GetName(oItem);
int iName = GetLocalInt(oItem,"name");

if (iObjType != OBJECT_TYPE_ITEM)
{
FloatingTextStringOnCreature("This may only be used on items.",oPC);
return;
}

int iType =  GetBaseItemType(oItem);

if (iType==BASE_ITEM_ARMOR||iType==BASE_ITEM_RING||iType==BASE_ITEM_HELMET||iType==BASE_ITEM_CLOAK)
        {
        itemproperty ipAdd = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_NEGATIVE,iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Draining Resistance");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
if (iType == BASE_ITEM_BOOTS && iProp == 0)
        {
        itemproperty ipAdd = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Absorption");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
if (iType==BASE_ITEM_BASTARDSWORD||iType==BASE_ITEM_BATTLEAXE
||iType==BASE_ITEM_CLUB||iType==BASE_ITEM_DAGGER
||iType==BASE_ITEM_DART||iType==BASE_ITEM_DIREMACE||iType==BASE_ITEM_DOUBLEAXE
||iType==BASE_ITEM_DWARVENWARAXE||iType==BASE_ITEM_GLOVES||iType==BASE_ITEM_GREATAXE
||iType==BASE_ITEM_GREATSWORD||iType==BASE_ITEM_HALBERD||iType==BASE_ITEM_HANDAXE
||iType==BASE_ITEM_HEAVYFLAIL||iType==BASE_ITEM_KAMA||iType==BASE_ITEM_KATANA||iType==BASE_ITEM_KUKRI
||iType==BASE_ITEM_LIGHTFLAIL||iType==BASE_ITEM_LIGHTHAMMER||iType==BASE_ITEM_LIGHTMACE
||iType==BASE_ITEM_LONGSWORD||iType==BASE_ITEM_MORNINGSTAR||iType==BASE_ITEM_QUARTERSTAFF
||iType==BASE_ITEM_RAPIER||iType==BASE_ITEM_SCIMITAR||iType==BASE_ITEM_SCYTHE||iType==BASE_ITEM_SHORTSPEAR
||iType==BASE_ITEM_SHORTSWORD||iType==BASE_ITEM_SHURIKEN||iType==BASE_ITEM_SICKLE
||iType==BASE_ITEM_THROWINGAXE||iType==BASE_ITEM_TRIDENT||iType==BASE_ITEM_TWOBLADEDSWORD
||iType==BASE_ITEM_WARHAMMER||iType==BASE_ITEM_WHIP)
        {
        itemproperty ipAdd = ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,iProp+1,IP_CONST_ABILITY_CON);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Life-Draining");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
if (iType == BASE_ITEM_MAGICSTAFF && iProp == 0)
        {
        itemproperty ipAdd = ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Negative Energy Burst");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }


if (iType==BASE_ITEM_LARGESHIELD||iType==BASE_ITEM_SMALLSHIELD||iType==BASE_ITEM_TOWERSHIELD||
iType==BASE_ITEM_BELT||iType==BASE_ITEM_BRACER)
        {
        int iSpell;
        switch(d20())
            {
            case 1:
                iSpell=IP_CONST_IMMUNITYSPELL_CALL_LIGHTNING;
                break;
            case 2:
                iSpell=IP_CONST_IMMUNITYSPELL_DAZE;
                break;
            case 3:
                iSpell=IP_CONST_IMMUNITYSPELL_EVARDS_BLACK_TENTACLES;
                break;
            case 4:
                iSpell=IP_CONST_IMMUNITYSPELL_HARM;
                break;
            case 5:
                iSpell=IP_CONST_IMMUNITYSPELL_HAMMER_OF_THE_GODS;
                break;
            case 6:
                iSpell=IP_CONST_IMMUNITYSPELL_IMPLOSION;
                break;
            case 7:
                iSpell=IP_CONST_IMMUNITYSPELL_LIGHTNING_BOLT;
                break;
            case 8:
                iSpell=IP_CONST_IMMUNITYSPELL_FIREBALL;
                break;
            case 9:
                iSpell=IP_CONST_IMMUNITYSPELL_GREASE;
                break;
            case 10:
                iSpell=IP_CONST_IMMUNITYSPELL_FLAME_STRIKE;
                break;
            case 11:
                iSpell=IP_CONST_IMMUNITYSPELL_MAGIC_MISSILE;
                break;
            case 12:
                iSpell=IP_CONST_IMMUNITYSPELL_METEOR_SWARM;
                break;
            case 13:
                iSpell=IP_CONST_IMMUNITYSPELL_PHANTASMAL_KILLER;
                break;
            case 14:
                iSpell=IP_CONST_IMMUNITYSPELL_STORM_OF_VENGEANCE;
                break;
            case 15:
                iSpell=IP_CONST_IMMUNITYSPELL_SOUND_BURST;
                break;
            case 16:
                iSpell=IP_CONST_IMMUNITYSPELL_SUNBEAM;
                break;
            case 17:
                iSpell=IP_CONST_IMMUNITYSPELL_SLAY_LIVING;
                break;
            case 18:
                iSpell=IP_CONST_IMMUNITYSPELL_PRISMATIC_SPRAY;
                break;
            case 19:
                iSpell=IP_CONST_IMMUNITYSPELL_BLINDNESS_AND_DEAFNESS;
                break;
            case 20:
                iSpell=IP_CONST_IMMUNITYSPELL_FIRE_STORM;
                break;
            }
        itemproperty ipAdd = ItemPropertySpellImmunitySpecific(iSpell);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Spell Immunity");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
if (iType==BASE_ITEM_HEAVYCROSSBOW||iType==BASE_ITEM_LIGHTCROSSBOW||iType==BASE_ITEM_LONGBOW
||iType==BASE_ITEM_SHORTBOW||iType==BASE_ITEM_SLING)
        {
        if (iProp==0)
        {
        itemproperty ipAdd = ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_PLUS5);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Piercing Woe");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
        }
if (iType == BASE_ITEM_AMULET)
        {
        itemproperty ipAdd = ItemPropertyACBonus(iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Deflection");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
if (iType==BASE_ITEM_ARROW
||iType==BASE_ITEM_BOLT||iType==BASE_ITEM_BULLET)
        {
        itemproperty ipAdd = ItemPropertyVampiricRegeneration(iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Hammering");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"drain",iProp+1);
        }
}
