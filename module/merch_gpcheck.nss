void main()
{
object oMerch = GetNearestObjectByTag("merchant",OBJECT_SELF);
int iGP = GetStoreGold(oMerch);
string sGP = IntToString(iGP);
SpeakString("I have "+sGP+" with which to purchase items.");
}
