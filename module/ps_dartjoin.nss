// This script is implememnted in the dartboard's conversation tree.
// On the option to join the next game's player queue.

void main()
{
int iCounter;
object oCounter;
object oPC = GetPCSpeaker();
for (iCounter = 1; iCounter < 9; iCounter ++)
    {
    oCounter = GetLocalObject(GetArea(oPC),"oPlayer"+IntToString(iCounter));
    if (oCounter == oPC)
        {
        SpeakString("You have already joined the player queue.");
        return;
        }
    }
for (iCounter = 1; iCounter < 9; iCounter ++)
    {
    oCounter = GetLocalObject(GetArea(oPC),"oPlayer"+IntToString(iCounter));
    if ((iCounter == 8) & (oCounter != OBJECT_INVALID))
        {
        SpeakString("The player queue is currently full.");
        return;
        }
    if (oCounter == OBJECT_INVALID)
        {
        SetLocalObject(GetArea(oPC),"oPlayer"+IntToString(iCounter),oPC);
        SpeakString(GetName(oPC)+" is now player "+IntToString(iCounter)+".");
        CreateItemOnObject("ps_gamedarts",oPC,60);
        return;
        }
    }

}
