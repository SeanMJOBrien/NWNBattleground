void main()
{
object oItem = GetItemActivated();
object oTarget = GetItemActivatedTarget();
if (GetObjectType(oTarget)!=OBJECT_TYPE_DOOR)
    {
    return;
    }
object oPC =  GetItemActivator();
string sName = GetName(oItem);

    int iFix;
    if (sName=="<c ��>Adamantine</c>") iFix = 200;
    if (sName=="<c ��>Mithril</c>") iFix = 150;
    if (sName=="<c ��>Steel</c>") iFix = 100;
    if (sName=="<c ��>Iron</c>") iFix = 75;
    if (sName=="<c ��>Wood</c>") iFix = 50;
    if (sName=="<c ��>Copper</c>") iFix = 60;
    if (sName=="<c ��>Ironwood</c>") iFix = 75;

string sFix = IntToString(iFix);
int iHP = GetLocalInt(oTarget,"hp");
SetLocalInt(oTarget,"hp",iHP+iFix);
string sTotal = IntToString(iHP+iFix);
int iCP = GetLocalInt(oPC,"cp");
SetLocalInt(oPC,"cp",iCP+1);
GiveXPToCreature(oPC,25);
FloatingTextStringOnCreature("You add "+sFix+" to the door for a total of "+sTotal+" HP. +1 CP +25 XP.",oPC, FALSE);
DestroyObject(oItem);
}
