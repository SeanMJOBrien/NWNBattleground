#include "nw_i0_generic"
// Item Categories
// 0 = Gold, 1 = Weapons, 2 =Armor, 3 = Jewelery, 4 = Raw Materials
// 5 = Potions, 6 = Scrolls, 7 = Miscellaneous, 8 = ALL

 int MatchItemCategory(object oItemSelf, object oItemToMatch)
{
//Declarations
int nTypeSelf = GetBaseItemType(oItemSelf);
int nTypeToMatch = GetBaseItemType(oItemToMatch);
int nCategorySelf;
int nCategoryToMatch;
//End Declarations

if (nTypeSelf == BASE_ITEM_GOLD)
    { nCategorySelf = 0; }
else if (nTypeSelf == BASE_ITEM_BASTARDSWORD||BASE_ITEM_BATTLEAXE||BASE_ITEM_BOLT||BASE_ITEM_BULLET||BASE_ITEM_CLUB||BASE_ITEM_DAGGER||BASE_ITEM_DART||BASE_ITEM_DIREMACE||BASE_ITEM_DOUBLEAXE||BASE_ITEM_DWARVENWARAXE||BASE_ITEM_GREATAXE||BASE_ITEM_GREATSWORD||BASE_ITEM_HALBERD||BASE_ITEM_HANDAXE||BASE_ITEM_HEAVYCROSSBOW||BASE_ITEM_HEAVYFLAIL||BASE_ITEM_KAMA||BASE_ITEM_KATANA||BASE_ITEM_KUKRI||BASE_ITEM_LIGHTCROSSBOW||BASE_ITEM_LIGHTFLAIL||BASE_ITEM_LIGHTHAMMER||BASE_ITEM_LIGHTMACE||BASE_ITEM_LONGBOW||BASE_ITEM_LONGSWORD||BASE_ITEM_MORNINGSTAR||BASE_ITEM_QUARTERSTAFF||BASE_ITEM_RAPIER||BASE_ITEM_SCIMITAR||BASE_ITEM_SCYTHE||BASE_ITEM_SHORTBOW||BASE_ITEM_SHORTSPEAR||BASE_ITEM_SHORTSWORD||BASE_ITEM_SHURIKEN||BASE_ITEM_SICKLE||BASE_ITEM_SLING||BASE_ITEM_THROWINGAXE||BASE_ITEM_TWOBLADEDSWORD||BASE_ITEM_TRIDENT|| BASE_ITEM_WARHAMMER||BASE_ITEM_WHIP)
    { nCategorySelf = 1; }
else if (nTypeSelf == BASE_ITEM_ARMOR||BASE_ITEM_BELT||BASE_ITEM_CLOAK||BASE_ITEM_HELMET||BASE_ITEM_LARGESHIELD||BASE_ITEM_SMALLSHIELD||BASE_ITEM_TOWERSHIELD)
    { nCategorySelf = 2; }
else if (nTypeSelf == BASE_ITEM_AMULET||BASE_ITEM_GEM||BASE_ITEM_RING||BASE_ITEM_BRACER)
    { nCategorySelf = 3; }
else if (nTypeSelf == BASE_ITEM_BLANK_POTION||BASE_ITEM_BLANK_SCROLL||BASE_ITEM_BLANK_WAND||BASE_ITEM_CRAFTMATERIALMED||BASE_ITEM_CRAFTMATERIALSML)
    { nCategorySelf = 4; }
else if (nTypeSelf == BASE_ITEM_ENCHANTED_POTION||BASE_ITEM_POTIONS)
    { nCategorySelf = 5; }
else if (nTypeSelf == BASE_ITEM_ENCHANTED_SCROLL||BASE_ITEM_SPELLSCROLL|BASE_ITEM_SCROLL)
    { nCategorySelf = 6; }
else
    { nCategorySelf = 7; }

if (nTypeSelf == BASE_ITEM_GOLD)
    { nCategorySelf = 0; }
else if (nTypeToMatch == BASE_ITEM_BASTARDSWORD||BASE_ITEM_BATTLEAXE||BASE_ITEM_BOLT||BASE_ITEM_BULLET||BASE_ITEM_CLUB||BASE_ITEM_DAGGER||BASE_ITEM_DART||BASE_ITEM_DIREMACE||BASE_ITEM_DOUBLEAXE||BASE_ITEM_DWARVENWARAXE||BASE_ITEM_GREATAXE||BASE_ITEM_GREATSWORD||BASE_ITEM_HALBERD||BASE_ITEM_HANDAXE||BASE_ITEM_HEAVYCROSSBOW||BASE_ITEM_HEAVYFLAIL||BASE_ITEM_KAMA||BASE_ITEM_KATANA||BASE_ITEM_KUKRI||BASE_ITEM_LIGHTCROSSBOW||BASE_ITEM_LIGHTFLAIL||BASE_ITEM_LIGHTHAMMER||BASE_ITEM_LIGHTMACE||BASE_ITEM_LONGBOW||BASE_ITEM_LONGSWORD||BASE_ITEM_MORNINGSTAR||BASE_ITEM_QUARTERSTAFF||BASE_ITEM_RAPIER||BASE_ITEM_SCIMITAR||BASE_ITEM_SCYTHE||BASE_ITEM_SHORTBOW||BASE_ITEM_SHORTSPEAR||BASE_ITEM_SHORTSWORD||BASE_ITEM_SHURIKEN||BASE_ITEM_SICKLE||BASE_ITEM_SLING||BASE_ITEM_THROWINGAXE||BASE_ITEM_TWOBLADEDSWORD||BASE_ITEM_TRIDENT|| BASE_ITEM_WARHAMMER||BASE_ITEM_WHIP)
    { nCategoryToMatch = 1; }
else if (nTypeToMatch == BASE_ITEM_ARMOR||BASE_ITEM_BELT||BASE_ITEM_CLOAK||BASE_ITEM_HELMET||BASE_ITEM_LARGESHIELD||BASE_ITEM_SMALLSHIELD||BASE_ITEM_TOWERSHIELD)
    { nCategoryToMatch = 2; }
else if (nTypeToMatch == BASE_ITEM_AMULET||BASE_ITEM_GEM||BASE_ITEM_RING||BASE_ITEM_BRACER)
    { nCategoryToMatch = 3; }
else if (nTypeToMatch == BASE_ITEM_BLANK_POTION||BASE_ITEM_BLANK_SCROLL||BASE_ITEM_BLANK_WAND||BASE_ITEM_CRAFTMATERIALMED||BASE_ITEM_CRAFTMATERIALSML)
    { nCategoryToMatch = 4; }
else if (nTypeToMatch == BASE_ITEM_ENCHANTED_POTION||BASE_ITEM_POTIONS)
    { nCategoryToMatch = 5; }
else if (nTypeToMatch == BASE_ITEM_ENCHANTED_SCROLL||BASE_ITEM_SPELLSCROLL|BASE_ITEM_SCROLL)
    { nCategoryToMatch = 6; }
else
    { nCategoryToMatch = 7; }

if (nCategorySelf == nCategoryToMatch) return TRUE;
return FALSE;
}

