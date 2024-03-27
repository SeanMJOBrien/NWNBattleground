void main()
{
object oPC = GetLastAttacker();
int iCounter;
object oCounter;
object oScan;
float fDelay;
int iDiff;
object oArea = GetArea(OBJECT_SELF);
if (GetLocalInt(oArea,"iDartGame") == 1)
    {
    if (oPC == GetLocalObject(oArea,"oPlayer"+IntToString(GetLocalInt(oArea,"iNextPlayer"))))
        {
        if (GetLocalInt(oPC,"iZone") == TRUE)
            {
            SpeakString("Behind the line, please.");
            return;
            }
        int iCurrentScore = GetLocalInt(oPC,"iScore");
        int iDexBonus = GetAbilityModifier(ABILITY_DEXTERITY,oPC);
        if (GetRacialType(oPC) == RACIAL_TYPE_HALFLING) iDexBonus ++;
        int iBaseRegion = d20();
        // buffer score in the start of the round in case of a bust
        if ((GetLocalInt(oArea,"iToss") == 1))
            {
            SetLocalInt(oPC,"iScoreBuffer",iCurrentScore);
            }
        if ((d20() + iDexBonus) >= 20) //inner ring check
            {
            iCurrentScore = iCurrentScore - (iBaseRegion * 3);
            if (iCurrentScore >= 0) SpeakString(GetName(oPC)+":[inner ring] "+IntToString(iBaseRegion)+": "+IntToString(iCurrentScore)+".");
            }
        else if((d20() + iDexBonus) >= 19) //outer ring check
            {
            iCurrentScore = iCurrentScore - (iBaseRegion * 2);
            if (iCurrentScore >= 0) SpeakString(GetName(oPC)+":[outer ring] "+IntToString(iBaseRegion)+": "+IntToString(iCurrentScore)+".");
            }
        else if((d20() + iDexBonus) >= 19) //bullseye check
            {
            iCurrentScore = iCurrentScore - 25;
            if (iCurrentScore >= 0) SpeakString(GetName(oPC)+":[bullseye]: "+IntToString(iCurrentScore)+".");
            }
        else //otherwise default to iBaseRegion
            {
            iCurrentScore = iCurrentScore - (iBaseRegion);
            if (iCurrentScore >= 0) SpeakString(GetName(oPC)+": "+IntToString(iBaseRegion)+": "+IntToString(iCurrentScore)+".");
            }
        // on a bust, allow the player a winning shot check if their score is 20 or less.
         if  ((iCurrentScore < 0) & (GetLocalInt(oPC,"iScore") < 21))
            {
            if((d20() + iDexBonus) >= 19) //winning shot check
                {
                iCurrentScore = 0;
                SpeakString(GetName(oPC)+": "+IntToString(GetLocalInt((oPC),"iScore"))+": 0.");
                }
//            else
//                {
//                int iRetry = d20();
//                if ((GetLocalInt(oPC,"iScore") - iRetry) >= 0)
//                    {
//                    iCurrentScore = GetLocalInt(oPC,"iScore") - iRetry;
//                    SpeakString(GetName(oPC)+": "+IntToString(iRetry)+": "+IntToString(iCurrentScore)+".");
//                    }
//                }
            }
        // If still busted, say so and reset the score
        if (iCurrentScore < 0)
            {
            SpeakString(GetName(oPC)+" goes bust at "+IntToString(iCurrentScore)+": Score reset to "+IntToString(GetLocalInt(oPC,"iScoreBuffer"))+".");
            SetLocalInt(oArea,"iToss",3);
            iCurrentScore = GetLocalInt(oPC,"iScoreBuffer");
            }
        // if this is the winning shot
                SetLocalInt(oPC,"iScore",iCurrentScore);

        if (iCurrentScore == 0)
            {
            effect eVictory = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE );
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVictory, oPC);
            SpeakString(GetName(oPC)+" wins in round "+IntToString(GetLocalInt(oArea,"iRound"))+"!");
            if(GetLocalInt(oArea,"iPotSize") > 0)
                {
                SpeakString("The pot is worth "+IntToString(GetLocalInt(oArea,"iPotSize"))+".");
                GiveGoldToCreature(oPC, GetLocalInt(oArea,"iPotSize"));
                SetLocalInt(oArea,"iPotSize",0);
                }
            SetLocalInt(oArea,"iDartGame",0);
            SetLocalInt(oArea,"iNextPlayer",1);
            SetLocalInt(oArea,"iToss",1);
            SetLocalInt(oArea,"iRound",1);
            if (GetLocalInt(oArea,"iSummoned") > 0)
                {
                for (iCounter = 1; iCounter < 9; iCounter ++)
                    {
                    oCounter = GetLocalObject(oArea,"oPlayer"+IntToString(iCounter));
                    if ((GetIsPC(oCounter) != TRUE) & (GetTag(oCounter) == "ps_dartkobold"))
                        {
                        location lSummon = GetLocation(oCounter);
                        effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
                        fDelay = IntToFloat(d4(2)) * 0.3;
                        DelayCommand(fDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lSummon));
                        DelayCommand(fDelay,DestroyObject(oCounter,0.5));
                        DelayCommand(fDelay,SetCommandable(FALSE,oCounter));
                        SetLocalInt(oArea,"iSummoned", GetLocalInt(oArea,"iSummoned")-1);
//                        for (iDiff = iCounter; iDiff < 9; iDiff ++)
//                            {
//                            SetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iDiff),GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iDiff + 1)));
//                            }
//                        iCounter = iCounter -1;
                        }

                   }
                }
            for (iCounter = 1; iCounter < 9; iCounter ++)
                {
                oCounter = GetLocalObject(oArea,"oPlayer"+IntToString(iCounter));
                DeleteLocalInt(oCounter,"iScore");
                SetLocalObject(oArea,"oPlayer"+IntToString(iCounter),OBJECT_INVALID);
                }
            SpeakString("Player queue cleared. You may start a new game at your leisure.");
            if (GetIsPC(oPC) == TRUE) DelayCommand(1.0,AssignCommand(oPC,ClearAllActions(TRUE)));
            return;
            }
        // cycle
        if (GetLocalInt(oArea,"iToss") >= 3)
            {
            SetLocalInt(oArea,"iNextPlayer",GetLocalInt(oArea,"iNextPlayer")+1);
            if (GetLocalObject(oArea,"oPlayer"+IntToString(GetLocalInt(oArea,"iNextPlayer"))) == OBJECT_INVALID)
                {
                SetLocalInt(oArea,"iNextPlayer",1);
                SetLocalInt(oArea,"iRound",(GetLocalInt(oArea,"iRound")+1));
                SpeakString("Round "+IntToString(GetLocalInt(oArea,"iRound"))+".");
                }
            SpeakString(GetName(GetLocalObject(oArea,"oPlayer"+IntToString(GetLocalInt(oArea,"iNextPlayer"))))+" is up.");
            SetLocalInt(oArea,"iToss",1);
            if (GetLocalInt(oArea,"iSummoned") > 0)
                {
                object oNext = GetLocalObject(oArea,"oPlayer"+IntToString(GetLocalInt(oArea,"iNextPlayer")));
//                object oCurrent = GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer")-1));
                if ((GetIsPC(oNext) != TRUE) & (oNext != OBJECT_INVALID))
                    {
                     DelayCommand(2.0,AssignCommand(oNext,ActionAttack(GetObjectByTag("ps_dartboard"))));
                    }
                if ((GetIsPC(oPC) != TRUE) & (oPC != OBJECT_INVALID))
                    {
                    DelayCommand(1.0,AssignCommand(oPC,ClearAllActions(TRUE)));
                    }
                }
            if (GetIsPC(oPC) == TRUE) DelayCommand(1.0,AssignCommand(oPC,ClearAllActions(TRUE)));
            return;
            }
        SetLocalInt(oArea,"iToss",(GetLocalInt(oArea,"iToss") +1));
        }

    }
}
