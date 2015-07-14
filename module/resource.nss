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
    if (sName=="<c þþ>Adamantine</c>") iFix = 200;
    if (sName=="<c þþ>Mithril</c>") iFix = 150;
    if (sName=="<c þþ>Steel</c>") iFix = 100;
    if (sName=="<c þþ>Iron</c>") iFix = 75;
    if (sName=="<c þþ>Wood</c>") iFix = 50;
    if (sName=="<c þþ>Copper</c>") iFix = 60;
    if (sName=="<c þþ>Ironwood</c>") iFix = 75;

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
