//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT9
/*
 * Default OnSpawn handler with XP1 revisions.
 * This corresponds to and produces the same results
 * as the default OnSpawn handler in the OC.
 *
 * This can be used to customize creature behavior in three main ways:
 *
 * - Uncomment the existing lines of code to activate certain
 *   common desired behaviors from the moment when the creature
 *   spawns in.
 *
 * - Uncomment the user-defined event signals to cause the
 *   creature to fire events that you can then handle with
 *   a custom OnUserDefined event handler script.
 *
 * - Add new code _at the end_ to alter the initial
 *   behavior in a more customized way.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/11/2002
//:://////////////////////////////////////////////////
//:: Updated 2003-08-20 Georg Zoeller: Added check for variables to active spawn in conditions without changing the spawnscript


#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

#include "x2_inc_switches"

void main()
{
//make ambient animations if wanderer
int iWander = GetLocalInt(OBJECT_SELF,"wander");
if (iWander==1) SetLocalInt(OBJECT_SELF,"X2_L_SPAWN_USE_AMBIENT",TRUE);
    // ***** Spawn-In Conditions ***** //

    // * REMOVE COMMENTS (// ) before the "Set..." functions to activate
    // * them. Do NOT touch lines commented out with // *, those are
    // * real comments for information.

    // * This causes the creature to say a one-line greeting in their
    // * conversation file upon perceiving the player. Put [NW_D2_GenCheck]
    // * in the "Text Seen When" field of the greeting in the conversation
    // * file. Don't attach any player responses.
    // *
    // SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);

    // * Same as above, but for hostile creatures to make them say
    // * a line before attacking.
    // *
    // SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);

    // * This NPC will attack when its allies call for help
    // *
    // SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);

    // * If the NPC has the Hide skill they will go into stealth mode
    // * while doing WalkWayPoints().
    // *
    // SetSpawnInCondition(NW_FLAG_STEALTH);

    //--------------------------------------------------------------------------
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    // * Same, but for Search mode
    // *
    // SetSpawnInCondition(NW_FLAG_SEARCH);

    //--------------------------------------------------------------------------
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }
    // * This will set the NPC to give a warning to non-enemies
    // * before attacking.
    // * NN -- no clue what this really does yet
    // *
    // SetSpawnInCondition(NW_FLAG_SET_WARNINGS);

    // * Separate the NPC's waypoints into day & night.
    // * See comment on WalkWayPoints() for use.
    // *
    // SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);

    // * If this is set, the NPC will appear using the "EffectAppear"
    // * animation instead of fading in, *IF* SetListeningPatterns()
    // * is called below.
    // *
    //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);

    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    // *
    // SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    //--------------------------------------------------------------------------
    // Enable immobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }
    // * Same as above, except NPC will wander randomly around the
    // * area.
    // *
    // SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);


    //--------------------------------------------------------------------------
    // Enable mobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    }
    // **** Animation Conditions **** //
    // * These are extra conditions you can put on creatures with ambient
    // * animations.

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    // * If this flag is set, this creature will constantly
    // * be acting. Otherwise, creatures will only start
    // * performing their ambient animations when they
    // * first perceive a player, and they will stop when
    // * the player moves away.
    // SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);

    // * Civilized creatures with this flag set will
    // * randomly use a few voicechats. It's a good
    // * idea to avoid putting this on multiple
    // * creatures using the same voiceset.
    // SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);


    // **** Special Combat Tactics *****//
    // * These are special flags that can be set on creatures to
    // * make them follow certain specialized combat tactics.
    // * NOTE: ONLY ONE OF THESE SHOULD BE SET ON A SINGLE CREATURE.

    // * Ranged attacker
    // * Will attempt to stay at ranged distance from their
    // * target.
    // SetCombatCondition(X0_COMBAT_FLAG_RANGED);

    // * Defensive attacker
    // * Will use defensive combat feats and parry
    // SetCombatCondition(X0_COMBAT_FLAG_DEFENSIVE);

    // * Ambusher
    // * Will go stealthy/invisible and attack, then
    // * run away and try to go stealthy again before
    // * attacking anew.
    // SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);

    // * Cowardly
    // * Cowardly creatures will attempt to flee
    // * attackers.
    // SetCombatCondition(X0_COMBAT_FLAG_COWARDLY);


    // **** Escape Commands ***** //
    // * NOTE: ONLY ONE OF THE FOLLOWING SHOULD EVER BE SET AT ONE TIME.
    // * NOTE2: Not clear that these actually work. -- NN

    // * Flee to a way point and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);

    // * Flee to a way point and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);

    // * Teleport to safety and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);

    // * Teleport to safety and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);



    // ***** CUSTOM USER DEFINED EVENTS ***** /


    /*
      If you uncomment any of these conditions, the creature will fire
      a specific user-defined event number on each event. That will then
      allow you to write custom code in the "OnUserDefinedEvent" handler
      script to go on top of the default NPC behaviors for that event.

      Example: I want to add some custom behavior to my NPC when they
      are damaged. I uncomment the "NW_FLAG_DAMAGED_EVENT", then create
      a new user-defined script that has something like this in it:

      if (GetUserDefinedEventNumber() == 1006) {
          // Custom code for my NPC to execute when it's damaged
      }

      These user-defined events are in the range 1001-1007.
    */

    // * Fire User Defined Event 1001 in the OnHeartbeat
    // *
    // SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);

    // * Fire User Defined Event 1002
    // *
    // SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

    // * Fire User Defined Event 1005
    // *
    // SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);

    // * Fire User Defined Event 1006
    // *
    // SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);

    // * Fire User Defined Event 1008
    // *
    // SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);

    // * Fire User Defined Event 1003
    // *
    // SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);

    // * Fire User Defined Event 1004
    // *
    // SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);



    // ***** DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) ***** //

    // * Goes through and sets up which shouts the NPC will listen to.
    // *
    SetListeningPatterns();

    // * Walk among a set of waypoints.
    // * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
    // *    among them in order.
    // * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
    // *    and return to it after combat.
    //
    // * Optional Parameters:
    // * void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
    //
    // * If "NW_FLAG_DAY_NIGHT_POSTING" is set above, you can also
    // * create waypoints with the tags "WN_" + NPC Tag + "_##"
    // * and those will be walked at night. (The standard waypoints
    // * will be walked during the day.)
    // * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
    WalkWayPoints();


    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //

    // * If Incorporeal, apply changes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

    }

