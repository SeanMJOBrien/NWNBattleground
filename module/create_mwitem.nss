//search for weapon focus feats and create an appropriate mw weapon
void main()
{
object oItem;
if (GetHasFeat(43,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("club",OBJECT_SELF);
if (GetHasFeat(90,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("dagger",OBJECT_SELF);
if (GetHasFeat(91,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("basedart",OBJECT_SELF,99);
if (GetHasFeat(92,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("hxbow",OBJECT_SELF);
if (GetHasFeat(93,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("lxbow",OBJECT_SELF);
if (GetHasFeat(94,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("mace",OBJECT_SELF);
if (GetHasFeat(95,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("mstar",OBJECT_SELF);
if (GetHasFeat(96,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("qstaff",OBJECT_SELF);
if (GetHasFeat(97,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("spear",OBJECT_SELF);
if (GetHasFeat(98,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("sickle",OBJECT_SELF);
if (GetHasFeat(99,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("sling",OBJECT_SELF);
if (GetHasFeat(101,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("longbow",OBJECT_SELF);
if (GetHasFeat(102,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("shortbow",OBJECT_SELF);
if (GetHasFeat(103,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("ssword",OBJECT_SELF);
if (GetHasFeat(104,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("rapier",OBJECT_SELF);
if (GetHasFeat(105,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("scimitar",OBJECT_SELF);
if (GetHasFeat(106,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("lsword",OBJECT_SELF);
if (GetHasFeat(107,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("gsword",OBJECT_SELF);
if (GetHasFeat(108,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("handaxe",OBJECT_SELF);
if (GetHasFeat(109,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("thaxe",OBJECT_SELF,50);
if (GetHasFeat(110,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("battleaxe",OBJECT_SELF);
if (GetHasFeat(111,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("greataxe",OBJECT_SELF);
if (GetHasFeat(112,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("halberd",OBJECT_SELF);
if (GetHasFeat(113,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("lhammer",OBJECT_SELF);
if (GetHasFeat(114,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("lflail",OBJECT_SELF);
if (GetHasFeat(115,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("warhammer",OBJECT_SELF);
if (GetHasFeat(116,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("hflail",OBJECT_SELF);
if (GetHasFeat(117,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("kama",OBJECT_SELF);
if (GetHasFeat(118,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("kukri",OBJECT_SELF);
if (GetHasFeat(120,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("tstar",OBJECT_SELF,99);
if (GetHasFeat(121,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("scythe",OBJECT_SELF);
if (GetHasFeat(122,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("katana",OBJECT_SELF);
if (GetHasFeat(123,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("bsword",OBJECT_SELF);
if (GetHasFeat(125,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("diremace",OBJECT_SELF);
if (GetHasFeat(126,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("2axe",OBJECT_SELF);
if (GetHasFeat(127,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("2sword",OBJECT_SELF);
if (GetHasFeat(952,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("dwaraxe",OBJECT_SELF);
if (GetHasFeat(993,OBJECT_SELF)==TRUE) oItem = CreateItemOnObject("whip",OBJECT_SELF);
if (GetHasFeat(92,OBJECT_SELF)==TRUE) CreateItemOnObject("bolt1",OBJECT_SELF,99);
if (GetHasFeat(93,OBJECT_SELF)==TRUE) CreateItemOnObject("bolt1",OBJECT_SELF,99);
if (GetHasFeat(101,OBJECT_SELF)==TRUE) CreateItemOnObject("wamar002",OBJECT_SELF,99);
if (GetHasFeat(102,OBJECT_SELF)==TRUE) CreateItemOnObject("wamar002",OBJECT_SELF,99);
if (GetHasFeat(99,OBJECT_SELF)==TRUE) CreateItemOnObject("bullets",OBJECT_SELF,99);
if (GetIsObjectValid(oItem)==FALSE) return;
string sName = GetName(oItem);
SetName(oItem,"Masterwork "+sName);
itemproperty ipBonus = ItemPropertyAttackBonus(1);
itemproperty ipQuality = ItemPropertyQuality(IP_CONST_QUALITY_MASTERWORK);
AddItemProperty(DURATION_TYPE_PERMANENT,ipBonus,oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ipQuality,oItem);
DelayCommand(0.2f,ExecuteScript("name_color",oItem));
}

