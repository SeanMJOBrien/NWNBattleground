void main()
{
string sSyl1;
string sSyl2;
string sSyl3;
int iSlength = d4();
int iRoll1 = d20();
int iRoll2 = d20();
int iRoll3 = d20();
string sName = GetName(OBJECT_SELF);

switch(iRoll1)
        {
        case 1: sSyl1="Gonk"; break;
        case 2: sSyl1="Grog"; break;
        case 3: sSyl1="Bug"; break;
        case 4: sSyl1="Kig"; break;
        case 5: sSyl1="Bim"; break;
        case 6: sSyl1="Digg"; break;
        case 7: sSyl1="Mog"; break;
        case 8: sSyl1="Bong"; break;
        case 9: sSyl1="Kon"; break;
        case 10: sSyl1="Dimm"; break;
        case 11: sSyl1="Gig"; break;
        case 12: sSyl1="Bog"; break;
        case 13: sSyl1="Nog"; break;
        case 14: sSyl1="Ging"; break;
        case 15: sSyl1="Bam"; break;
        case 16: sSyl1="Pogg"; break;
        case 17: sSyl1="Din"; break;
        case 18: sSyl1="Sag"; break;
        case 19: sSyl1="Slag"; break;
        case 20: sSyl1="Pug"; break;
        }
switch(iRoll2)
        {
        case 1: sSyl2="tor"; break;
        case 2: sSyl2="dag"; break;
        case 3: sSyl2="tar"; break;
        case 4: sSyl2="bin"; break;
        case 5: sSyl2="gag"; break;
        case 6: sSyl2="gop"; break;
        case 7: sSyl2="pog"; break;
        case 8: sSyl2="rak"; break;
        case 9: sSyl2="donk"; break;
        case 10: sSyl2="gor"; break;
        case 11: sSyl2="nat"; break;
        case 12: sSyl2="mar"; break;
        case 13: sSyl2="tan"; break;
        case 14: sSyl2="us"; break;
        case 15: sSyl2="tag"; break;
        case 16: sSyl2="nog"; break;
        case 17: sSyl2="tup"; break;
        case 18: sSyl2="mag"; break;
        case 19: sSyl2="kag"; break;
        case 20: sSyl2="gug"; break;
        }
switch(iRoll3)
        {
        case 1: sSyl3="ak"; break;
        case 2: sSyl3="ik"; break;
        case 3: sSyl3="us"; break;
        case 4: sSyl3="ington"; break;
        case 5: sSyl3="og"; break;
        case 6: sSyl3="it"; break;
        case 7: sSyl3="o"; break;
        case 8: sSyl3="rak"; break;
        case 9: sSyl3="dor"; break;
        case 10: sSyl3="dop"; break;
        case 11: sSyl3="a"; break;
        case 12: sSyl3="ag"; break;
        case 13: sSyl3="tog"; break;
        case 14: sSyl3="ig"; break;
        case 15: sSyl3="nag"; break;
        case 16: sSyl3="ah"; break;
        case 17: sSyl3="rup"; break;
        case 18: sSyl3="it"; break;
        case 19: sSyl3="ok"; break;
        case 20: sSyl3="tok"; break;
        }

if (iSlength==1) SetName(OBJECT_SELF,sSyl1+" the "+sName);
if (iSlength==2) SetName(OBJECT_SELF,sSyl1+sSyl2+" the "+sName);
if (iSlength==3) SetName(OBJECT_SELF,sSyl1+sSyl3+" the "+sName);
if (iSlength==4) SetName(OBJECT_SELF,sSyl1+sSyl2+sSyl3+" the "+sName);
}
