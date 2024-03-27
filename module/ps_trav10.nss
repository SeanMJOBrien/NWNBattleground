void main()
{
object oPC = GetPCSpeaker();
string sTravel = GetLocalString(oPC,"TRAVEL");
SetLocalString(oPC,"ActionText","You turn around.");
int nTravelGoal = GetLocalInt(oPC,"TravelGoal");
int nProgress = StringToInt(GetSubString(sTravel,5,4));
float fProportion;
if (nTravelGoal <= 0) fProportion = 1.0;
else fProportion = 1.0 - (IntToFloat(nProgress) /IntToFloat(nTravelGoal));
string sRoute = GetSubString(sTravel,0,4);
sTravel = GetSubString(sRoute,2,2)+ GetSubString(sRoute,0,2) + "_";

vector vCM = Vector(0.0,1000.0);
vector vSB = Vector(3.0,997.0);
vector vBH = Vector(3.0,1003.0);
vector vWR = Vector(3.0,991.0);
vector vAW = Vector(3.0,1000.0);
vector vBT = Vector(9.0,1009.0);
vector vFF = Vector(6.0,997.0);
vector vTH = Vector(9.0,1000.0);
vector vCO = Vector(9.0,997.0);
vector vSC = Vector(9.0,991.0);
vector vLH = Vector(18.0,997.0);
vector vHR = Vector(18.0,1000.0);
vector vLD = Vector(18.0,1009.0);
vector vCN = Vector(27.0,997.0);
vector vTF = Vector(6.0,994.0);
vector vAP = Vector(6.0,991.0);

vector vBuffer;
float fAngle;
float fDistance;
float fDeviate;
int nGoal;
string sOrigin;
string sDest;
int nRoll;

if (GetSubString(sTravel,0,2) == "CW") SetLocalString(oPC,"TravelFrom","Critwall");
else if (GetSubString(sTravel,0,2) == "AW") SetLocalString(oPC,"TravelFrom","Annwyn Wood");
else if (GetSubString(sTravel,0,2) == "BH") SetLocalString(oPC,"TravelFrom","Beggarstaff Hill");
else if (GetSubString(sTravel,0,2) == "BT") SetLocalString(oPC,"TravelFrom","Briarton");
else if (GetSubString(sTravel,0,2) == "FD") SetLocalString(oPC,"TravelFrom","Foxglove Downs");
else if (GetSubString(sTravel,0,2) == "SB") SetLocalString(oPC,"TravelFrom","Southbrook");
else if (GetSubString(sTravel,0,2) == "WR") SetLocalString(oPC,"TravelFrom","Whistling Ravine");
else if (GetSubString(sTravel,0,2) == "CM") SetLocalString(oPC,"TravelFrom","Caer Mabon");
else if (GetSubString(sTravel,0,2) == "AW") SetLocalString(oPC,"TravelFrom","Annwyn Wood");
else if (GetSubString(sTravel,0,2) == "BT") SetLocalString(oPC,"TravelFrom","Briarton");
else if (GetSubString(sTravel,0,2) == "FF") SetLocalString(oPC,"TravelFrom","Foxglove Ferry");
else if (GetSubString(sTravel,0,2) == "TH") SetLocalString(oPC,"TravelFrom","Thunin Heath");
else if (GetSubString(sTravel,0,2) == "SC") SetLocalString(oPC,"TravelFrom","Scutifer Bridge");
else if (GetSubString(sTravel,0,2) == "CO") SetLocalString(oPC,"TravelFrom","Caer Ouneri");
else if (GetSubString(sTravel,0,2) == "LH") SetLocalString(oPC,"TravelFrom","Lake Hod");
else if (GetSubString(sTravel,0,2) == "HR") SetLocalString(oPC,"TravelFrom","Hangman's Rock");
else if (GetSubString(sTravel,0,2) == "LD") SetLocalString(oPC,"TravelFrom","Llewdor Dale");
else if (GetSubString(sTravel,0,2) == "CN") SetLocalString(oPC,"TravelFrom","the Carrion Wastes");
else if (GetSubString(sTravel,0,2) == "TF") SetLocalString(oPC,"TravelFrom","Trullhome Fenn");
else if (GetSubString(sTravel,0,2) == "AP") SetLocalString(oPC,"TravelFrom","Axeport");

if (GetSubString(sTravel,2,2) == "CW") SetLocalString(oPC,"TravelTo","Critwall");
else if (GetSubString(sTravel,2,2) == "AW") SetLocalString(oPC,"TravelTo","Annwyn Wood");
else if (GetSubString(sTravel,2,2) == "BH") SetLocalString(oPC,"TravelTo","Beggarstaff Hill");
else if (GetSubString(sTravel,2,2) == "BT") SetLocalString(oPC,"TravelTo","Briarton");
else if (GetSubString(sTravel,2,2) == "FD") SetLocalString(oPC,"TravelTo","Foxglove Downs");
else if (GetSubString(sTravel,2,2) == "SB") SetLocalString(oPC,"TravelTo","Southbrook");
else if (GetSubString(sTravel,2,2) == "WR") SetLocalString(oPC,"TravelTo","Whistling Ravine");
else if (GetSubString(sTravel,2,2) == "CM") SetLocalString(oPC,"TravelTo","Caer Mabon");
else if (GetSubString(sTravel,2,2) == "AW") SetLocalString(oPC,"TravelTo","Annwyn Wood");
else if (GetSubString(sTravel,2,2) == "BT") SetLocalString(oPC,"TravelTo","Briarton");
else if (GetSubString(sTravel,2,2) == "FF") SetLocalString(oPC,"TravelTo","Foxglove Ferry");
else if (GetSubString(sTravel,2,2) == "TH") SetLocalString(oPC,"TravelTo","Thunin Heath");
else if (GetSubString(sTravel,2,2) == "SC") SetLocalString(oPC,"TravelTo","Scutifer Bridge");
else if (GetSubString(sTravel,2,2) == "CO") SetLocalString(oPC,"TravelTo","Caer Ouneri");
else if (GetSubString(sTravel,2,2) == "LH") SetLocalString(oPC,"TravelTo","Lake Hod");
else if (GetSubString(sTravel,2,2) == "HR") SetLocalString(oPC,"TravelTo","Hangman's Rock");
else if (GetSubString(sTravel,2,2) == "LD") SetLocalString(oPC,"TravelTo","Llewdor Dale");
else if (GetSubString(sTravel,2,2) == "CN") SetLocalString(oPC,"TravelTo","the Carrion Wastes");
else if (GetSubString(sTravel,2,2) == "TF") SetLocalString(oPC,"TravelTo","Trullhome Fenn");
else if (GetSubString(sTravel,2,2) == "AP") SetLocalString(oPC,"TravelTo","Axeport");

//if ((GetSubString(sTravel,0,2) == "CW") && (GetSubString(sTravel,2,2) == "RL"))
//    vBuffer = vRL - vCW;
//else if ((GetSubString(sTravel,0,2) == "RL") && (GetSubString(sTravel,2,2) == "CW"))
//    vBuffer = vCW - vRL;
if ((GetSubString(sTravel,0,2) == "CM") && (GetSubString(sTravel,2,2) == "SB"))
    vBuffer = vSB - vCM;
else if ((GetSubString(sTravel,0,2) == "SB") && (GetSubString(sTravel,2,2) == "CM"))
    vBuffer = vCM - vSB;
else if ((GetSubString(sTravel,0,2) == "CM") && (GetSubString(sTravel,2,2) == "BH"))
    vBuffer = vBH - vCM;
else if ((GetSubString(sTravel,0,2) == "BH") && (GetSubString(sTravel,2,2) == "CM"))
    vBuffer = vCM - vBH;
else if ((GetSubString(sTravel,0,2) == "SB") && (GetSubString(sTravel,2,2) == "WR"))
    vBuffer = vWR - vSB;
else if ((GetSubString(sTravel,0,2) == "WR") && (GetSubString(sTravel,2,2) == "SB"))
    vBuffer = vSB - vWR;
else if ((GetSubString(sTravel,0,2) == "CM") && (GetSubString(sTravel,2,2) == "AW"))
    vBuffer = vAW - vCM;
else if ((GetSubString(sTravel,0,2) == "AW") && (GetSubString(sTravel,2,2) == "CM"))
    vBuffer = vCM - vAW;
else if ((GetSubString(sTravel,0,2) == "BT") && (GetSubString(sTravel,2,2) == "BH"))
    vBuffer = vBH - vBT;
else if ((GetSubString(sTravel,0,2) == "BH") && (GetSubString(sTravel,2,2) == "BT"))
    vBuffer = vBT - vBH;
else if ((GetSubString(sTravel,0,2) == "SB") && (GetSubString(sTravel,2,2) == "FF"))
    vBuffer = vFF - vSB;
else if ((GetSubString(sTravel,0,2) == "FF") && (GetSubString(sTravel,2,2) == "SB"))
    vBuffer = vSB - vFF;
else if ((GetSubString(sTravel,0,2) == "TH") && (GetSubString(sTravel,2,2) == "AW"))
    vBuffer = vAW - vTH;
else if ((GetSubString(sTravel,0,2) == "AW") && (GetSubString(sTravel,2,2) == "TH"))
    vBuffer = vTH - vAW;
else if ((GetSubString(sTravel,0,2) == "TH") && (GetSubString(sTravel,2,2) == "BT"))
    vBuffer = vBT - vTH;
else if ((GetSubString(sTravel,0,2) == "BT") && (GetSubString(sTravel,2,2) == "TH"))
    vBuffer = vTH - vBT;
else if ((GetSubString(sTravel,0,2) == "TH") && (GetSubString(sTravel,2,2) == "CO"))
    vBuffer = vCO - vTH;
else if ((GetSubString(sTravel,0,2) == "CO") && (GetSubString(sTravel,2,2) == "TH"))
    vBuffer = vTH - vCO;
else if ((GetSubString(sTravel,0,2) == "SC") && (GetSubString(sTravel,2,2) == "FF"))
    vBuffer = vFF - vSC;
else if ((GetSubString(sTravel,0,2) == "FF") && (GetSubString(sTravel,2,2) == "SC"))
    vBuffer = vSC - vFF;
else if ((GetSubString(sTravel,0,2) == "SC") && (GetSubString(sTravel,2,2) == "CO"))
    vBuffer = vCO - vSC;
else if ((GetSubString(sTravel,0,2) == "CO") && (GetSubString(sTravel,2,2) == "SC"))
    vBuffer = vSC - vCO;
else if ((GetSubString(sTravel,0,2) == "LH") && (GetSubString(sTravel,2,2) == "CO"))
    vBuffer = vCO - vLH;
else if ((GetSubString(sTravel,0,2) == "CO") && (GetSubString(sTravel,2,2) == "LH"))
    vBuffer = vLH - vCO;
else if ((GetSubString(sTravel,0,2) == "LH") && (GetSubString(sTravel,2,2) == "HR"))
    vBuffer = vHR - vLH;
else if ((GetSubString(sTravel,0,2) == "HR") && (GetSubString(sTravel,2,2) == "LH"))
    vBuffer = vLH - vHR;
else if ((GetSubString(sTravel,0,2) == "TH") && (GetSubString(sTravel,2,2) == "HR"))
    vBuffer = vHR - vTH;
else if ((GetSubString(sTravel,0,2) == "HR") && (GetSubString(sTravel,2,2) == "TH"))
    vBuffer = vTH - vHR;
else if ((GetSubString(sTravel,0,2) == "LD") && (GetSubString(sTravel,2,2) == "HR"))
    vBuffer = vHR - vLD;
else if ((GetSubString(sTravel,0,2) == "HR") && (GetSubString(sTravel,2,2) == "LD"))
    vBuffer = vLD - vHR;
else if ((GetSubString(sTravel,0,2) == "LD") && (GetSubString(sTravel,2,2) == "BT"))
    vBuffer = vBT - vLD;
else if ((GetSubString(sTravel,0,2) == "BT") && (GetSubString(sTravel,2,2) == "LD"))
    vBuffer = vLD - vBT;
else if ((GetSubString(sTravel,0,2) == "LH") && (GetSubString(sTravel,2,2) == "CN"))
    vBuffer = vCN - vLH;
else if ((GetSubString(sTravel,0,2) == "CN") && (GetSubString(sTravel,2,2) == "LH"))
    vBuffer = vLH - vCN;
else if ((GetSubString(sTravel,0,2) == "CM") && (GetSubString(sTravel,2,2) == "TF"))
    vBuffer = vTF - vCM;
else if ((GetSubString(sTravel,0,2) == "CM") && (GetSubString(sTravel,2,2) == "SB"))
    vBuffer = vSB - vCM;
else if ((GetSubString(sTravel,0,2) == "SB") && (GetSubString(sTravel,2,2) == "TF"))
    vBuffer = vTF - vSB;
else if ((GetSubString(sTravel,0,2) == "TF") && (GetSubString(sTravel,2,2) == "SB"))
    vBuffer = vSB - vTF;
else if ((GetSubString(sTravel,0,2) == "AP") && (GetSubString(sTravel,2,2) == "TF"))
    vBuffer = vTF - vAP;
else if ((GetSubString(sTravel,0,2) == "TF") && (GetSubString(sTravel,2,2) == "AP"))
    vBuffer = vAP - vTF;
else if ((GetSubString(sTravel,0,2) == "AP") && (GetSubString(sTravel,2,2) == "SC"))
    vBuffer = vSC - vAP;
else if ((GetSubString(sTravel,0,2) == "SC") && (GetSubString(sTravel,2,2) == "AP"))
    vBuffer = vAP - vSC;


fAngle = VectorToAngle(vBuffer);
if ((fAngle > 337.5) || (fAngle <= 22.5)) SetLocalString(oPC,"TravelCompass","east");
else if ((fAngle > 22.5) && (fAngle <= 67.5)) SetLocalString(oPC,"TravelCompass","northeast");
else if ((fAngle > 67.5) && (fAngle <= 112.5)) SetLocalString(oPC,"TravelCompass","north");
else if ((fAngle > 112.5) && (fAngle <= 157.5)) SetLocalString(oPC,"TravelCompass","northwest");
else if ((fAngle > 157.5) && (fAngle <= 202.5)) SetLocalString(oPC,"TravelCompass","west");
else if ((fAngle > 202.5) && (fAngle <= 247.5)) SetLocalString(oPC,"TravelCompass","southwest");
else if ((fAngle > 247.5) && (fAngle <= 292.5)) SetLocalString(oPC,"TravelCompass","south");
else if ((fAngle > 292.5) && (fAngle <= 337.5)) SetLocalString(oPC,"TravelCompass","southeast");
//SpawnScriptDebugger();
fDistance = sqrt(vBuffer.x * vBuffer.x + vBuffer.y * vBuffer.y);
if ((GetLevelByClass(CLASS_TYPE_RANGER,oPC) == 0) && (GetLevelByClass(CLASS_TYPE_DRUID,oPC) == 0))
    {
    fDeviate = (fDistance / 100.0) * (20.0 - IntToFloat(GetAbilityModifier(ABILITY_WISDOM,oPC) * d20()));
    if (fDeviate < 0.0) fDeviate = 0.0;
    vBuffer.z = fDeviate;
    fDistance = sqrt(vBuffer.x * vBuffer.x + vBuffer.y * vBuffer.y + vBuffer.z * vBuffer.z);
    }
SetLocalInt(oPC,"TravelGoal",FloatToInt(fDistance));
sTravel = sTravel + IntToString(FloatToInt(fProportion * fDistance));
SetLocalString(oPC,"TRAVEL",sTravel);
}
