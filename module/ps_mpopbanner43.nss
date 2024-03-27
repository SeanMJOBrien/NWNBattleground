#include "ps_timestamp"

void main()
{
object oPC = GetPCSpeaker();
DeleteLocalInt(oPC,"SeedStr");
DeleteLocalInt(oPC,"PopPointer");
DestroyObject(OBJECT_SELF);

string sPrint = SayLogTime()+" <mpop_wand> ";
int nCountWP = 0;
object oWP = GetObjectByTag("MPOP",nCountWP);
string sPopGrow;
int nCountPop;
string sPop;

while (oWP != OBJECT_INVALID)
    {
    sPrint = sPrint + "["+GetName(oWP)+"] ";
    sPopGrow = GetLocalString(oWP,"GROWTH");
    if (sPopGrow != "") sPrint = sPrint + "(" + sPopGrow + ") ";
    nCountPop = 1;
    sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
    while (sPop != "")
        {
        sPrint = sPrint + sPop + " ";
        nCountPop ++;
        sPop = GetLocalString(oWP,"Pop"+IntToString(nCountPop));
        }
    nCountWP ++;
    oWP = GetObjectByTag("MPOP",nCountWP);
    }
PrintString(sPrint);

}
