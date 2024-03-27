//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
#include "ps_mpop_process"
#include "spawn_functions"

int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
  {
    switch (nCR)
    {
    case 1:
      switch(d6(1))
      {
        case 1: sRetTemplate = "NW_SKELETON"; break;
        case 2: sRetTemplate = "NW_ZOMBIE01"; break;
        case 3: sRetTemplate = "NW_NIXIE"; break;
        case 4: sRetTemplate = "NW_ORCA"; break;
        case 5: sRetTemplate = "NW_ORCB"; break;
        case 6: sRetTemplate = "NW_BTLFIRE"; break;
      }
      break;
    case 2:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_KOBOLD004"; break;
        case 2: sRetTemplate = "NW_KOBOLD005"; break;
        case 3: sRetTemplate = "NW_KOBOLD003"; break;
        case 4: sRetTemplate = "NW_PIXIE"; break;
    }
      break;
    case 3:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_BTLBOMB"; break;
        case 2: sRetTemplate = "NW_BTLFIRE002"; break;
        case 3: sRetTemplate = "NW_BTLSTINK"; break;
        case 4: sRetTemplate = "NW_NYMPH"; break;
      }
      break;
    default:
       sRetTemplate = "";
       break;
    }
  }

  else if (sGroupType == "crypt")
  {
    switch (nCR)
    {
    case 1:
      switch(d4(1))
      {
        case 1:
        case 2: sRetTemplate = "NW_SKELETON"; break;
        case 3: sRetTemplate = "NW_ZOMBIE01"; break;
        case 4: sRetTemplate = "NW_ZOMBIE02"; break;
      }
      break;
    case 2:
      sRetTemplate = "NW_GHOUL";
      break;
    case 3:
      sRetTemplate = "NW_SHADOW";
      break;
    default:
       sRetTemplate = "";
       break;
    }  }

  else
  {
    // unknown group type
    sRetTemplate = "";
  }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
  {
    return 0.0;
  }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
  {
    return 1.;
  }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    if (GetStringLeft(sTemplate, 7) == "scaled_")
    {
      float fEncounterLevel;
      int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
      string sGroupType = GetStringRight(sTemplate,
          GetStringLength(sTemplate) - 7);

      // First Time in for this encounter?
      if (! nScaledInProgress)
      {

        // First time in - find the party level
        int nTotalPCs = 0;
        int nTotalPCLevel = 0;

        object oArea = GetArea(OBJECT_SELF);

        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
          if (GetIsPC(oPC) == TRUE)
          {
              nTotalPCs++;
              nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
          }
          oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
          fEncounterLevel = 0.0;
        }
        else
        {
          fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
        }

        // Save this for subsequent calls
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

        // We're done when the CRs chosen add up to the
        // desired encounter level
        SetLocalInt(oSpawn, "ScaledCallCount", 0);
        SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
      }


      fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
      int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

      // For simplicity, I'm not supporting creatures with CR < 1.0)
      if (fEncounterLevel < 1.0)
      {
        // We're done... No creatures have CR low enough to add to this encounter
        sRetTemplate = "";
      }

      else
      {
        // randomly choose a CR at or below the remaining (uncovered) encounter
        // level
        int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

        // cap to the largest CR we currently support in GetTemplateByCR
        if (nCR > 3)
        {
          nCR = 3;
        }

        sRetTemplate = GetTemplateByCR(nCR, sGroupType);


        // Convert CR to Encounter Level equivalent so it can be correctly
        // subtracted.  This does the real scaling work
        float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
        float fElRemaining = 1.0 - fELEquiv;

        fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
      }

      nScaledCallCount++;
      SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

      nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

      if (nScaledCallCount >= nSpawnNumber)
      {
        // reset...
        SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
      }
    }

    // cr_militia
    if (sTemplate == "cr_militia")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "cr_militia_m";
            break;
            case 2:
            sRetTemplate = "cr_militia_f";
            break;
        }
    }
    //

    // pg_guard
    if (sTemplate == "pg_guard")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "pg_guard_m";
            break;
            case 2:
            sRetTemplate = "pg_guard_f";
            break;
        }
    }
    //

    // Goblins
    if (sTemplate == "goblins_low")
    {
        if (d2(1) == 1)
        {
            sRetTemplate = "NW_GOBLINA";
        }
        else
        {
            sRetTemplate = "NW_GOBLINB";
        }
    }
    //

    // Goblins and Boss
    if (sTemplate == "gobsnboss")
    {
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Scaled Encounter
    if (sTemplate == "scaledgobs")
    {
        // Initialize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        // Cycle through PCs in Area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
            oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        // Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            // Spawn Something with CR 1
            case 1:
                sRetTemplate = "cr1creature";
            break;
            //

            // Spawn Something with CR 5
            case 5:
                sRetTemplate = "cr5creature";
            break;
            //
        }
    }
    //

    // Pirates and Boss
    if (sTemplate == "pirates")
    {
        // Delay the Spawn for 45 Minutes
        if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
            if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
                // Start the Delay
                SetLocalInt(oSpawn, "DelayStarted", TRUE);
                DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
            sRetTemplate = "";
            return sRetTemplate;
        }
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Advanced Scaled Encounter
    if (sTemplate == "advscaled")
    {
        //Initalize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        //Cycle through PCs in area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
        oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        //Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            //Spawn Something with CR 1
            case 1:
                switch (d6())
                {
                    case 1: sRetTemplate = "cr1example1";
                    case 2: sRetTemplate = "cr1example2";
                    case 3: sRetTemplate = "cr1example3";
                    case 4: sRetTemplate = "cr1example4";
                    case 5: sRetTemplate = "cr1example5";
                    case 6: sRetTemplate = "cr1example6";
                }
            break;
        }
    }
    //

    // Encounters
    if (sTemplate == "encounter")
    {
        // Declare Variables
        int nCounter, nCounterMax;
        string sCurrentTemplate;

        // Retreive and Increment Counter
        nCounter = GetLocalInt(oSpawn, "GroupCounter");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nCounter++;

        // Retreive CurrentTemplate
        sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

        // Check CounterMax
        if (nCounter > nCounterMax)
        {
            sCurrentTemplate = "";
            nCounter = 1;
        }

        if (sCurrentTemplate != "")
        {
            // Spawn Another CurrentTemplate
            sRetTemplate = sCurrentTemplate;
        }
        else
        {
            // Choose New CurrentTemplate and CounterMax
            switch (Random(2))
            {
                // Spawn 1-4 NW_DOGs
                case 0:
                sRetTemplate = "NW_DOG";
                nCounterMax = Random(4) + 1;
                break;
            }
            // Record New CurrentTemplate and CounterMax
            SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

        // Record Counter
        SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
    //

    //
    if (sTemplate == "kobolds")
    {
        int nKobold = Random(6) + 1;
        sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }
    //
    //Sily's Groups
    if (sTemplate == "sily_goblin_scout")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "an_goblin";
            break;
            case 2:
            sRetTemplate = "an_goblin2";
            break;
        }
    }
