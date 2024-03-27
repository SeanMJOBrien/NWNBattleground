void main()
{
object oPC = GetLastClosedBy();
object oScan;
object oFoci;
effect ePoof = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL, FALSE);
int nFociStrength = 0;
if ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC) > 0) || (GetLevelByClass(CLASS_TYPE_SORCERER,oPC) > 0) || (GetLevelByClass(CLASS_TYPE_BARD,oPC) > 0))
    {
    oScan = GetFirstItemInInventory(OBJECT_SELF);
    while (oScan != OBJECT_INVALID)
        {
        if ((GetBaseItemType(oScan) == BASE_ITEM_GEM) || (GetBaseItemType(oScan) == BASE_ITEM_SPELLSCROLL))
            {
            nFociStrength += GetGoldPieceValue(oScan)/2;
            DestroyObject(oScan);
            }
        if ((GetSubString(GetTag(oScan),0,9) == "MATERIAL_") || (GetTag(oScan) == "ARCANE_FOCUS"))
            {
            if (GetLocalInt(oScan,"Points") > 0)
                {
                nFociStrength += GetLocalInt(oScan,"Points");
                DestroyObject(oScan);
                }
            else if (GetItemCharges(oScan) > 0)
                {
                nFociStrength += GetItemCharges(oScan);
                DestroyObject(oScan);
                }
            else if (StringToInt(GetSubString(GetTag(oScan),9,3)) > 0)
                {
                nFociStrength += StringToInt(GetSubString(GetTag(oScan),9,3));
                DestroyObject(oScan);
                }
            else DestroyObject(oScan);
            }
        oScan = GetNextItemInInventory(OBJECT_SELF);
        }
        if (nFociStrength > 0)
            {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoof,GetLocation(GetNearestObjectByTag("POOF_LOCATION",OBJECT_SELF)));
            object oFocus = CreateItemOnObject("ps_foci001",OBJECT_SELF);
            SetLocalInt(oFocus,"Points",nFociStrength);
            }
    }
}
