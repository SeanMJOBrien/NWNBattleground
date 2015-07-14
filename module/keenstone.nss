void main()
{
object oPC = GetItemActivator();
object oItem =  GetItemActivatedTarget();
int iKind = GetObjectType(oItem);
if (iKind!=OBJECT_TYPE_ITEM)
    {
    FloatingTextStringOnCreature("This is only useable on edged weapons.",oPC);
    return;
    }
string sName = GetName(oItem);
int iType = GetBaseItemType(oItem);

if (iType==BASE_ITEM_BASTARDSWORD||iType==BASE_ITEM_BATTLEAXE||iType==BASE_ITEM_DOUBLEAXE
||iType==BASE_ITEM_DAGGER||iType==BASE_ITEM_DWARVENWARAXE||iType==BASE_ITEM_GREATAXE
||iType==BASE_ITEM_GREATSWORD||iType==BASE_ITEM_HALBERD||iType==BASE_ITEM_HANDAXE
||iType==BASE_ITEM_KAMA||iType==BASE_ITEM_KATANA||iType==BASE_ITEM_KUKRI
||iType==BASE_ITEM_LONGSWORD||iType==BASE_ITEM_RAPIER||iType==BASE_ITEM_SCIMITAR
||iType==BASE_ITEM_SCYTHE||iType==BASE_ITEM_SHORTSWORD||iType==BASE_ITEM_SICKLE
||iType==BASE_ITEM_TWOBLADEDSWORD)
    {
     itemproperty ipKeen =  ItemPropertyKeen();
     AddItemProperty(DURATION_TYPE_PERMANENT,ipKeen,oItem);
     DestroyObject(GetItemActivated());
    }
else
    {
    FloatingTextStringOnCreature("This is only useable on edged weapons.",oPC);
    }
}