int iRoll;
if (sTemplate == "trog_group")
    {
    iRoll = d100(1);
    if ((iRoll > 0) && (iRoll <= 40)) sRetTemplate = "ps_basetrog001";
    else if ((iRoll > 40) && (iRoll <= 79)) sRetTemplate = "ps_basetrog002";
    else if ((iRoll > 79) && (iRoll <= 89)) sRetTemplate = "ps_basetrog003";
    else if ((iRoll > 89) && (iRoll <= 98)) sRetTemplate = "ps_basetrog004";
    else if ((iRoll > 98) && (iRoll <= 100)) sRetTemplate = "ps_basetrog005";
    }
if (sTemplate == "trog_kobold_group")
    {
    switch(d2(1))
        {
        case 1:
        sRetTemplate = "ps_basekobold001";
        break;
        case 2:
            iRoll = d100(1);
            if ((iRoll > 0) && (iRoll <= 40)) sRetTemplate = "ps_basetrog001";
            else if ((iRoll > 40) && (iRoll <= 79)) sRetTemplate = "ps_basetrog002";
            else if ((iRoll > 79) && (iRoll <= 89)) sRetTemplate = "ps_basetrog003";
            else if ((iRoll > 89) && (iRoll <= 98)) sRetTemplate = "ps_basetrog004";
            else if ((iRoll > 98) && (iRoll <= 100)) sRetTemplate = "ps_basetrog005";
        break;
        }
    }
