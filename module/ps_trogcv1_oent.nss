//
// NESS V8.1
//
// Spawn sample onEnter
//
// If you want to use pseudo-heartbeats and do not already have an area onEnter
// script, you can use this one.  Otherwise, just add Spawn_OnAreaEnter() to
// your existing onEnter handler.  Note that you use this (and
// SpawnOnAreaExit()) INSTEAD OF Spawn() / spawn_sample_hb.
//

#include "spawn_functions"
#include "ps_timestamp"
#include "ps_mpop_process"

void main()
{
vector vFirstTile = Vector(7.0,1.0);
vector vSecondTile = Vector(7.0,2.0);
vector vThirdTile = Vector(7.0,3.0);
location lFirstTile = Location(OBJECT_SELF,vFirstTile,0.0);
location lSecondTile = Location(OBJECT_SELF,vSecondTile,0.0);
location lThirdTile = Location(OBJECT_SELF,vThirdTile,0.0);

if (GetIsDay())
    {
    SetTileMainLightColor(lFirstTile,TILE_MAIN_LIGHT_COLOR_WHITE,TILE_MAIN_LIGHT_COLOR_BLACK);
    SetTileMainLightColor(lSecondTile,TILE_MAIN_LIGHT_COLOR_WHITE,TILE_MAIN_LIGHT_COLOR_BLACK);
    SetTileMainLightColor(lFirstTile,TILE_MAIN_LIGHT_COLOR_DIM_WHITE,TILE_MAIN_LIGHT_COLOR_BLACK);
    }
    else
    {
    SetTileMainLightColor(lFirstTile,TILE_MAIN_LIGHT_COLOR_BLACK,TILE_MAIN_LIGHT_COLOR_BLACK);
    SetTileMainLightColor(lSecondTile,TILE_MAIN_LIGHT_COLOR_BLACK,TILE_MAIN_LIGHT_COLOR_BLACK);
    SetTileMainLightColor(lFirstTile,TILE_MAIN_LIGHT_COLOR_BLACK,TILE_MAIN_LIGHT_COLOR_BLACK);
    }
RecomputeStaticLighting(OBJECT_SELF);
  // Spawn_OnAreaEnter() can take three arguments - the name of the heartbeat
  // script to execute, the heartbeat duration, and a delay for the first
  // heartbeat.  They default to spawn_sample_hb, 6.0, and 0.0 respectively; as
  // if it were called like:
  // Spawn_OnAreaEnter( "spawn_sample_hb", 6.0, 0.0 );
object oModule = GetModule();
if (GetLocalInt(oModule,"nStampDay1") == 0) AdvanceTimeStamp(oModule,0,0,1,0);
else if (GetIsLaterThan(oModule))
    {
    MPOP_Process();
    AdvanceTimeStamp(oModule,0,0,1,0);
    }
int nNumber;
object oScan = GetFirstObjectInArea();
while (oScan != OBJECT_INVALID)
    {
    if (GetTag(oScan) == "MPOP_first")
        {
        if (d100() <= 80)
            {
            NESS_ActivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else
            {
            NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        }
    else if (GetTag(oScan) == "MPOP_second")
        {
        if (d100() <= 60)
            {
            NESS_ActivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else
            {
            NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        }
    else if (GetTag(oScan) == "MPOP_third")
        {
        if (d100() <= 40)
            {
            NESS_ActivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        else
            {
            NESS_DeactivateSpawn(oScan);
            NESS_ForceProcess(oScan);
            }
        }
    oScan = GetNextObjectInArea();
    }
  Spawn_OnAreaEnter();
}
