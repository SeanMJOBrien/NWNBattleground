void main()
{
effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
location lSummon = GetLocation(OBJECT_SELF);
int iCounter;
int iPlace;

AssignCommand(GetObjectByTag("ps_dartboard"),SpeakString("Your summoned opponent is being removed due to hostilities."));
for (iCounter = 1; iCounter < 9; iCounter ++)
    {
    object oCounter = GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iCounter));
    if (oCounter == OBJECT_SELF)
        {
        for (iPlace = iCounter; iPlace < 9; iPlace ++)
            {
            SetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iPlace),GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(iPlace + 1)));
            }
        if ((GetLocalInt(GetArea(OBJECT_SELF),"iDartGame") != 0) & (oCounter == GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer")))))
            {
            if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer"))) == OBJECT_INVALID)
                {
                SetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer",1);
                SetLocalInt(GetArea(OBJECT_SELF),"iRound",(GetLocalInt(GetArea(OBJECT_SELF),"iRound")+1));
                SpeakString("Round "+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iRound"))+".");
                }
            SpeakString(GetName(GetLocalObject(GetArea(OBJECT_SELF),"oPlayer"+IntToString(GetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer"))))+" is up.");
            SetLocalInt(GetArea(OBJECT_SELF),"iToss",1);
            }
        }
    }
if (GetLocalObject(GetArea(OBJECT_SELF),"oPlayer1") == OBJECT_INVALID)
    {
    SetLocalInt(GetArea(OBJECT_SELF),"iDartGame",0);
    SetLocalInt(GetArea(OBJECT_SELF),"iNextPlayer",1);
    SetLocalInt(GetArea(OBJECT_SELF),"iToss",1);
    SetLocalInt(GetArea(OBJECT_SELF),"iRound",1);
    }
DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,lSummon));
DelayCommand(1.0,DestroyObject(OBJECT_SELF));
DelayCommand(1.0,SetCommandable(FALSE,OBJECT_SELF));
DeleteLocalInt(GetArea(OBJECT_SELF),"iSummoned");
}
