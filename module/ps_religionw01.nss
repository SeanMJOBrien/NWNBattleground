int StartingConditional()
{
object oTarget = GetLocalObject(GetPCSpeaker(),"ReligionTarget");
if (oTarget != OBJECT_INVALID)
    {
    SetCustomToken(505,"Set "+GetName(oTarget)+"'s deity to?");
    return TRUE;
    }
return FALSE;
}
