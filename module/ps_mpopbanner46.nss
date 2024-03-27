void main()
{
if (GetLocalInt(GetModule(),"MPOP_disable") == 1) DeleteLocalInt(GetModule(),"MPOP_disable");
else SetLocalInt(GetModule(),"MPOP_disable",1);
}
