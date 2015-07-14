#include "_include_main"
void main()
{
object oItem = GetFirstItemInInventory(OBJECT_SELF);
object oPC = GetLastDisturbed();
int iDF = GetLocalInt(oPC,"df");
if (oItem==OBJECT_INVALID) return;
if (GetPlotFlag(oItem)==TRUE) return;
int iRoll;
string sRoll;
int iGP = GetGoldPieceValue(oItem);
effect eSmoke = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
int iReward;
if (iGP<=10)
    {
    SendColorMessage(oPC,1,"Your sacrificial gift is scoffed at.");
    DestroyObject(oItem);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=11&&iGP<=100)
    {
    SendColorMessage(oPC,2,"Your gift is reluctantly accepted. +1 XP.");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=101&&iGP<=250)
    {
    iRoll = d6(3)+1;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your gift is accepted. +"+sRoll+" XP. +1 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=251&&iGP<=1000)
    {
    iRoll = d8(4)+2;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your gift is readily accepted. +"+sRoll+" XP. +2 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=1001&&iGP<=5000)
    {
    iRoll = d10(5)+3;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your gift is happily accepted. +"+sRoll+" XP. +3 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+3);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=5001&&iGP<=25000)
    {
    iRoll = d12(6)+4;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your gift is heartily accepted. +"+sRoll+" XP. +4 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>=25001&&iGP<=125000)
    {
    iRoll = d20(7)+6;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your diety is very pleased with your offering. +"+sRoll+" XP. +5 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+5);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>125001&&iGP<=1250000)
    {
    iRoll = d20(8)+12;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your diety is very pleased with your offering. +"+sRoll+" XP. +6 DF");
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+6);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
if (iGP>1250001)
    {
    iRoll = d20(10)+18;
    sRoll = IntToString(iRoll);
    SendColorMessage(oPC,2,"Your diety is very pleased with your offering. +"+sRoll+" XP. +8 DF");
    DelayCommand(2.0f,SendColorMessage(oPC,2,"Damn. I can't believe you burned that up! +10 DF"));
    DestroyObject(oItem);
    GiveXPToCreature(oPC,iRoll);
    SetLocalInt(oPC,"df",iDF+18);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
}
