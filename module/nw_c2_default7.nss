//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 1st, 2008
//:: Added Support for Dying Wile Mounted
//:://///////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "x3_inc_horse"
#include "_kb_loot_corpse"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB")&&GetIsObjectValid(GetMaster(OBJECT_SELF))) SetLocalInt(GetMaster(OBJECT_SELF),"bX3_STORE_MOUNT_INFO",TRUE);


    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    //if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    //{
        //AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    //}

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    //craft_drop_items(oKiller);
    LeaveCorpse();
//respawn NPC code/////////////////////////////////////////////////////////////////////////
if (GetLocalInt(OBJECT_SELF,"respawn")==1)
{
location lHere = GetLocation(OBJECT_SELF);
string sRes = GetResRef(OBJECT_SELF);
object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE,"respawn_n",lHere);
SetLocalString(oSpawner,"resref",sRes);
location lDeath = GetLocalLocation(OBJECT_SELF,"rloc");
SetLocalLocation(oSpawner,"rloc",lDeath);
if (GetLocalInt(OBJECT_SELF,"fastspawn")==1) AssignCommand(oSpawner,DelayCommand(6.0f,ExecuteScript("respawn_n",oSpawner)));
else AssignCommand(oSpawner,DelayCommand(300.0f,ExecuteScript("respawn_n",oSpawner)));
}
else//lower pop by one
{
object oMod = GetModule();
int iMyTeam = GetLocalInt(OBJECT_SELF,"team");
int iTurret = GetLocalInt(OBJECT_SELF,"turret");
string sMyTeam = IntToString(iMyTeam);
int iPop = GetLocalInt(oMod,sMyTeam+"pop");
int iTnum = GetLocalInt(oMod,sMyTeam+"tnum");
if (iTurret==FALSE) SetLocalInt(oMod,sMyTeam+"pop",iPop-1);
else if (iTurret==TRUE) SetLocalInt(oMod,sMyTeam+"tnum",iTnum-1);
}
//NPC respawn done
//PC Rewards Code/////////////////////////////////////////////////////////////////////////////
int iRace = GetRacialType(OBJECT_SELF);
if (iRace==RACIAL_TYPE_ANIMAL) return;


        int iKill = GetLocalInt(oKiller,"team");
        int iDead = GetLocalInt(OBJECT_SELF,"team");
        string sMe = GetTag(OBJECT_SELF);
        string sName = GetName(OBJECT_SELF);
        string sKiller = GetName(oKiller);

        if (GetIsPC(oKiller)==TRUE)
        {
        object oWidget = GetItemPossessedBy(oKiller,"widget");
        int iKills = GetLocalInt(oWidget,"kills");
        int iRank = GetLocalInt(oWidget,"score");
        int iCP = GetLocalInt(oKiller,"cp");
        SetLocalInt(oWidget,"kills",iKills+1);
        SetLocalInt(oWidget,"score",iRank+1);
        SetLocalInt(oKiller,"cp",iCP+1);
        if (iKill!=iDead)
            {
            GiveXPToCreature(oKiller,25);
            DelayCommand(1.0f,FloatingTextStringOnCreature("<c þþ>KILL BONUS +25XP! +1CP.</c>",oKiller));
            }
        }
///////////announce kill/////////////////////////////////////////////////////////////////////////////////
  object oPC = GetFirstPC();
  int iHD = FloatToInt(GetChallengeRating(OBJECT_SELF));
  int iPCLevel  = GetHitDice(oPC);
  int iMult = iHD/iPCLevel;
  if (iMult<1) iMult=1;
  int iTeam = GetLocalInt(oPC,"team");
  if (iHD<=1) iHD=1;
//award team for kill
   while (oPC!=OBJECT_INVALID)
   {
   if (iTeam!=iDead)
       {
       iTeam = GetLocalInt(oPC,"team");
       iPCLevel = GetHitDice(oPC);
       FloatingTextStringOnCreature( sName+" was killed by "+sKiller+".",oPC,FALSE);
       iMult = iHD/iPCLevel;
       if (iMult<1) iMult=1;
       GiveXPToCreature(oPC,10*iMult);
       GiveGoldToCreature(oPC,10*iMult);
       }
      oPC = GetNextPC();
      }
}
