#include "x2_inc_itemprop"
void main()
{
object oPC =  GetItemActivator();
object oItem = GetItemActivatedTarget();
int iObjType = GetObjectType(oItem);
int iProp = GetLocalInt(oItem,"holy");
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
            SetName(oItem,sName+" of Negative Energy Resistance");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType == BASE_ITEM_BOOTS && iProp == 0)
        {
        itemproperty ipAdd = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_FEAR);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Courage");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType==BASE_ITEM_ARROW||iType==BASE_ITEM_BASTARDSWORD||iType==BASE_ITEM_BATTLEAXE
||iType==BASE_ITEM_BOLT||iType==BASE_ITEM_BULLET||iType==BASE_ITEM_CLUB||iType==BASE_ITEM_DAGGER
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
        itemproperty ipAdd = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,iProp+2);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Smiting");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+2);
        }
if (iType == BASE_ITEM_MAGICSTAFF && iProp == 0)
        {
        itemproperty ipAdd = ItemPropertyCastSpell(IP_CONST_CASTSPELL_SEARING_LIGHT_5,IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Searing Light");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType==BASE_ITEM_BELT||iType==BASE_ITEM_BRACER)
        {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Charisma");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType==BASE_ITEM_LARGESHIELD||iType==BASE_ITEM_SMALLSHIELD||iType==BASE_ITEM_TOWERSHIELD)
        {
        itemproperty ipAdd = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SLASHING,iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Slashing Immunity");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType==BASE_ITEM_HEAVYCROSSBOW||iType==BASE_ITEM_LIGHTCROSSBOW||iType==BASE_ITEM_LONGBOW
||iType==BASE_ITEM_SHORTBOW||iType==BASE_ITEM_SLING)
        {
        itemproperty ipAdd = ItemPropertyMassiveCritical(iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Heartstriking");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }
if (iType == BASE_ITEM_AMULET)
        {
        itemproperty ipAdd = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,iProp+1);
        IPSafeAddItemProperty(oItem,ipAdd,0.0f,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        FloatingTextStringOnCreature("Gem added successfully to "+sName+".",oPC);
        if (iProp==0&&iName==0)
            {
            SetName(oItem,sName+" of Resistances");
            SetLocalInt(oItem,"name",1);
            }
        SetLocalInt(oItem,"holy",iProp+1);
        }

}