float ItemCategoryShare(object oItemSelf, object oOwner)
{
//Declarations
object oItemScan = GetFirstItemInInventory(oOwner);
int nTargetShare;
int nOtherShare;
int nInventorySlot;
float fProportion;
//End Declarations
while (oItemScan != OBJECT_INVALID)
    {
    if (MatchItemCategory(oItemSelf,oItemScan) == TRUE)
        {
        nTargetShare += GetGoldPieceValue(oItemScan);
        }
    else nOtherShare += GetGoldPieceValue(oItemScan);
    oItemScan = GetNextItemInInventory(oOwner);
    }
for (nInventorySlot = 0; nInventorySlot < 17; nInventorySlot++)
    {
    oItemScan =  GetItemInSlot(nInventorySlot, oOwner);
    if (MatchItemCategory(oItemSelf,oItemScan) == TRUE)
        {
        nTargetShare += GetGoldPieceValue(oItemScan);
        }
    else nOtherShare += GetGoldPieceValue(oItemScan);
    }
fProportion = IntToFloat(nTargetShare)/(IntToFloat(nTargetShare)+IntToFloat(nOtherShare));
return fProportion;
}


object PickItem(int nPickValue, object oOwner)
//returns an item
{
//Declarations
object oItemScan;
object oCurrentChoice = OBJECT_INVALID;
int nCurrentChoiceGP;
//End Declarations

oItemScan = GetFirstItemInInventory(oOwner);
while (oItemScan != OBJECT_INVALID)
    {
    if ((oCurrentChoice == OBJECT_INVALID)
        && (GetLocalInt(oItemScan,"BARTERVALUE") <= nPickValue)
        && (GetLocalInt(oItemScan,"BARTER") == FALSE))
        {
        oCurrentChoice = oItemScan;
        nCurrentChoiceGP = GetLocalInt(oItemScan,"BARTERVALUE");
        }
    else if ((GetLocalInt(oItemScan,"BARTER") == FALSE) &&
        (oCurrentChoice != OBJECT_INVALID)
        && (GetLocalInt(oItemScan,"BARTERVALUE") <= nPickValue)
//        && (ItemCategoryShare(oItemScan,oOwner) >= ItemCategoryShare(oCurrentChoice,oOwner))
        && (d100() <=  FloatToInt(IntToFloat(GetLocalInt(oItemScan,"BARTERVALUE"))/IntToFloat(GetLocalInt(oCurrentChoice,"BARTERVALUE"))*100.0)))
        {
        oCurrentChoice = oItemScan;
        nCurrentChoiceGP = GetLocalInt(oItemScan,"BARTERVALUE");
        }
    oItemScan = GetNextItemInInventory(oOwner);
    }
return oCurrentChoice;
}

