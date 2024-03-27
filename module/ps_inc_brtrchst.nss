int CategoryPercentage(object oItem)
{
object oOwner = GetItemPossessor(oItem);
if (oOwner == OBJECT_INVALID) return 0;
int nGoldSum;
int nWeaponSum; int nArmorSum; int nJewelSum; int nRawMatSum;
int nPotionSum; int nScrollSum; int nMiscSum; int nInventoryTotal;
float fProportion;
int nPlaceHolder;
int nRegisterItem;
int nPercentage;
if (GetObjectType(oOwner) == OBJECT_TYPE_STORE) nGoldSum = GetStoreGold(oOwner);
else nGoldSum = GetGold(oOwner);

object oItemScan = GetFirstItemInInventory(oOwner);
while (oItemScan != OBJECT_INVALID)
    {
    switch (GetBaseItemType(oItemScan))
        {
        case BASE_ITEM_BASTARDSWORD: case BASE_ITEM_BATTLEAXE: case BASE_ITEM_BOLT: case BASE_ITEM_BULLET: case BASE_ITEM_CLUB: case BASE_ITEM_DAGGER: case BASE_ITEM_DART: case BASE_ITEM_DIREMACE: case BASE_ITEM_DOUBLEAXE: case BASE_ITEM_DWARVENWARAXE: case BASE_ITEM_GREATAXE: case BASE_ITEM_GREATSWORD: case BASE_ITEM_HALBERD: case BASE_ITEM_HANDAXE: case BASE_ITEM_HEAVYCROSSBOW: case BASE_ITEM_HEAVYFLAIL: case BASE_ITEM_KAMA: case BASE_ITEM_KATANA: case BASE_ITEM_KUKRI: case BASE_ITEM_LIGHTCROSSBOW: case BASE_ITEM_LIGHTFLAIL: case BASE_ITEM_LIGHTHAMMER: case BASE_ITEM_LIGHTMACE: case BASE_ITEM_LONGBOW: case BASE_ITEM_LONGSWORD: case BASE_ITEM_MORNINGSTAR: case BASE_ITEM_QUARTERSTAFF: case BASE_ITEM_RAPIER: case BASE_ITEM_SCIMITAR: case BASE_ITEM_SCYTHE: case BASE_ITEM_SHORTBOW: case BASE_ITEM_SHORTSPEAR: case BASE_ITEM_SHORTSWORD: case BASE_ITEM_SHURIKEN: case BASE_ITEM_SICKLE: case BASE_ITEM_SLING: case BASE_ITEM_THROWINGAXE: case BASE_ITEM_TWOBLADEDSWORD: case BASE_ITEM_TRIDENT: case BASE_ITEM_WARHAMMER: case BASE_ITEM_WHIP:
nWeaponSum += GetGoldPieceValue(oItemScan);
            break;
        case BASE_ITEM_ARMOR: case BASE_ITEM_BELT: case BASE_ITEM_CLOAK: case BASE_ITEM_HELMET: case BASE_ITEM_LARGESHIELD: case BASE_ITEM_SMALLSHIELD: case BASE_ITEM_TOWERSHIELD:
            nArmorSum += GetGoldPieceValue(oItemScan);
            break;
        case BASE_ITEM_AMULET: case BASE_ITEM_GEM: case BASE_ITEM_RING: case BASE_ITEM_BRACER:
            nJewelSum += GetGoldPieceValue(oItemScan);
            break;
        case BASE_ITEM_BLANK_POTION: case BASE_ITEM_BLANK_SCROLL: case BASE_ITEM_BLANK_WAND: case BASE_ITEM_CRAFTMATERIALMED: case BASE_ITEM_CRAFTMATERIALSML:
            nRawMatSum += GetGoldPieceValue(oItemScan);
            break;
        case BASE_ITEM_ENCHANTED_POTION: case BASE_ITEM_POTIONS:
            nPotionSum += GetGoldPieceValue(oItemScan);
            break;
        case BASE_ITEM_ENCHANTED_SCROLL: case BASE_ITEM_SPELLSCROLL: case BASE_ITEM_SCROLL:
            nScrollSum += GetGoldPieceValue(oItemScan);
            break;
        default:
            nMiscSum += GetGoldPieceValue(oItemScan);
            break;
        }
    oItemScan = GetNextItemInInventory(oOwner);
    }
nInventoryTotal = nGoldSum+nWeaponSum+nArmorSum+nJewelSum+nRawMatSum+nPotionSum+nScrollSum+nMiscSum;
switch (GetBaseItemType(oItemScan))
    {
        case BASE_ITEM_BASTARDSWORD: case BASE_ITEM_BATTLEAXE: case BASE_ITEM_BOLT: case BASE_ITEM_BULLET: case BASE_ITEM_CLUB: case BASE_ITEM_DAGGER: case BASE_ITEM_DART: case BASE_ITEM_DIREMACE: case BASE_ITEM_DOUBLEAXE: case BASE_ITEM_DWARVENWARAXE: case BASE_ITEM_GREATAXE: case BASE_ITEM_GREATSWORD: case BASE_ITEM_HALBERD: case BASE_ITEM_HANDAXE: case BASE_ITEM_HEAVYCROSSBOW: case BASE_ITEM_HEAVYFLAIL: case BASE_ITEM_KAMA: case BASE_ITEM_KATANA: case BASE_ITEM_KUKRI: case BASE_ITEM_LIGHTCROSSBOW: case BASE_ITEM_LIGHTFLAIL: case BASE_ITEM_LIGHTHAMMER: case BASE_ITEM_LIGHTMACE: case BASE_ITEM_LONGBOW: case BASE_ITEM_LONGSWORD: case BASE_ITEM_MORNINGSTAR: case BASE_ITEM_QUARTERSTAFF: case BASE_ITEM_RAPIER: case BASE_ITEM_SCIMITAR: case BASE_ITEM_SCYTHE: case BASE_ITEM_SHORTBOW: case BASE_ITEM_SHORTSPEAR: case BASE_ITEM_SHORTSWORD: case BASE_ITEM_SHURIKEN: case BASE_ITEM_SICKLE: case BASE_ITEM_SLING: case BASE_ITEM_THROWINGAXE: case BASE_ITEM_TWOBLADEDSWORD: case BASE_ITEM_TRIDENT: case BASE_ITEM_WARHAMMER: case BASE_ITEM_WHIP:
       nPlaceHolder = nWeaponSum;
       break;
        case BASE_ITEM_ARMOR: case BASE_ITEM_BELT: case BASE_ITEM_CLOAK: case BASE_ITEM_HELMET: case BASE_ITEM_LARGESHIELD: case BASE_ITEM_SMALLSHIELD: case BASE_ITEM_TOWERSHIELD:
       nPlaceHolder = nArmorSum;
       break;
        case BASE_ITEM_AMULET: case BASE_ITEM_GEM: case BASE_ITEM_RING: case BASE_ITEM_BRACER:
       nPlaceHolder = nJewelSum;
       break;
        case BASE_ITEM_BLANK_POTION: case BASE_ITEM_BLANK_SCROLL: case BASE_ITEM_BLANK_WAND: case BASE_ITEM_CRAFTMATERIALMED: case BASE_ITEM_CRAFTMATERIALSML:
       nPlaceHolder = nRawMatSum;
       break;
        case BASE_ITEM_ENCHANTED_POTION: case BASE_ITEM_POTIONS:
       nPlaceHolder = nPotionSum;
       break;
        case BASE_ITEM_ENCHANTED_SCROLL: case BASE_ITEM_SPELLSCROLL: case BASE_ITEM_SCROLL:
       nPlaceHolder = nScrollSum;
       break;
    default:
       nPlaceHolder = nMiscSum;
       break;
    }
nPercentage = FloatToInt((IntToFloat(nPlaceHolder)/IntToFloat(nInventoryTotal))*100.0);
return nPercentage;
}

