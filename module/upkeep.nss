void main()
{
object oMod = GetModule();
//handle turn number
int iTurn = GetLocalInt(oMod,"turn");
string sTurn = IntToString(iTurn);
SetLocalInt(oMod,"turn",iTurn+1);
SpeakString("UPKEEP: turn #"+sTurn,TALKVOLUME_SHOUT);
//the important stuff
//resource levels
int iFD1 = GetLocalInt(oMod,"1fd");
int iIR1 = GetLocalInt(oMod,"1ir");
int iWD1 = GetLocalInt(oMod,"1wd");
int iHD1 = GetLocalInt(oMod,"1hd");
int iST1 = GetLocalInt(oMod,"1st");
int iMT1 = GetLocalInt(oMod,"1mt");
int iAD1 = GetLocalInt(oMod,"1ad");
int iCP1 = GetLocalInt(oMod,"1cp");
int iEQ1 = GetLocalInt(oMod,"1eq");
int iIW1 = GetLocalInt(oMod,"1iw");
int iSN1 = GetLocalInt(oMod,"1sn");
//workers
int iFM1 = GetLocalInt(oMod,"1fm");
int iLJ1 = GetLocalInt(oMod,"1lj");
int iMN1 = GetLocalInt(oMod,"1mn");
int iCM1 = GetLocalInt(oMod,"1cm");
int iHT1 = GetLocalInt(oMod,"1ht");
int iSC1 = GetLocalInt(oMod,"1sc");
//math time
int iTax1 = (iFM1+iLJ1+iMN1+iCM1+iSC1)*100;
SetLocalInt(oMod,"tax1",iTax1);//taxes
SetLocalInt(oMod,"1fd",iFD1+iFM1+Random(iHT1)+1);//food
SetLocalInt(oMod,"1ir",iIR1+Random(iMN1)+1);//iron
SetLocalInt(oMod,"1hd",iHD1+Random(iHT1)+1);//hides
SetLocalInt(oMod,"1wd",iWD1+Random(iLJ1)+1);//wood
SetLocalInt(oMod,"1cp",iCP1+Random(iMN1)+1);//copper
SetLocalInt(oMod,"1eq",iEQ1+Random(iCM1)+1);//equipment
SetLocalInt(oMod,"1sn",iSN1+Random(iSC1)+1);//stone
iIR1 = GetLocalInt(oMod,"1ir");
int iFoundry1 = GetLocalInt(oMod,"1foundry");
if (iIR1>=1&&iFoundry1==TRUE)//steel
    {
    SetLocalInt(oMod,"1ir",iIR1-1);
    SetLocalInt(oMod,"1st",iST1+d4());
    }
if (d100()<=iMN1)SetLocalInt(oMod,"1mt",iMT1+1);//mithril
if (d100()<=iMN1)SetLocalInt(oMod,"1ad",iAD1+1);//adamantine
if (d20()<=iLJ1)SetLocalInt(oMod,"1iw",iIW1+1);//ironwood
//side 2
//resource levels
int iFD2 = GetLocalInt(oMod,"2fd");
int iIR2 = GetLocalInt(oMod,"2ir");
int iWD2 = GetLocalInt(oMod,"2wd");
int iHD2 = GetLocalInt(oMod,"2hd");
int iST2 = GetLocalInt(oMod,"2st");
int iMT2 = GetLocalInt(oMod,"2mt");
int iAD2 = GetLocalInt(oMod,"2ad");
int iCP2 = GetLocalInt(oMod,"2cp");
int iEQ2 = GetLocalInt(oMod,"2eq");
int iIW2 = GetLocalInt(oMod,"2iw");
int iSN2 = GetLocalInt(oMod,"2sn");
//workers
int iFM2 = GetLocalInt(oMod,"2fm");
int iLJ2 = GetLocalInt(oMod,"2lj");
int iMN2 = GetLocalInt(oMod,"2mn");
int iCM2 = GetLocalInt(oMod,"2cm");
int iHT2 = GetLocalInt(oMod,"2ht");
int iSC2 = GetLocalInt(oMod,"2sc");
//math time
int iTax2 = (iFM2+iLJ2+iMN2+iCM2+iSC2)*100;
SetLocalInt(oMod,"tax2",iTax2);//taxes
SetLocalInt(oMod,"2fd",iFD2+iFM2+Random(iHT2)+1);//food
SetLocalInt(oMod,"2ir",iIR2+Random(iMN2)+1);//iron
SetLocalInt(oMod,"2hd",iHD2+Random(iHT2)+1);//hides
SetLocalInt(oMod,"2wd",iWD2+Random(iLJ2)+1);//wood
SetLocalInt(oMod,"2cp",iCP2+Random(iMN2)+1);//copper
SetLocalInt(oMod,"2eq",iEQ2+Random(iCM2)+1);//equipment
SetLocalInt(oMod,"2sn",iSN2+Random(iSC2)+1);//stone
iIR2 = GetLocalInt(oMod,"2ir");
int iFoundry2 = GetLocalInt(oMod,"2foundry");
if (iIR2>=1&&iFoundry2==TRUE)//steel
    {
    SetLocalInt(oMod,"2ir",iIR2-1);
    SetLocalInt(oMod,"2st",iST2+d4());
    }
if (d100()<=iMN2)SetLocalInt(oMod,"2mt",iMT2+1);//mithril
if (d100()<=iMN2)SetLocalInt(oMod,"2ad",iAD2+1);//adamantine
if (d20()<=iLJ2)SetLocalInt(oMod,"2iw",iIW2+1);//ironwood
//mana related stuff
int iMana1 = GetLocalInt(oMod,"1mana");
int iMana2 = GetLocalInt(oMod,"2mana");
string sMana1 = IntToString(iMana1);
string sMana2 = IntToString(iMana2);
SpeakString("<cþ þ>Good mana level is "+sMana1+". Evil mana level is "+sMana2+".</c>",TALKVOLUME_SHOUT);
//PC stuff
object oPC = GetFirstPC();
int iSide;
int iGood = 0;
int iEvil = 0;
int iLevels = 0;
int iPCs = 0;
while(oPC!=OBJECT_INVALID)
    {
    ExecuteScript("hourly",oPC);
    iLevels = GetHitDice(oPC)+iLevels;
    iPCs = iPCs+1;
    iSide = GetLocalInt(oPC,"team");
    if (iSide==1) iGood+=1;
    if (iSide==2) iEvil+=1;
    oPC=GetNextPC();
    }
int iAvg = iLevels/iPCs;
SetLocalInt(oMod,"avglevel",iAvg);
//SpeakString("Average level is "+IntToString(iAvg),TALKVOLUME_SHOUT);
if (iGood<1) iGood=1;
if (iEvil<1) iEvil=1;
SetLocalInt(oMod,"goodplayers",iGood);
SetLocalInt(oMod,"evilplayers",iEvil);
//run random event script
ExecuteScript("randomevent",OBJECT_SELF);
//check for win/loss
if (iMana1>=1000) DelayCommand(20.0f,ExecuteScript("goodwins",OBJECT_SELF));
if (iMana2>=1000) DelayCommand(20.0f,ExecuteScript("evilwins",OBJECT_SELF));
}

