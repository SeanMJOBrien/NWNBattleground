void main()
{
object oPC = GetLastAttacker();
object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
int iType = GetBaseItemType(oItem);
int iTeam = GetLocalInt(OBJECT_SELF,"team");
int iDam = d6();
int iStr = GetAbilityModifier(ABILITY_STRENGTH,oPC);
if (iStr<=0) iStr = 0;
if(iType==BASE_ITEM_BATTLEAXE||iType==BASE_ITEM_DOUBLEAXE||iType==BASE_ITEM_DWARVENWARAXE||iType==BASE_ITEM_GREATAXE||
iType==BASE_ITEM_HALBERD) iDam+=4;
if(iType==BASE_ITEM_DIREMACE||iType==BASE_ITEM_HEAVYFLAIL||iType==BASE_ITEM_WARHAMMER) iDam+=2;
int iHP = GetLocalInt(OBJECT_SELF,"hp");
iHP-=iDam;
string sDam = IntToString(iDam);
string sHP =IntToString(iHP);
FloatingTextStringOnCreature("Gate takes "+sDam+" damage. "+sHP+" left.",oPC,FALSE);
SetLocalInt(OBJECT_SELF,"hp",iHP);
if (iHP<=0)
    {
    if (iTeam==1)
    {
    SpeakString("Good gate destroyed.",TALKVOLUME_SHOUT);
    ExecuteScript("award_good",GetModule());
    }
    else if (iTeam==2)
    {
    SpeakString("Evil gate destroyed.",TALKVOLUME_SHOUT);
    ExecuteScript("award_evil",GetModule());
    }
    DestroyObject(OBJECT_SELF,0.1f);
    }
}
