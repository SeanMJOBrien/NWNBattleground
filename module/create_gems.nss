void main()
{

int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iRoll = d20()+iHD;
int iMult = d6();
int iNum = 1;
if (iMult==6) iNum = d6();
string sResref1 = "gem";
string sResref2;
string sResref3;
string sResref4;
 switch (Random(12)+1)
    {
    case 1: sResref2="1";break;
    case 2: sResref2="1";break;
    case 3: sResref2="2";break;
    case 4: sResref2="3";break;
    case 5: sResref2="4";break;
    case 6: sResref2="5";break;
    case 7: sResref2="6";break;
    case 8: sResref2="7";break;
    case 9: sResref2="8";break;
    case 10: sResref2="9";break;
    case 11: sResref2="10";break;
    case 12: sResref2="11";break;
    }
switch (Random(8)+1)
    {
    case 1: sResref3="8";break;
    case 2: sResref3="9";break;
    case 3: sResref3="10";break;
    case 4: sResref3="11";break;
    case 5: sResref3="12";break;
    case 6: sResref3="13";break;
    case 7: sResref3="14";break;
    case 8: sResref3="15";break;
    }
switch (Random(9)+1)
    {
    case 1: sResref4="15";break;
    case 2: sResref4="16";break;
    case 3: sResref4="17";break;
    case 4: sResref4="18";break;
    case 5: sResref4="19";break;
    case 6: sResref4="20";break;
    case 7: sResref4="21";break;
    case 8: sResref4="22";break;
    case 9: sResref4="23";break;
    }
CreateItemOnObject(sResref1+sResref2,OBJECT_SELF,iNum);
if (iRoll>=19)CreateItemOnObject(sResref1+sResref3,OBJECT_SELF,1);
if (iRoll>=29)CreateItemOnObject(sResref1+sResref4,OBJECT_SELF,1);
}
