void main()
{
int nCraftMod = GetLocalInt(GetModule(),"CraftMultiplier");
if (nCraftMod == 0) nCraftMod = 10;
SetCustomToken(301,IntToString(nCraftMod));
SetLocalInt(GetModule(),"CraftMultiplier",nCraftMod);
}