if ((sTemplate == "WILDENC1") || (sTemplate == "WILDENC4")  || (sTemplate == "WILDENC6"))
    {
    object oArea = GetArea(oSpawn);
    string sEncounter = GetLocalString(oArea,"Encounter");
//    SendMessageToPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oSpawn),"Group routine "+sEncounter);
    if (sEncounter == "firebeetles") sRetTemplate = "wild_001";
    else if (sEncounter == "blackbear") sRetTemplate = "wild_002";
    else if (sEncounter == "cougar") sRetTemplate = "wild_003";
    else if (sEncounter == "wolf") sRetTemplate = "wild_004";
    else if (sEncounter == "werewolf") sRetTemplate = "wild_005";
    else if (sEncounter == "boar") sRetTemplate = "wild_006";
    else if (sEncounter == "brownbear") sRetTemplate = "wild_007";
    else if (sEncounter == "troll") sRetTemplate = "wild_008";
    else if (sEncounter == "willowisp") sRetTemplate = "wild_009";
    else if (sEncounter == "deer")  sRetTemplate = "ps_wildgame01";
    else if (sEncounter == "boar")  sRetTemplate = "ps_wildgame03";
    else if (sEncounter == "badger")  sRetTemplate = "ps_wildgame02";
    else if (sEncounter == "ox")  sRetTemplate = "ps_wildgame04";


    }

if (sTemplate == "MPOP_TREAS")
    {
    switch (d6())
        {
        case 1: sRetTemplate = "ps_mpop_treas01"; break;
        case 2: sRetTemplate = "ps_mpop_treas02"; break;
        case 3: sRetTemplate = "ps_mpop_treas03"; break;
        case 4: sRetTemplate = "ps_mpop_treas04"; break;
        case 5: sRetTemplate = "ps_mpop_treas05"; break;
        case 6: sRetTemplate = "ps_mpop_treas06"; break;
        }

    }
if (sTemplate == "scenery")
    {
    switch (d6())
        {
        case 1: sRetTemplate = "wildscene_001"; break;
        case 2: sRetTemplate = "wildscene_002"; break;
        case 3: sRetTemplate = "wildscene_003"; break;
        case 4: sRetTemplate = "wildscene_004"; break;
        case 5: sRetTemplate = ""; break;
        case 6: sRetTemplate = ""; break;
        }
    }
if (sTemplate == "carnage")
    {
    switch (d6())
        {
        case 1: sRetTemplate = "plc_bloodstain"; break;
        case 2: sRetTemplate = "plc_garbage"; break;
        case 3: sRetTemplate = "plc_bones"; break;
        case 4: sRetTemplate = "plc_arrowcorpse"; break;
        case 5: sRetTemplate = "plc_fplaguecrpse"; break;
        case 6: sRetTemplate = "corpse55"; break;
        }
    }


