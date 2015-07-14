void main()
{
object oPC = GetItemActivator();
int iCP = GetLocalInt(oPC,"cp");
location lHere = GetLocation(oPC);
int iHD = GetHitDice(oPC);
int iWolf;
if (iHD<=7) iWolf=1;
if (iHD<=8&&iHD<=11) iWolf=2;
if (iHD>=12&&iHD<=15) iWolf=3;
if (iHD>=16&&iHD<=19) iWolf=4;
if (iHD>=20) iWolf=5;
string sWolf = IntToString(iWolf);

if (iCP>=2)
{
CreateObject(OBJECT_TYPE_CREATURE,"worg00"+sWolf,lHere);
SetLocalInt(oPC,"cp",iCP-2);
}
else
 {
 FloatingTextStringOnCreature("You need 2 CP to summon a Worg.",oPC);
 }
}
