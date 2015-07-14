void main()
{
int iTurn = GetLocalInt(GetModule(),"turn");
if (d12()==1) ExecuteScript("spawn_hnoid8",OBJECT_SELF);
else if (d20()==1) ExecuteScript("zombie_horde",OBJECT_SELF);
else if (d20()==1&&iTurn>100) ExecuteScript("horde_ogres",OBJECT_SELF);
}
