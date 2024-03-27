void main()
{
//SpawnScriptDebugger();
object oPC = GetPCSpeaker();
string sTag = "STORE_"+ GetTag(OBJECT_SELF);
object oStore = GetNearestObjectByTag(sTag);
int nBargain = GetLocalInt(oPC,GetTag(OBJECT_SELF)+"_BARGAIN");
int nMarkup;
int nMarkDown;
if (nBargain == 0)
    {
    nBargain = d20() + GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) + GetSkillRank(SKILL_APPRAISE, oPC);
    SetLocalInt(oPC,GetTag(OBJECT_SELF)+"_BARGAIN",nBargain);
    DelayCommand(300.0,DeleteLocalInt(oPC,GetTag(OBJECT_SELF)+"_BARGAIN"));
    }
if (nBargain != 0)
    {
    nMarkup = 50 - ((nBargain - 30) * 10);
    nMarkDown = ((nBargain - 1) * 3);
    if (nMarkDown > 80)  nMarkDown = 80 + ((nMarkDown - 80)/3);
    if (GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC)
        {
        nMarkup += 50;
        nMarkDown += -40;
        }
    if (nMarkup < 0) nMarkup = 0;
    if (nMarkDown < 0) nMarkDown = 0;
//    SendMessageToPC(oPC,"Markup:"+IntToString(nMarkup)+", Markdown:"+IntToString(nMarkDown));
    }
OpenStore(oStore,GetPCSpeaker(),nMarkup,nMarkDown);

}
