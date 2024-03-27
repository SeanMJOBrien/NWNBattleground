#include "ps_mod_data"

void MakeBox(int nSlot)
{
object oPC = GetPCSpeaker();
location lBox1 = GetLocation(GetNearestObjectByTag("BOX1"));
location lBox2 = GetLocation(GetNearestObjectByTag("BOX2"));
location lBox3 = GetLocation(GetNearestObjectByTag("BOX3"));
location lBox4 = GetLocation(GetNearestObjectByTag("BOX4"));
object oBufferB;
switch (nSlot)
    {
    case 1:
    oBufferB = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_storagecrate",lBox1,FALSE,"STORES"+IntToString(nSlot));
    break;
    case 2:
    oBufferB = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_storagecrate",lBox2,FALSE,"STORES"+IntToString(nSlot));
    break;
    case 3:
    oBufferB = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_storagecrate",lBox3,FALSE,"STORES"+IntToString(nSlot));
    break;
    case 4:
    oBufferB = CreateObject(OBJECT_TYPE_PLACEABLE,"ps_storagecrate",lBox4,FALSE,"STORES"+IntToString(nSlot));
    break;
    }

}

void main()
{
object oPC = GetPCSpeaker();
object oWalk1 = GetNearestObjectByTag("WALK1");
object oWalk2 = GetNearestObjectByTag("WALK2");
object oWalk3 = GetNearestObjectByTag("WALK3");
object oWalk4 = GetNearestObjectByTag("WALK4");
object oWalkN = GetNearestObjectByTag("WALKN");
object oWalkC = GetNearestObjectByTag("WALKC");
object oWalkS = GetNearestObjectByTag("WALKS");
int nCount = 0;
object oScan;
object oBufferB;

for (nCount = 1; nCount < 5; nCount ++)
    {
    oScan = GetObjectByTag("STORES"+IntToString(nCount));
    if (oScan == OBJECT_INVALID) break;
    }
if (nCount == 0)
    {
    SpeakString("Wait for one of these other boxes to be cleared out.");
    return;
    }
//ClearAllActions();
//switch (d2())
//    {
//    case 1:
//    ActionMoveToObject(oWalkN,FALSE,0.5);
//    break;
//    case 2:
//    ActionMoveToObject(oWalkS,FALSE,0.5);
//    break;
//    }
//ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0);
switch (nCount)
    {
    case 1:
    ActionMoveToObject(oWalk1,FALSE,0.0);
    ActionDoCommand(SetFacing(GetFacing(oWalk1)));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0);
    ActionDoCommand(MakeBox(1));
    break;
    case 2:
    ActionMoveToObject(oWalk2,FALSE,0.0);
    ActionDoCommand(SetFacing(GetFacing(oWalk2)));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0);
    ActionDoCommand(MakeBox(2));
    break;
    case 3:
    ActionMoveToObject(oWalk3,FALSE,0.0);
    ActionDoCommand(SetFacing(GetFacing(oWalk3)));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0);
    ActionDoCommand(MakeBox(3));
    break;
    case 4:
    ActionMoveToObject(oWalk4,FALSE,0.0);
    ActionDoCommand(SetFacing(GetFacing(oWalk4)));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0);
    ActionDoCommand(MakeBox(4));
    break;
    }
ActionSpeakString("There you are.");
ActionMoveToObject(oWalkC,FALSE,0.0);
ActionDoCommand(SetFacing(GetFacing(oWalkC)));
}
