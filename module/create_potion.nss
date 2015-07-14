void main()
{

int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iRoll = d20()+iHD;
int iMult = d6();
int iNum = 1;
if (iMult==6) iNum = d6();
string sResref1 = "potion";
string sResref2;
string sResref3;
string sResref4;
 switch (Random(39)+1)
    {
    case 1: sResref2="18";break;
    case 2: sResref2="1";break;
    case 3: sResref2="5";break;
    case 4: sResref2="40";break;
    case 5: sResref2="35";break;
    case 6: sResref2="15";break;
    case 7: sResref2="27";break;
    case 8: sResref2="3";break;
    case 9: sResref2="4";break;
    case 10: sResref2="6";break;
    case 11: sResref2="38";break;
    case 12: sResref2="2";break;
    case 13: sResref2="30";break;
    case 14: sResref2="16";break;
    case 15: sResref2="62";break;
    case 16: sResref2="40";break;
    case 17: sResref2="58";break;
    case 18: sResref2="57";break;
    case 19: sResref2="37";break;
    case 20: sResref2="50";break;
    case 21: sResref2="9";break;
    case 22: sResref2="8";break;
    case 23: sResref2="10";break;
    case 24: sResref2="11";break;
    case 25: sResref2="12";break;
    case 26: sResref2="17";break;
    case 27: sResref2="19";break;
    case 28: sResref2="20";break;
    case 29: sResref2="22";break;
    case 30: sResref2="23";break;
    case 31: sResref2="24";break;
    case 32: sResref2="25";break;
    case 33: sResref2="28";break;
    case 34: sResref2="29";break;
    case 35: sResref2="32";break;
    case 36: sResref2="41";break;
    case 37: sResref2="43";break;
    case 38: sResref2="52";break;
    case 39: sResref2="60";break;
    }
switch (Random(19)+1)
    {
    case 1: sResref3="7";break;
    case 2: sResref3="13";break;
    case 3: sResref3="14";break;
    case 4: sResref3="26";break;
    case 5: sResref3="31";break;
    case 6: sResref3="33";break;
    case 7: sResref3="34";break;
    case 8: sResref3="36";break;
    case 9: sResref3="42";break;
    case 10: sResref3="48";break;
    case 11: sResref3="49";break;
    case 12: sResref3="51";break;
    case 13: sResref3="53";break;
    case 14: sResref3="54";break;
    case 15: sResref3="55";break;
    case 16: sResref3="56";break;
    case 17: sResref3="59";break;
    case 18: sResref3="64";break;
    case 19: sResref3="65";break;
    }
switch (Random(8)+1)
    {
    case 1: sResref4="21";break;
    case 2: sResref4="39";break;
    case 3: sResref4="44";break;
    case 4: sResref4="45";break;
    case 5: sResref4="46";break;
    case 6: sResref4="47";break;
    case 7: sResref4="61";break;
    case 8: sResref4="63";break;
    }
CreateItemOnObject(sResref1+sResref2,OBJECT_SELF,iNum);
if (iRoll>=19)CreateItemOnObject(sResref1+sResref3,OBJECT_SELF,1);
if (iRoll>=29)CreateItemOnObject(sResref1+sResref4,OBJECT_SELF,1);
}