if ((sTemplate == "MPOP_first")||(sTemplate == "MPOP_second")||(sTemplate == "MPOP_third") || (sTemplate == "MPOP_chest"))
    {
    //SpawnScriptDebugger();

    object oMPOP = GetNearestObjectByTag("MPOP",oSpawn);
    if (oMPOP == OBJECT_INVALID)
        {
        object oSurrogate = GetWaypointByTag(GetTag(GetArea(oSpawn)));
        oMPOP = GetNearestObjectByTag("MPOP",oSurrogate);
        }
    if (oMPOP == OBJECT_INVALID) return "";
    int nFight = FALSE;
    string sFirstPop;
    string sSecondPop;
    string sThirdPop;
    int nFirstStr;
    int nSecondStr;
    int nThirdStr;
    string sBuffer;
    string sPick;
    int nPickStr;
    int nBuffer;
    int nCount;
// For debugging
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oSpawn);
object oScan;
//        SendMessageToPC(oPC,sTemplate);
//    object oScan = GetFirstObjectInArea(GetArea(oSpawn));
//    while (oScan != OBJECT_INVALID)
//        {
//        if (GetObjectType(oScan) == OBJECT_TYPE_CREATURE) nCount ++;
//        oScan = GetNextObjectInArea(GetArea(oSpawn));
//        }
//    if (nCount > 25)
//        {
//        NESS_DeactivateSpawn(oSpawn);
//        return "";
//        }
    nCount = 1;
    sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    while (sBuffer != "")
        {
        nBuffer = StringToInt(GetSubString(sBuffer,5,3));
        if (nBuffer > nFirstStr)
            {
            nFirstStr = nBuffer;
            sFirstPop = sBuffer;
            }
        nCount ++;
        sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
        }
    if (sTemplate == "MPOP_chest")
        {
//        SendMessageToPC(oPC,"Processing chest.");
        int nChestN = d3(1);
        if (d100(1) <= (nFirstStr - 66))
            {
//            SendMessageToPC(oPC,"Resref: "+GetSubString(GetStringLowerCase(sFirstPop),0,4) + "_chest"+IntToString(nChestN));
            return (GetSubString(GetStringLowerCase(sFirstPop),0,4) + "_chest"+IntToString(nChestN));
            }
        else
            {
            NESS_DeactivateSpawn(oSpawn);
            return "";
            }
        }

    nCount = 1;
    sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    while (sBuffer != "")
        {
        nBuffer = StringToInt(GetSubString(sBuffer,5,3));
        if ((sBuffer != sFirstPop) && (nBuffer <= nFirstStr) && (nBuffer > nSecondStr) && (nBuffer > 0))
            {
            nSecondStr = nBuffer;
            sSecondPop = sBuffer;
            break;
            }
        nCount ++;
        sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
        }
    nCount = 1;
    sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
    while (sBuffer != "")
        {
        nBuffer = StringToInt(GetSubString(sBuffer,5,3));
        if ((sBuffer != sFirstPop) && (sBuffer != sSecondPop) && (nBuffer <= nSecondStr) && (nBuffer > nThirdStr) && (nBuffer > 0))
            {
            nThirdStr = nBuffer;
            sThirdPop = sBuffer;
            break;
            }
        nCount ++;
        sBuffer = GetLocalString(oMPOP,"Pop"+IntToString(nCount));
        }
    if (sFirstPop == "")
        {
        DeleteLocalInt(oSpawn,"SpawnBlank");
        NESS_DeactivateSpawn(oSpawn);
        return "";
        }
    if (((sTemplate == "MPOP_first") || (sTemplate == "MPOP_second")) && (sSecondPop != "") && (CompareForHostile(GetSubString(sFirstPop,0,4),GetSubString(sSecondPop,0,4)) == TRUE))
        {
        nFight = TRUE;
        float fRoll = (IntToFloat(nFirstStr) / (IntToFloat(nFirstStr) + IntToFloat(nSecondStr))) * 100.0;
        if (d100() <= FloatToInt(fRoll))
            {
            sPick = GetSubString(sFirstPop,0,4);
            nPickStr = nFirstStr;
            }
        else
            {
            sPick = GetSubString(sSecondPop,0,4);
            nPickStr = nSecondStr;
            }
        }
    else if ((sTemplate=="MPOP_first")||((sTemplate=="MPOP_second")&&(sSecondPop==""))||((sTemplate=="MPOP_third")&&(sSecondPop=="")&&(sThirdPop=="")))
        {
        sPick = GetSubString(sFirstPop,0,4);
        nPickStr = nFirstStr;
        }
    else if ((sTemplate=="MPOP_second")||((sTemplate=="MPOP_third")&&(sThirdPop=="")))
        {
        sPick = GetSubString(sSecondPop,0,4);
        nPickStr = nSecondStr;
        }
    else if (sTemplate=="MPOP_third")
        {
        sPick = GetSubString(sThirdPop,0,4);
        nPickStr = nThirdStr;
        }
    int nSpawnedNow = nSpawnCount;
