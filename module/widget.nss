void main()
{
object oPC = GetItemActivator();
object oWidget = GetItemPossessedBy(oPC,"widget");
object oArea = GetArea(oPC);
string sArea = GetTag(oArea);
int iRank = GetLocalInt(oWidget,"score");
if (sArea=="start")
    {
    FloatingTextStringOnCreature("Score = "+IntToString(iRank),oPC,TRUE);
    return;
    }
object oTarget = GetItemActivatedTarget();
if (oPC==oTarget)
    {
    AssignCommand(oPC,ActionStartConversation(oPC,"conv_pcmain",FALSE,FALSE));
    }
/*if (GetTag(oTarget)=="resource_node")
    {
    string sName = GetName(oTarget);
    }*/
    object oMod = GetModule();
    int iPCTeam = GetLocalInt(oPC,"team");
    int iTeam = GetLocalInt(oTarget,"team");
    string sRes = GetLocalString(oTarget,"res");
    string sTeam = IntToString(iPCTeam);
    int iNow = GetLocalInt(oMod,sRes+"max");
    int iGP = GetGold(oPC);
    int iWood = GetLocalInt(oMod,sTeam+"wd");
    int iStone = GetLocalInt(oMod,sTeam+"sn");
    int iCP = GetLocalInt(oPC,"cp");
    int iCostGP = iNow*100;
    int iCostMat = iNow*5;
    string sTag = GetTag(oTarget);
if (sTag=="resource_node")
    {
    if (iPCTeam!=iTeam)
        {
        FloatingTextStringOnCreature("<cþ  >Wrong team.</c>",oPC,0);
        return;
        }
    if (iGP<iCostGP)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Gold. You need "+IntToString(iCostGP)+" GP.</c>",oPC,0);
        return;
        }
    if (iWood<iCostMat)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Wood. You need "+IntToString(iCostMat)+" Wood.</c>",oPC,0);
        return;
        }
    if (iStone<iCostMat)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Stone. You need "+IntToString(iCostMat)+" Stone.</c>",oPC,0);
        return;
        }
    if (iCP<10)
        {
        FloatingTextStringOnCreature("<cþ  >You need at least 10 CP to order that improvement.</c>",oPC,0);
        return;
        }
    SetLocalInt(oPC,"cp",iCP-10);
    SetLocalInt(oMod,sRes+"max",iNow+1);
    string sNow = IntToString(iNow+1);
    AssignCommand(oPC,TakeGoldFromCreature(iCostGP,oPC,1));
    GiveXPToCreature(oPC,25);
    SetLocalInt(oMod,sTeam+"wd",iWood-iCostMat);
    SetLocalInt(oMod,sTeam+"sn",iStone-iCostMat);
    FloatingTextStringOnCreature("<c þ >You increase the infrastructure of the "+GetName(oTarget)+" to "+sNow+". +1 Score.</c>",oPC,0);
    SetLocalInt(oWidget,"score",iRank+1);
    }
if (sTag=="military_node")
    {
    iNow = GetLocalInt(oMod,sTeam+"milmax");
    iWood = GetLocalInt(oMod,sTeam+"wd");
    int iEquip =GetLocalInt(oMod,sTeam+"eq");
    iStone = GetLocalInt(oMod,sTeam+"sn");
    iCP = GetLocalInt(oPC,"cp");
    iCostGP = iNow*100;
    iCostMat = iNow*5;
    if (iPCTeam!=iTeam)
        {
        FloatingTextStringOnCreature("<cþ  >Wrong team.</c>",oPC,0);
        return;
        }
    if (iGP<iCostGP)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Gold. You need "+IntToString(iCostGP)+" GP.</c>",oPC,0);
        return;
        }
    if (iWood<iCostMat)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Wood. You need "+IntToString(iCostMat)+" Wood.</c>",oPC,0);
        return;
        }
    if (iStone<iCostMat)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Stone. You need "+IntToString(iCostMat)+" Stone.</c>",oPC,0);
        return;
        }
        if (iEquip<iCostMat)
        {
        FloatingTextStringOnCreature("<cþ  >You do not have enough Equipment. You need "+IntToString(iCostMat)+" Equipment.</c>",oPC,0);
        return;
        }
    if (iCP<10)
        {
        FloatingTextStringOnCreature("<cþ  >You need at least 10 CP to order that improvement.</c>",oPC,0);
        return;
        }
    SetLocalInt(oPC,"cp",iCP-10);
    SetLocalInt(oMod,sTeam+"milmax",iNow+1);
    string sNow = IntToString(iNow+1);
    AssignCommand(oPC,TakeGoldFromCreature(iCostGP,oPC,1));
    GiveXPToCreature(oPC,25);
    SetLocalInt(oMod,sTeam+"wd",iWood-iCostMat);
    SetLocalInt(oMod,sTeam+"sn",iStone-iCostMat);
    SetLocalInt(oMod,sTeam+"eq",iStone-iCostMat);
    FloatingTextStringOnCreature("<c þ >You increase the infrastructure of training level of your troops to "+sNow+". +1 Score.</c>",oPC,0);
    object oWidget = GetItemPossessedBy(oPC,"widget");
    int iRank = GetLocalInt(oWidget,"score");
    SetLocalInt(oWidget,"score",iRank+1);
    }
