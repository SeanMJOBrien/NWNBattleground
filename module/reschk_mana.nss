void main()
{
object oPC =GetPCSpeaker();
object oMod = GetModule();
int iMana1 = GetLocalInt(oMod,"1mana");
int iMana2 = GetLocalInt(oMod,"2mana");
string sMana1 = IntToString(iMana1);
string sMana2 = IntToString(iMana2);
DelayCommand(1.0f,FloatingTextStringOnCreature("<cþ þ>Good mana level is "+sMana1+". Evil mana level is "+sMana2+".</c>",oPC,FALSE));
}