void TagItems(object oBarterBag, object oTarget)
//
{
//Declarations
int nBarterBagValue;
int nInventoryValue;
object oItemScan;
object oBuildItem;
int nBuildValue;
int nLowestValue;
object oLowestValue;
int nBarterValue;
//End Declarations

// First determine overall values of the barter bag and the target's inventory
oItemScan = GetFirstItemInInventory(oBarterBag);
while (oItemScan != OBJECT_INVALID)
    {
    SetLocalInt(oBuildItem,"BARTER",TRUE); //All items in the barter bag start as tagged.
    nBarterValue = FloatToInt(IntToFloat(GetGoldPieceValue(oItemScan)) * (2.0 - ItemCategoryShare(oItemScan,oTarget)));
    SetLocalInt(oItemScan,"BARTERVALUE",nBarterValue);
    nBarterBagValue += GetLocalInt(oItemScan,"BARTERVALUE");
    oItemScan = GetNextItemInInventory(oBarterBag);
    }
oItemScan = GetFirstItemInInventory(oTarget);
while (oItemScan != OBJECT_INVALID)
    {
    DeleteLocalInt(oItemScan,"BARTER"); // All items in the Target's inventory start as untagged.
    nBarterValue = FloatToInt(IntToFloat(GetGoldPieceValue(oItemScan)) * (2.0 - ItemCategoryShare(oItemScan,oTarget)));
    SetLocalInt(oItemScan,"BARTERVALUE",nBarterValue);
    nInventoryValue += GetLocalInt(oItemScan,"BARTERVALUE");
    oItemScan = GetNextItemInInventory(oTarget);
    }


nBuildValue = nBarterBagValue;

while ((nInventoryValue * 100) < nBarterBagValue)
   {
    nLowestValue = nBarterBagValue;
    oItemScan = GetFirstItemInInventory(oBarterBag);
    while (oItemScan != OBJECT_INVALID)
        {
        if ((GetLocalInt(oBuildItem,"BARTERVALUE") < nLowestValue)
            || ((GetLocalInt(oBuildItem,"BARTERVALUE") == nLowestValue) && (d2() <= 1)))
            {
            oLowestValue = oItemScan;
            }
        oItemScan = GetNextItemInInventory(oBarterBag);
        }
    if (oLowestValue != OBJECT_INVALID)
       {
        DeleteLocalInt(oLowestValue,"BARTER");
        nBuildValue -= GetLocalInt(oLowestValue,"BARTERVALUE");
        nBarterBagValue -= GetLocalInt(oLowestValue,"BARTERVALUE");
        }
    }

oBuildItem = PickItem(nBuildValue,oTarget);
while ((oBuildItem != OBJECT_INVALID) && (nBuildValue < 0))
    {
    SetLocalInt(oBuildItem,"BARTER",TRUE);
    nBuildValue -= GetLocalInt(oBuildItem,"BARTERVALUE");
    oBuildItem = PickItem(nBuildValue,oTarget);
    }
}

void SwapItems(object oBarterBag, object oTarget)
{
//SpawnScriptDebugger();
//Declarations
object oItemScan;
object oOwner = GetItemPossessor(oBarterBag);
location lBag = GenerateNewLocationFromLocation(GetLocation(oOwner),DISTANCE_TINY,GetFacing(oOwner),GetFacing(oOwner));
object oOfferBag = CreateObject(OBJECT_TYPE_PLACEABLE,"_offerbag",lBag);
//End Declarations

oItemScan = GetFirstItemInInventory(oBarterBag);
while (oItemScan != OBJECT_INVALID)
    {
    if (GetLocalInt(oItemScan,"BARTER") != TRUE)
        {
        AssignCommand(oOfferBag,ActionTakeItem(oItemScan,oBarterBag));
        SetLocalObject(oItemScan,"BARTERLAST",oBarterBag);
        }
    else
        {
        AssignCommand(oTarget,ActionTakeItem(oItemScan,oBarterBag));
        SetLocalObject(oItemScan,"BARTERLAST",oBarterBag);
        }
    DeleteLocalInt(oItemScan,"BARTER");
    DeleteLocalInt(oItemScan,"BARTERVALUE");
    oItemScan = GetNextItemInInventory(oBarterBag);
    }

oItemScan = GetFirstItemInInventory(oTarget);
while (oItemScan != OBJECT_INVALID)
    {
    if (GetLocalInt(oItemScan,"BARTER") == TRUE)
        {
        AssignCommand(oTarget,ActionGiveItem(oItemScan,oOfferBag));
        SetLocalObject(oItemScan,"BARTERLAST",oTarget);
        }
    DeleteLocalInt(oItemScan,"BARTER");
    DeleteLocalInt(oItemScan,"BARTERVALUE");
    oItemScan = GetNextItemInInventory(oTarget);
    }
}

