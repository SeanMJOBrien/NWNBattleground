void main()
{
object oPC = GetPCSpeaker();
int iStore = GetLocalInt(OBJECT_SELF,"shopnum");
string sStore = "merch"+IntToString(iStore);
object oStore = GetNearestObjectByTag(sStore);
OpenStore(oStore,oPC);
}
