void main()
{
object oPC = GetLastClosedBy();
object oMerchant = GetNearestObjectByTag("MERCH1",OBJECT_SELF);
if (oMerchant == OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("No merchant present. Your items are still in the barter chest.",oPC,FALSE);
    }
else if (IsInConversation(oMerchant))
    {
    FloatingTextStringOnCreature("The merchant is indisposed. Your items are still in the barter chest.",oPC,FALSE);
    }
else
    {
    AssignCommand(oMerchant, ActionStartConversation(oPC,"ps_barterchest",TRUE,FALSE));
    }
}