//    int nSpawnedNow = GetLocalInt(oSpawn, "SpawnCount");
    int nSpawnNum = GetLocalInt(oSpawn, "SpawnNumber");
    int nSpawnBlank = GetLocalInt(oSpawn,"SpawnBlank");
    int nNoAppearing = GetLocalInt(GetModule(),sPick+"_MAX");
    if (GetLocalInt(oSpawn, "ForceDeactivateSpawn"))
        {
//        SendMessageToPC(oPC,"Spawn called on deactivated point.");
        return "";
        }
    if (nFight == TRUE) nPickStr = nPickStr * 2;
    if ((d100() > nPickStr))
        {
        nSpawnBlank ++;
        SetLocalInt(oSpawn,"SpawnBlank",nSpawnBlank);
//        SendMessageToPC(oPC,"Spawn Blank "+IntToString(nSpawnBlank)+"; SpawnNum = "+IntToString(nSpawnNum)+"; SpawnBlank ="+IntToString(nSpawnBlank)+";SpawnedNow = "+IntToString(nSpawnedNow)+"SN = "+IntToString(GetLocalInt(oSpawn, "f_SpawnNumber")));
        if ((nSpawnBlank + nSpawnedNow) >= (GetLocalInt(oSpawn, "f_SpawnNumber")))
        {
//        SendMessageToPC(oPC,"Deactivating spawn point");
        DeleteLocalInt(oSpawn,"SpawnBlank");
        NESS_DeactivateSpawn(oSpawn);
        }
        return "";
        }
    if (((nSpawnedNow >= nNoAppearing) && (nNoAppearing > 0))
    || ((GetLocalInt(GetModule(),sPick+"_NOCTURNAL") == TRUE)
    && (GetIsAreaAboveGround(GetArea(oSpawn)) == 1)
    && ((GetIsDay() == TRUE)|| (GetIsDawn() == TRUE)))
    || ((GetLocalInt(GetModule(),sPick+"_NATURAL") == TRUE) &&
        (GetIsAreaInterior(GetArea(oSpawn)) == 1))
    || ((GetLocalInt(GetModule(),sPick+"_SUBTERRAN") == TRUE) &&
        ((GetIsAreaInterior(GetArea(oSpawn)) == 0)
        || (GetIsAreaAboveGround(GetArea(oSpawn)) == 1)))
    || ((nSpawnBlank + nSpawnedNow + 1) >= (GetLocalInt(oSpawn, "f_SpawnNumber"))))
        {
            DeleteLocalInt(oSpawn,"SpawnBlank");
            NESS_DeactivateSpawn(oSpawn);
//            SendMessageToPC(oPC,"Deactivating spawn point; SpawnNum = "+IntToString(nSpawnNum)+"; SpawnBlank ="+IntToString(nSpawnBlank)+";SpawnedNow = "+IntToString(nSpawnedNow)+"SN = "+IntToString(GetLocalInt(oSpawn, "f_SpawnNumber")));
        }
