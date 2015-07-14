#include "x2_inc_switches"
void main()
{
object oPC = OBJECT_SELF;
if (GetIsPC(oPC)==FALSE) return;
int iClass1 = GetClassByPosition(1,OBJECT_SELF);
int iDivisor = 5;
switch (iClass1)
    {
    case CLASS_TYPE_BARD: iDivisor=2; break;
    case CLASS_TYPE_CLERIC: iDivisor=3; break;
    case CLASS_TYPE_DRUID: iDivisor=3; break;
    case CLASS_TYPE_SORCERER: iDivisor=1; break;
    case CLASS_TYPE_WIZARD: iDivisor=1; break;
    case CLASS_TYPE_RANGER: iDivisor=4; break;
    }
int iDC = GetSpellSaveDC();
int iCL = GetCasterLevel(oPC);
int iXP = ((iDC/3)+iCL+d8())/iDivisor;
if (iXP<=0) iXP=1;
GiveXPToCreature(oPC,iXP);
//AssignCommand(oPC,SpeakString("Ooooh, I'm cool. I casted a spell.",TALKVOLUME_TALK));
//AssignCommand(GetModule(),SpeakString("Ooooh, I'm cool. I casted a spell.",TALKVOLUME_SHOUT));
}