object PickItem(int nMaxValue, int nItemCategory, object oFromInventory, object oToChest = OBJECT_INVALID)
{
// Item Categories
// 0 = Gold, 1 = Weapons, 2 =Armor, 3 = Jewelery, 4 = Raw Materials
// 5 = Potions, 6 = Scrolls, 7 = Miscellaneous, 8 = ALL
object oPickItem;
int nPercentage = -1;
int nRegisterItem = FALSE;
int nPickValue;
int nScanValue;
object oItemScan = GetFirstItemInInventory(oFromInventory);
while (oItemScan != OBJECT_INVALID)
    {
    if (nItemCategory == 8)
        {
        nPercentage = CategoryPercentage(oItemScan);
        nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
        if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
        }//    if (nItemCategory == 8)
    else
        {
        switch (GetBaseItemType(oItemScan))
        {
        case BASE_ITEM_BASTARDSWORD: case BASE_ITEM_BATTLEAXE: case BASE_ITEM_BOLT: case BASE_ITEM_BULLET: case BASE_ITEM_CLUB: case BASE_ITEM_DAGGER: case BASE_ITEM_DART: case BASE_ITEM_DIREMACE: case BASE_ITEM_DOUBLEAXE: case BASE_ITEM_DWARVENWARAXE: case BASE_ITEM_GREATAXE: case BASE_ITEM_GREATSWORD: case BASE_ITEM_HALBERD: case BASE_ITEM_HANDAXE: case BASE_ITEM_HEAVYCROSSBOW: case BASE_ITEM_HEAVYFLAIL: case BASE_ITEM_KAMA: case BASE_ITEM_KATANA: case BASE_ITEM_KUKRI: case BASE_ITEM_LIGHTCROSSBOW: case BASE_ITEM_LIGHTFLAIL: case BASE_ITEM_LIGHTHAMMER: case BASE_ITEM_LIGHTMACE: case BASE_ITEM_LONGBOW: case BASE_ITEM_LONGSWORD: case BASE_ITEM_MORNINGSTAR: case BASE_ITEM_QUARTERSTAFF: case BASE_ITEM_RAPIER: case BASE_ITEM_SCIMITAR: case BASE_ITEM_SCYTHE: case BASE_ITEM_SHORTBOW: case BASE_ITEM_SHORTSPEAR: case BASE_ITEM_SHORTSWORD: case BASE_ITEM_SHURIKEN: case BASE_ITEM_SICKLE: case BASE_ITEM_SLING: case BASE_ITEM_THROWINGAXE: case BASE_ITEM_TWOBLADEDSWORD: case BASE_ITEM_TRIDENT: case BASE_ITEM_WARHAMMER: case BASE_ITEM_WHIP:
           if (nItemCategory == 1)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        case BASE_ITEM_ARMOR: case BASE_ITEM_BELT: case BASE_ITEM_CLOAK: case BASE_ITEM_HELMET: case BASE_ITEM_LARGESHIELD: case BASE_ITEM_SMALLSHIELD: case BASE_ITEM_TOWERSHIELD:
           if (nItemCategory == 2)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        case BASE_ITEM_AMULET: case BASE_ITEM_GEM: case BASE_ITEM_RING: case BASE_ITEM_BRACER:
           if (nItemCategory == 3)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        case BASE_ITEM_BLANK_POTION: case BASE_ITEM_BLANK_SCROLL: case BASE_ITEM_BLANK_WAND: case BASE_ITEM_CRAFTMATERIALMED: case BASE_ITEM_CRAFTMATERIALSML:
           if (nItemCategory == 4)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        case BASE_ITEM_ENCHANTED_POTION: case BASE_ITEM_POTIONS:
           if (nItemCategory == 5)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        case BASE_ITEM_ENCHANTED_SCROLL: case BASE_ITEM_SPELLSCROLL: case BASE_ITEM_SCROLL:
           if (nItemCategory == 6)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
        default:
           if (nItemCategory == 7)
                {
                if (nPercentage == -1) nPercentage = CategoryPercentage(oItemScan);
                nScanValue = FloatToInt((IntToFloat(300 - (nPercentage * 2))*0.01)*IntToFloat(GetGoldPieceValue(oItemScan)));
                if ((nScanValue > nPickValue) && (nScanValue <= nMaxValue)) nRegisterItem = TRUE;
                }
           break;
    }// switch
    }//    else
    if (nRegisterItem == TRUE)
    {
    DeleteLocalInt(oPickItem,"BarterWorth");
    nPickValue = nScanValue;
    oPickItem = oItemScan;
    SetLocalInt(oItemScan,"BarterWorth",nPickValue);
    nRegisterItem = FALSE;
    }
    oItemScan = GetNextItemInInventory(oFromInventory);
    }//while (oItemScan != OBJECT_INVALID)
return oPickItem;
}//object PickItem