if (sTag=="resource")
    {
    string sName = GetName(oTarget);
    string sBonus;
    if (sName=="<c þþ>Adamantine</c>") sBonus="ad";
    if (sName=="<c þþ>Mithril</c>") sBonus="mt";
    if (sName=="<c þþ>Steel</c>") sBonus="st";
    if (sName=="<c þþ>Food</c>") sBonus="fd";
    if (sName=="<c þþ>Iron</c>") sBonus="ir";
    if (sName=="<c þþ>Hide</c>") sBonus="hd";
    if (sName=="<c þþ>Wood</c>") sBonus="wd";
    if (sName=="<c þþ>Copper</c>") sBonus="cp";
    if (sName=="<c þþ>Equipment</c>") sBonus="eq";
    if (sName=="<c þþ>Ironwood</c>") sBonus="iw";
    if (sName=="<c þþ>Stone</c>") sBonus="sn";
    if (sName=="<c þþ>Chicken Eggs</c>") sBonus="fd";
    if (sName=="<c þþ>Milk</c>") sBonus="fd";
    if (sName=="<c þþ>Meat</c>") sBonus="fd";
    if (sName=="<c þþ>Fish</c>") sBonus="fd";
    if (sName=="<c þþ>Cheese</c>") sBonus="fd";
    if (sName=="<c þþ>Snozberries</c>") sBonus="fd";
    if (sName=="<c þþ>Lembas Bread</c>") sBonus="fd";
    int iOld = GetLocalInt(oMod,sTeam+sBonus);
    SetLocalInt(oMod,sTeam+sBonus,iOld+1);
    DestroyObject(oTarget);
    FloatingTextStringOnCreature("<c þ >One unit of "+sName+" is added to your team's reserves. +1 CP. +1 Score. +10 XP.",oPC,0);
    SetLocalInt(oWidget,"score",iRank+1);
    SetLocalInt(oPC,"cp",iCP+1);
    GiveXPToCreature(oPC,10);
    }
if (GetBaseItemType(oTarget)==BASE_ITEM_CREATUREITEM)
    {
    AssignCommand(oPC,ActionEquipItem(oTarget,INVENTORY_SLOT_CARMOUR));
    }
if (GetObjectType(oTarget)==OBJECT_TYPE_DOOR)
    {
    string sHP = IntToString(GetLocalInt(oTarget,"hp"));
    AssignCommand(oTarget,ActionSpeakString("HPs are "+sHP,TALKVOLUME_TALK));
    }
if (sTag=="tnode")
    {
    int iMana = GetLocalInt(oPC,"mana");
    int iTTeam = GetLocalInt(oTarget,"team");
    if (iTeam!=iTTeam)
        {
        FloatingTextStringOnCreature("<cþ  >Wrong node.</c>",oPC,0);
        return;
        }
        if (iMana<20)
        {
        FloatingTextStringOnCreature("<cþ  >You need at least 20 Mana to summon a turret.</c>",oPC,0);
        return;
        }
    int iTnum = GetLocalInt(oMod,sTeam+"tnum");
        if (iTnum>=4)
        {
        FloatingTextStringOnCreature("<cþ  >You may only have 4 turrets.</c>",oPC,0);
        return;
        }
    SetLocalInt(oMod,sTeam+"tnum",iTnum+1);
    SetLocalInt(oPC,"mana",iMana-20);
    location lHere = GetLocation(oTarget);
    if (iTeam==1) CreateObject(OBJECT_TYPE_CREATURE,"manatrt_good",lHere,TRUE);
    if (iTeam==2) CreateObject(OBJECT_TYPE_CREATURE,"manatrt_evil",lHere,TRUE);
    }
}
