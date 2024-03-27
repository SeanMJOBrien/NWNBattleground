effect eFall = EffectKnockdown();
float fFallVariance = 3.0 + (IntToFloat(d10(1)) / 10);
void SlipCheck(object oVictim)
    {
    if ((GetLocalInt(oVictim,"nSlip"))&&(GetLocalInt(oVictim,"nSlipFire")))
        {
        if (ReflexSave(oVictim,4) == 0)
            {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFall,oVictim,fFallVariance);
            switch (d2())
                {
                case 1:
                FloatingTextStringOnCreature("You have lost your footing on the cavern's slimy floor.",oVictim,FALSE);
                break;
                case 2:
                FloatingTextStringOnCreature("Your feet lose their grip on the cavern's floor as it is covered with a slick grime.",oVictim,FALSE);
                break;
                }
            }
        }
    if(GetLocalInt(oVictim,"nSlip") == 0)
        {
        DeleteLocalInt(oVictim,"nSlipFire");
        return;
        }
    DelayCommand(6.0,SlipCheck(oVictim));
    }

void main()
{
object oEntering = GetEnteringObject();
int nRoll = 3+ d3(1);
if //(((GetIsPC(oEntering))||(GetFactionEqual(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oEntering),oEntering) == TRUE))&&
    (GetLocalInt(oEntering,"nSlipFire")==0)//)
    {
    DelayCommand(IntToFloat(nRoll),SlipCheck(oEntering));
    SetLocalInt(oEntering,"nSlipFire",1);
    }
SetLocalInt(oEntering,"nSlip",1);
}
