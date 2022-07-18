void main()
{
///////COLORS/////////
//</c> CLOSE tag
//<cþ  > red
//<c þ > green
//<c  þ> blue
//<c þþ> cyan
//<cþ þ> magenta
//<cþþ > yellow
//<c   > black
//<c¥  > dark red
//<c ¥ > dark green
//<c  ¥> dark blue
//<c ¥¥> dark cyan
//<c¥ ¥> dark magenta
//<c¥¥ > dark yellow
//<c¥¥¥> grey
//<cŒŒŒ> dark grey
//<cþ¥ > orange
//<cþŒ > dark orange
//<cÚ¥#> brown
//<cÂ† > dark brown
//nw_i0_2q4luskan
int iValue = GetGoldPieceValue(OBJECT_SELF);
string sName = GetName(OBJECT_SELF);
if (iValue>=10000000)
    {
    SetName(OBJECT_SELF,"<cþ  >"+sName+"</c>");
    return;
    }
if (iValue>=5000000)
    {
    SetName(OBJECT_SELF,"<cþ þ>"+sName+"</c>");
    return;
    }
if (iValue>=1000000)
    {
    SetName(OBJECT_SELF,"<cþ¥ >"+sName+"</c>");
    return;
    }
if (iValue>=500000)
    {
    SetName(OBJECT_SELF,"<cþþ >"+sName+"</c>");
    return;
    }
if (iValue>=100000)
    {
    SetName(OBJECT_SELF,"<c þ >"+sName+"</c>");
    return;
    }
if (iValue>=50000)
    {
    SetName(OBJECT_SELF,"<c þþ>"+sName+"</c>");
    return;
    }
if (iValue>=9000)
    {
    SetName(OBJECT_SELF,"<c  þ>"+sName+"</c>");
    return;
    }
if (iValue>=350)
    {
    SetName(OBJECT_SELF,"<c ¥¥>"+sName+"</c>");
    return;
    }
}
