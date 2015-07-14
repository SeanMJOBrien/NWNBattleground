//::///////////////////////////////////////////////
//:: Example XP2 OnLoad Script
//:: x2_mod_def_load
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnModuleLoad Event

    This example script demonstrates how to tweak the
    behavior of several subsystems in your module.

    For more information, please check x2_inc_switches
    which holds definitions for several variables that
    can be set on modules, creatures, doors or waypoints
    to change the default behavior of Bioware scripts.

    Warning:
    Using some of these switches may change your games
    balancing and may introduce bugs or instabilities. We
    recommend that you only use these switches if you
    know what you are doing. Consider these features
    unsupported!

    Please do NOT report any bugs you experience while
    these switches have been changed from their default
    positions.

    Make sure you visit the forums at nwn.bioware.com
    to find out more about these scripts.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_restsys"
void main()
{
   if (GetGameDifficulty() ==  GAME_DIFFICULTY_CORE_RULES || GetGameDifficulty() ==  GAME_DIFFICULTY_DIFFICULT)
   {
        // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
        // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
        SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

       // * Activating the switch below will make AOE spells hurt neutral NPCS by default
       // SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);
   }

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
    SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   // SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   // SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, TRUE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
    SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);


    // * Item Event Scripts: The game's default event scripts allow routing of all item related events
    // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
    // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
    // * is triggered. Check "x2_it_example.nss" for an example.
    // * This feature is disabled by default.
   SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
        // * If Tagbased scripts are enabled, and you are running a Local Vault Server
        // * you should use the line below to add a layer of security to your server, preventing
        // * people to execute script you don't want them to. If you use the feature below,
        // * all called item scrips will be the prefix + the Tag of the item you want to execute, up to a
        // * maximum of 16 chars, instead of the pure tag of the object.
        // * i.e. without the line below a user activating an item with the tag "test",
        // * will result in the execution of a script called "test". If you uncomment the line below
        // * the script called will be "1_test.nss"
        // SetUserDefinedItemEventPrefix("1_");

   }
object oMod = OBJECT_SELF;
SetLocalInt(oMod,"lasthour",5);
//set starting worker amounts
SetLocalInt(oMod,"1fm",1);
SetLocalInt(oMod,"1lj",1);
SetLocalInt(oMod,"1mn",1);
SetLocalInt(oMod,"1cm",1);
SetLocalInt(oMod,"1ht",1);
SetLocalInt(oMod,"1sc",1);
SetLocalInt(oMod,"2fm",1);
SetLocalInt(oMod,"2lj",1);
SetLocalInt(oMod,"2mn",1);
SetLocalInt(oMod,"2cm",1);
SetLocalInt(oMod,"2ht",1);
SetLocalInt(oMod,"2sc",1);
//set starting infrastructure
SetLocalInt(oMod,"1fmmax",1);
SetLocalInt(oMod,"1ljmax",1);
SetLocalInt(oMod,"1mnmax",1);
SetLocalInt(oMod,"1cmmax",1);
SetLocalInt(oMod,"1htmax",1);
SetLocalInt(oMod,"1scmax",1);
SetLocalInt(oMod,"2fmmax",1);
SetLocalInt(oMod,"2ljmax",1);
SetLocalInt(oMod,"2mnmax",1);
SetLocalInt(oMod,"2cmmax",1);
SetLocalInt(oMod,"2htmax",1);
SetLocalInt(oMod,"2scmax",1);
//set starting resources
SetLocalInt(oMod,"1fd",5);
SetLocalInt(oMod,"1ir",0);
SetLocalInt(oMod,"1wd",5);
SetLocalInt(oMod,"1hd",0);
SetLocalInt(oMod,"1st",0);
SetLocalInt(oMod,"1mt",0);
SetLocalInt(oMod,"1ad",0);
SetLocalInt(oMod,"1cp",5);
SetLocalInt(oMod,"1eq",5);
SetLocalInt(oMod,"1iw",0);
SetLocalInt(oMod,"1sn",5);
SetLocalInt(oMod,"2fd",5);
SetLocalInt(oMod,"2ir",0);
SetLocalInt(oMod,"2wd",5);
SetLocalInt(oMod,"2hd",0);
SetLocalInt(oMod,"2st",0);
SetLocalInt(oMod,"2mt",0);
SetLocalInt(oMod,"2ad",0);
SetLocalInt(oMod,"2cp",5);
SetLocalInt(oMod,"2eq",5);
SetLocalInt(oMod,"2iw",0);
SetLocalInt(oMod,"2sn",5);
//set training level
SetLocalInt(oMod,"1milmax",1);
SetLocalInt(oMod,"2milmax",1);
SetLocalInt(oMod,"turn",1);
SetLocalInt(oMod,"goodplayers",1);
SetLocalInt(oMod,"evilplayers",1);
SetLocalInt(oMod,"maxpop",50);
SetLocalInt(oMod,"1pop",0);
SetLocalInt(oMod,"2pop",0);
SetLocalInt(oMod,"1popmax",5);
SetLocalInt(oMod,"2popmax",5);
SetLocalInt(oMod,"1foundry",0);
SetLocalInt(oMod,"2foundry",0);
SetLocalInt(oMod,"1mana",0);
SetLocalInt(oMod,"2mana",0);
SetLocalInt(oMod,"avglevel",1);
SetLocalFloat(oMod,"magic",1.5f);
}