// Item Categories
// 0 = Gold, 1 = Weapons, 2 =Armor, 3 = Jewelery, 4 = Raw Materials
// 5 = Potions, 6 = Scrolls, 7 = Miscellaneous, 8 = ALL
int SwapItems(object oTargetChest, object oSourceChest, object oMerchant, int nItemCategory, int nShareSize = -1, object oGiveTo = OBJECT_INVALID)
// int returns GP remainder of order unfilled.
{
// declarations
int nSourceChestValue;
object oItemScan;
int nItemScanValue;
int nBuildValue;
// end declarations

//determine value of items in target chest
oItemScan = GetFirstItemInInventory(oTargetChest);
while (oItemScan != OBJECT_INVALID)
    {
    nItemScanValue = GetGoldPieceValue(oItemScan);
    if (GetItemHasItemProperty(oItemScan,ITEM_PROPERTY_LIGHT)) nItemScanValue = 5;
    nSourceChestValue += FloatToInt((1.0 - (IntToFloat(CategoryPercentage(oItemScan))*0.01)) * IntToFloat(nItemScanValue));
    oItemScan = GetNextItemInInventory(oTargetChest);
    }
// Give items in target chest to merchant
oItemScan = GetFirstItemInInventory(oTargetChest);
while (oItemScan != OBJECT_INVALID)
    {
    AssignCommand(oTargetChest, ActionGiveItem(oItemScan,oMerchant));
    oItemScan = GetNextItemInInventory(oTargetChest);
    }
// Build Offer
while (nBuildValue < nSourceChestValue)
    {
    oItemScan = PickItem((nSourceChestValue - nBuildValue), nItemCategory, oSourceChest, oTargetChest);
    if (oItemScan != OBJECT_INVALID)
        {
        nBuildValue += GetLocalInt(oItemScan,"BarterWorth");
        DeleteLocalInt(oItemScan,"BarterWorth");
        AssignCommand(oSourceChest, ActionGiveItem(oItemScan,oTargetChest));
        }
    else // Pick Item couldn't find anything suitable from desired category
        {
        oItemScan = PickItem(nBuildValue, 8, oSourceChest, oTargetChest);
        if (oItemScan != OBJECT_INVALID)
            {
            nBuildValue += GetLocalInt(oItemScan,"BarterWorth");
            DeleteLocalInt(oItemScan,"BarterWorth");
            AssignCommand(oTargetChest, ActionTakeItem(oItemScan,oSourceChest));
            }
        else break; // Nothing left in merchant's inventory
        }
    oItemScan = OBJECT_INVALID;
    }
return (nSourceChestValue - nBuildValue);
}