//    SendMessageToPC(oPC,"Successful Spawn: SpawnedNow = "+IntToString(nSpawnedNow)+"SN = "+IntToString(GetLocalInt(oSpawn, "f_SpawnNumber")));

    int nPickRoll;
    if (sPick == "TRB1")
        {
        nPickRoll = d100();
        if (nPickRoll < 23) return "trb1_001";
        else if (nPickRoll < 46) return "trb1_002";
        else if (nPickRoll < 68) return "trb1_003";
        else if (nPickRoll < 90) return "trb1_004";
        else if (nPickRoll < 93) return "trb1_005";
        else if (nPickRoll < 96) return "trb1_006";
        else if (nPickRoll < 99) return "trb1_007";
        else return "trb1_008";
        }
    if (sPick == "TRB2")
        {
        nPickRoll = d100();
        if (nPickRoll < 26) return "trb2_001";
        else if (nPickRoll < 51) return "trb2_002";
        else if (nPickRoll < 76) return "trb2_003";
        else if (nPickRoll < 86) return "trb2_004";
        else if (nPickRoll < 95) return "trb2_005";
        else if (nPickRoll < 99) return "trb2_006";
        else return "trb2_007";
        }
    if (sPick == "TRB3")
        {
        nPickRoll = d100();
        if (nPickRoll < 20) return "trb3_001";
        else if (nPickRoll < 38) return "trb3_002";
        else if (nPickRoll < 56) return "trb3_003";
        else if (nPickRoll < 69) return "trb3_004";
        else if (nPickRoll < 81) return "trb3_005";
        else if (nPickRoll < 83) return "trb3_006";
        else if (nPickRoll < 89) return "trb3_007";
        else if (nPickRoll < 94) return "trb3_008";
        else if (nPickRoll < 97) return "trb3_009";
        else if (nPickRoll < 99) return "trb3_010";
        else if (nPickRoll < 100) return "trb3_011";
        else return "trb3_012";
        }

    if (sPick == "TRB4")
        {
        nPickRoll = d100();
        if (nPickRoll < 24) return "trb4_001";
        else if (nPickRoll < 47) return "trb4_002";
        else if (nPickRoll < 69) return "trb4_003";
        else if (nPickRoll < 91) return "trb4_004";
        else if (nPickRoll < 95) return "trb4_005";
        else if (nPickRoll < 99) return "trb4_006";
        else return "trb4_007";
        }

    if (sPick == "UND1")
        {
        nPickRoll = d100();
        if (nPickRoll < 23) return "und1_001";
        else if (nPickRoll < 45) return "und1_002";
        else if (nPickRoll < 68) return "und1_003";
        else if (nPickRoll < 91) return "und1_004";
        else if (nPickRoll < 95) return "und1_005";
        else if (nPickRoll < 98) return "und1_006";
        else return "ps_und007";
        }

    if (sPick == "RATS")
        {
        nPickRoll = d100();
        if (nPickRoll < 61) return "rats_001";
        else if (nPickRoll < 91) return "rats_002";
        else if (nPickRoll < 96) return "rats_003";
        else return "rats_004";
        }

    if (sPick == "ANTS")
        {
        nPickRoll = d100();
        if (nPickRoll < 91) return "ants_001";
        else return "ants_002";
        }

    if (sPick == "SHLD")
        {
        nPickRoll = d100();
        if (nPickRoll < 20) return "shld_b01";
        else if (nPickRoll < 38) return "shld_b02";
        else if (nPickRoll < 56) return "shld_b03";
        else if (nPickRoll < 65) return "shld_vet001";
        else if (nPickRoll < 73) return "shld_vet002";
        else if (nPickRoll < 81) return "shld_vet003";
        else if (nPickRoll < 85) return "shld_cpt001";
        else if (nPickRoll < 89) return "shld_cpt002";
        else if (nPickRoll < 92) return "shld_cpt003";
        else if (nPickRoll < 94) return "shld_thn001";
        else if (nPickRoll < 98) return "shld_thn002";
        else if (nPickRoll < 100) return "shld_priest";
        else return "shld_squire";
        }

    if (sPick == "UND2")
        {
        nPickRoll = d100();
        if (nPickRoll < 11) return "und2_001";
        else if (nPickRoll < 21) return "und2_002";
        else if (nPickRoll < 31) return "und2_003";
        else if (nPickRoll < 41) return "und2_004";
        else if (nPickRoll < 61) return "und2_005";
        else if (nPickRoll < 81) return "und2_006";
        else if (nPickRoll < 83) return "und2_007";
        else if (nPickRoll < 85) return "und2_008";
        else if (nPickRoll < 89) return "und2_009";
        else if (nPickRoll < 93) return "und2_010";
        else if (nPickRoll < 96) return "und2_011";
        else if (nPickRoll < 99) return "und2_012";
        else return "und2_013";
        }

    if (sPick == "TRB5")
        {
        nPickRoll = d100();
        if (nPickRoll < 11) return "trb5_001";
        else if (nPickRoll < 21) return "trb5_002";
        else if (nPickRoll < 30) return "trb5_003";
        else if (nPickRoll < 39) return "trb5_004";
        else if (nPickRoll < 48) return "trb5_005";
        else if (nPickRoll < 58) return "trb5_006";
        else if (nPickRoll < 68) return "trb5_007";
        else if (nPickRoll < 77) return "trb5_008";
        else if (nPickRoll < 87) return "trb5_009";
        else if (nPickRoll < 97) return "trb5_010";
        else if (nPickRoll < 100) return "trb5_011";
        else return "trb5_012";

        }

    if (sPick == "TRB6")
        {
        nPickRoll = d100();
        if (nPickRoll < 11) return "trb6_001";
        else if (nPickRoll < 21) return "trb6_002";
        else if (nPickRoll < 31) return "trb6_003";
        else if (nPickRoll < 41) return "trb6_004";
        else if (nPickRoll < 51) return "trb6_005";
        else if (nPickRoll < 56) return "trb6_006";
        else if (nPickRoll < 61) return "trb6_007";
        else if (nPickRoll < 66) return "trb6_008";
        else if (nPickRoll < 71) return "trb6_009";
        else if (nPickRoll < 73) return "trb6_010";
        else return "trb6_011";

        }
    if (sPick == "STRG")
        {
        nPickRoll = d2();
        if (nPickRoll == 1) return "strg_001";
        else return "strg_002";
        }
    if (sPick == "BTTL")
        {
        nPickRoll = d100();
        if (nPickRoll < 81) return "bttl_001";
        if (nPickRoll < 86) return "bttl_002";
        if (nPickRoll < 96) return "bttl_003";
        else return "bttl_004";
        }
    if (sPick == "LEEC")
        {
        nPickRoll = d100();
        if (nPickRoll < 86) return "leec_001";
        if (nPickRoll < 99) return "leec_002";
        else return "leec_003";
        }
    if (sPick == "UND3")
        {
        nPickRoll = d100();
        if (nPickRoll < 9) return "und3_thrall001";
        else if (nPickRoll < 17) return "und3_thrall002";
        else if (nPickRoll < 25) return "und3_thrall3";
        else if (nPickRoll < 33) return "und3_skeleton001";
        else if (nPickRoll < 41) return "und3_skeleton002";
        else if (nPickRoll < 49) return "und3_skeleton003";
        else if (nPickRoll < 57) return "und3_ghoul01";
        else if (nPickRoll < 65) return "und3_ghoul2";
        else if (nPickRoll < 73) return "und3_ghoul3";
        else if (nPickRoll < 81) return "und3_ghoul4";
        else if (nPickRoll < 84) return "und3_ghast";
        else if (nPickRoll < 86) return "und3_harpy";
        else if (nPickRoll < 89) return "und3_gargoyle";
        else if (nPickRoll < 91) return "spid_bone_01";
        else if (nPickRoll < 93) return "spid_bone_2";
        else if (nPickRoll < 96) return "scarecrow";
        else if (nPickRoll < 98) return "flying_eye";
        else return "vampire001";
        }
    if (sPick == "TRB7")
        {
        nPickRoll = d100();
        if (nPickRoll < 18) return "trb7_001";
        else if (nPickRoll < 35) return "trb7_002";
        else if (nPickRoll < 52) return "trb7_003";
        else if (nPickRoll < 69) return "trb7_004";
        else if (nPickRoll < 94) return "trb7_005";
        else if (nPickRoll < 99) return "trb7_006";
        else return "trb7_007";
        }
    if (sPick == "DSRT")
        {
        nPickRoll = d100();
        if (nPickRoll < 11) return "dsrt_001";
        else if (nPickRoll < 21) return "dsrt_002";
        else if (nPickRoll < 31) return "dsrt_003";
        else if (nPickRoll < 41) return "dsrt_004";
        else if (nPickRoll < 50) return "dsrt_005";
        else if (nPickRoll < 58) return "dsrt_006";
        else if (nPickRoll < 66) return "dsrt_007";
        else if (nPickRoll < 71) return "dsrt_008";
        else if (nPickRoll < 76) return "dsrt_009";
        else if (nPickRoll < 81) return "dsrt_010";
        else if (nPickRoll < 87) return "dsrt_011";
        else if (nPickRoll < 93) return "dsrt_012";
        else if (nPickRoll < 97) return "dsrt_013";
        else if (nPickRoll < 100) return "dsrt_014";
        else return "dsrt_doom2";
        }
    if (sPick == "DKDR")
        {
        nPickRoll = d100();
        if (nPickRoll < 17) return "dkdr_015";
        else if (nPickRoll < 32) return "dkdr_001";
        else if (nPickRoll < 42) return "dkdr_012";
        else if (nPickRoll < 47) return "dkdr_011";
        else if (nPickRoll < 52) return "dkdr_010";
        else if (nPickRoll < 54) return "dkdr_009";
        else if (nPickRoll < 64) return "dkdr_002";
        else if (nPickRoll < 71) return "dkdr_005";
        else if (nPickRoll < 78) return "dkdr_008";
        else if (nPickRoll < 88) return "dkdr_003";
        else if (nPickRoll < 91) return "dkdr_013";
        else if (nPickRoll < 93) return "dkdr_006";
        else if (nPickRoll < 95) return "dkdr_014";
        else if (nPickRoll < 98) return "dkdr_004";
        else return "dkdr_007";
        }

    if (sPick == "QWIK")
        {
        nPickRoll = d100();
        if (nPickRoll < 17) return "qwik_001";
        else if (nPickRoll < 33) return "qwik_002";
        else if (nPickRoll < 49) return "qwik_003";
        else if (nPickRoll < 65) return "qwik_004";
        else if (nPickRoll < 81) return "qwik_005";
        else if (nPickRoll < 97) return "qwik_006";
        else return "qwik_007";
        }

    if (sPick == "TRB8")
        {
        nPickRoll = d100();
        if (nPickRoll < 4) return "trb8_001";
        else if (nPickRoll < 7) return "trb8_002";
        else if (nPickRoll < 10) return "trb8_003";
        else if (nPickRoll < 17) return "trb8_004";
        else if (nPickRoll < 24) return "trb8_005";
        else if (nPickRoll < 31) return "trb8_006";
        else if (nPickRoll < 43) return "trb8_007";
        else if (nPickRoll < 55) return "trb8_008";
        else if (nPickRoll < 67) return "trb8_009";
        else if (nPickRoll < 79) return "trb8_010";
        else if (nPickRoll < 85) return "trb8_011";
        else if (nPickRoll < 86) return "trb8_012";
        else if (nPickRoll < 87) return "trb8_013";
        else if (nPickRoll < 94) return "trb8_014";
        else return "trb8_015";
        }
    if (sPick == "SCOR")
        {
        nPickRoll = d100();
        if (nPickRoll < 80) return "scor_001";
        else if (nPickRoll < 97) return "scor_002";
        else return "scor_003";
        }
    if (sPick == "JBLX")
        {
        nPickRoll = d100();
        if (nPickRoll < 4) return "jblx_001";
        else if (nPickRoll < 34) return "jblx_002";
        else if (nPickRoll < 40) return "jblx_004";
        else if (nPickRoll < 50) return "jblx_005";
        else if (nPickRoll < 55) return "jblx_006";
        else if (nPickRoll < 60) return "jblx_007";
        else if (nPickRoll < 70) return "jblx_008";
        else if (nPickRoll < 75) return "jblx_009";
        else if (nPickRoll < 80) return "jblx_010";
        else if (nPickRoll < 81) return "jblx_011";
        else return "jblx_012";
        }
    if (sPick == "YNTI")
        {
        nPickRoll = d100();
        if (nPickRoll < 14) return "ynti_001";
        else if (nPickRoll < 27) return "ynti_002";
        else if (nPickRoll < 37) return "ynti_003";
        else if (nPickRoll < 42) return "ynti_004";
        else if (nPickRoll < 45) return "ynti_005";
        else if (nPickRoll < 49) return "ynti_006";
        else if (nPickRoll < 52) return "ynti_007";
        else if (nPickRoll < 65) return "ynti_008";
        else if (nPickRoll < 78) return "ynti_009";
        else if (nPickRoll < 91) return "ynti_010";
        else return "ynti_011";
        }

    if (sPick == "DEMN")
        {
        nPickRoll = d100();
        if (nPickRoll < 10) return "demn_001";
        else if (nPickRoll < 19) return "demn_002";
        else if (nPickRoll < 28) return "demn_003";
        else if (nPickRoll < 58) return "demn_004";
        else if (nPickRoll < 63) return "demn_005";
        else if (nPickRoll < 73) return "demn_006";
        else if (nPickRoll < 83) return "demn_007";
        else if (nPickRoll < 89) return "demn_008";
        else if (nPickRoll < 91) return "demn_009";
        else if (nPickRoll < 95) return "demn_020";
        else if (nPickRoll < 97) return "demn_011";
        else if (nPickRoll < 89) return "demn_019";
        else if (nPickRoll < 93) return "demn_013";
        else if (nPickRoll < 95) return "demn_014";
        else if (nPickRoll < 96) return "demn_015";
        else if (nPickRoll < 97) return "demn_017";
        else switch (d8())
            {
            case 1:  return "demn_019"; break;
            case 2:  return "demn_013"; break;
            case 3:  return "demn_014"; break;
            case 4:  return "demn_015"; break;
            case 5:  return "demn_017"; break;
            case 6:  return "demn_016"; break;
            case 7:  switch (d2())
                    {
                    case 1:  return "demn_018"; break;
                    case 2:  return "demn_023"; break;
                    }break;
            case 8: switch (d2())
                    {
                    case 1:  return "demn_022"; break;
                    case 2:  return "demn_021"; break;
                    } break;
            }
        }


    return "";



        }
// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
