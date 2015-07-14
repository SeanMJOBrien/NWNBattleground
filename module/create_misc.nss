void main()
{
int iRoll = Random(34);
string sRes;
int iStack = 1;
switch (iRoll)
    {
    case 0: sRes="nw_it_trap00"+IntToString(Random(9)+1);break;
    case 1: sRes="nw_it_torch001";break;
    case 2: sRes="x1_wmgrenade00"+IntToString(Random(7)+1);iStack=d6();break;
    case 3: sRes="nw_it_medkit00"+IntToString(d4(1)+1);iStack=d6();break;
    case 4: sRes="nw_it_trap00"+IntToString(Random(9)+1);break;
    case 5: sRes="nw_it_trap0"+IntToString(Random(34)+10);break;
    case 6: sRes="manacrystal";break;
    case 7: sRes="adam";break;
    case 8: sRes="chickeneggs";break;
    case 9: sRes="copper";break;
    case 10: sRes="equip";break;
    case 11: sRes="food";break;
    case 12: sRes="hide";break;
    case 13: sRes="iron";break;
    case 14: sRes="iwood";break;
    case 15: sRes="meat";break;
    case 16: sRes="milk";break;
    case 17: sRes="mith";break;
    case 18: sRes="steel";break;
    case 19: sRes="stone";break;
    case 20: sRes="wood";break;
    case 21: sRes="fish";break;
    case 22: sRes="cheese";break;
    case 23: sRes="snozberries";break;
    case 24: sRes="lembas";break;
    case 25: sRes="nw_it_trap00"+IntToString(Random(9)+1);break;
    case 26: sRes="nw_it_trap0"+IntToString(Random(34)+10);break;
    case 27: sRes="manacrystal";break;
    case 28: sRes="get_mount";break;
    case 29: sRes="get_mount";break;
    case 30: sRes="amring";break;
    case 31: sRes="spellstripper";break;
    case 32: sRes="rodreversal";break;
    case 33: sRes="roddispel";break;
    }
if (d100()==1) sRes="nw_it_contain006";
CreateItemOnObject(sRes,OBJECT_SELF,iStack);
}