//level up soldiers
string sTag = GetTag(OBJECT_SELF);
int iStatic = GetLocalInt(OBJECT_SELF,"static");
if (iStatic==1) return;
//check for fatness
int iFatroll = d6();
if (iFatroll==6)
    {
    if (GetLocalInt(OBJECT_SELF,"mounted")!=1) SetPhenoType(PHENOTYPE_BIG,OBJECT_SELF);
    }
//set vars for respawners
int iResp = GetLocalInt(OBJECT_SELF,"respawn");
if (iResp==1) SetLocalLocation(OBJECT_SELF,"rloc",GetLocation(OBJECT_SELF));
//randomize race
int iRace =  GetRacialType(OBJECT_SELF);
int iGender = GetGender(OBJECT_SELF);
int iMaxHd;
string sName = GetName(OBJECT_SELF);

if (iRace==RACIAL_TYPE_HUMAN&&iGender==GENDER_MALE)
{
iMaxHd = 34;
string sFirst = RandomName(NAME_FIRST_HUMAN_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_HUMAN&&iGender==GENDER_FEMALE)
{
iMaxHd = 27;
string sFirst = RandomName(NAME_FIRST_HUMAN_FEMALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_OUTSIDER&&iGender==GENDER_FEMALE)
{
iMaxHd = 16;
string sFirst = RandomName(NAME_FIRST_HUMAN_FEMALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_HALFORC&&iGender==GENDER_MALE)
{
iMaxHd = 13;
string sFirst = RandomName(NAME_FIRST_HALFORC_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_ELF&&iGender==GENDER_MALE)
{
iMaxHd = 18;
string sFirst = RandomName(NAME_FIRST_ELF_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_DWARF&&iGender==GENDER_MALE)
{
iMaxHd = 13;
string sFirst = RandomName(NAME_FIRST_DWARF_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_ELF&&iGender==GENDER_FEMALE)
{
iMaxHd = 16;
string sFirst = RandomName(NAME_FIRST_ELF_FEMALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_OUTSIDER&&iGender==GENDER_MALE)
{
iMaxHd = 34;
string sFirst = RandomName(NAME_FAMILIAR);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_OUTSIDER&&iGender==GENDER_MALE)
{
iMaxHd = 16;
string sFirst = RandomName(NAME_FIRST_ELF_FEMALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_HALFLING&&iGender==GENDER_MALE)
{
iMaxHd = 10;
string sFirst = RandomName(NAME_FIRST_HALFLING_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_GNOME&&iGender==GENDER_MALE)
{
iMaxHd = 13;
string sFirst = RandomName(NAME_FIRST_GNOME_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_HALFELF&&iGender==GENDER_MALE)
{
iMaxHd = 34;
string sFirst = RandomName(NAME_FIRST_HALFELF_MALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
}
if (iRace==RACIAL_TYPE_HUMANOID_GOBLINOID||iRace==RACIAL_TYPE_HUMANOID_ORC
||iRace==RACIAL_TYPE_HUMANOID_MONSTROUS||iRace==RACIAL_TYPE_HUMANOID_REPTILIAN
||iRace==RACIAL_TYPE_GIANT||iRace==RACIAL_TYPE_MAGICAL_BEAST||iRace==RACIAL_TYPE_ABERRATION)
{
ExecuteScript("name_gutteral",OBJECT_SELF);
ExecuteScript("alter_app",OBJECT_SELF);
}
if (iRace==RACIAL_TYPE_OUTSIDER&&iGender==GENDER_NONE)
{
string sFirst = RandomName(NAME_FIRST_ELF_FEMALE);
SetName(OBJECT_SELF,sFirst+" the "+sName);
ExecuteScript("alter_app",OBJECT_SELF);
}
SetCreatureBodyPart(CREATURE_PART_HEAD,Random(iMaxHd)+1,OBJECT_SELF);

//level up npc
if (GetLocalInt(OBJECT_SELF,"dontlevel")==TRUE) return;
if (GetLocalInt(OBJECT_SELF,"static")==TRUE) return;
ExecuteScript("level_up",OBJECT_SELF);
}
