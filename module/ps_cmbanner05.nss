void main()
{
int nCraftMod = GetLocalInt(GetModule(),"CraftMultiplier");
if (nCraftMod == 0) nCraftMod = 10;
nCraftMod = nCraftMod - 5;
SetLocalInt(GetModule(),"CraftMultiplier",nCraftMod);

}
