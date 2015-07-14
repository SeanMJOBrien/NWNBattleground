void main()
{
object oItem = GetFirstItemInInventory(OBJECT_SELF);
object oPC = GetLastDisturbed();
if (oItem==OBJECT_INVALID) return;
int iValue =GetGoldPieceValue(oItem);
int iGP = iValue/2500;
if (iValue>=1500) iGP=1;
if (iGP>=3) iGP=1+d6();
if (iGP>=21) iGP+=d4();
if (iGP>=51) iGP+=d4();
if (iGP>=101) iGP+=d4();
if (iGP>=501) iGP+=d6(2);
effect eSmoke = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
if (iGP<=0)
    {
    FloatingTextStringOnCreature("<cþ  >That item yields no Mana.</c>",oPC,0);
    DestroyObject(oItem);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
    return;
    }
DestroyObject(oItem);
int iMana = GetLocalInt(oPC,"mana");
SetLocalInt(oPC,"mana",iMana+iGP);
FloatingTextStringOnCreature("<cþ þ>The item yields "+IntToString(iGP)+" Mana.</c>",oPC,0);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,OBJECT_SELF);
}
