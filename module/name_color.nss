void main()
{
///////COLORS/////////
//</c> CLOSE tag
//<c�  > red
//<c � > green
//<c  �> blue
//<c ��> cyan
//<c� �> magenta
//<c�� > yellow
//<c   > black
//<c�  > dark red
//<c � > dark green
//<c  �> dark blue
//<c ��> dark cyan
//<c� �> dark magenta
//<c�� > dark yellow
//<c���> grey
//<c���> dark grey
//<c�� > orange
//<c�� > dark orange
//<cڥ#> brown
//<c > dark brown
//nw_i0_2q4luskan
int iValue = GetGoldPieceValue(OBJECT_SELF);
string sName = GetName(OBJECT_SELF);
if (iValue>=10000000)
    {
    SetName(OBJECT_SELF,"<c�  >"+sName+"</c>");
    return;
    }
if (iValue>=5000000)
    {
    SetName(OBJECT_SELF,"<c� �>"+sName+"</c>");
    return;
    }
if (iValue>=1000000)
    {
    SetName(OBJECT_SELF,"<c�� >"+sName+"</c>");
    return;
    }
if (iValue>=500000)
    {
    SetName(OBJECT_SELF,"<c�� >"+sName+"</c>");
    return;
    }
if (iValue>=100000)
    {
    SetName(OBJECT_SELF,"<c � >"+sName+"</c>");
    return;
    }
if (iValue>=50000)
    {
    SetName(OBJECT_SELF,"<c ��>"+sName+"</c>");
    return;
    }
if (iValue>=9000)
    {
    SetName(OBJECT_SELF,"<c  �>"+sName+"</c>");
    return;
    }
if (iValue>=350)
    {
    SetName(OBJECT_SELF,"<c ��>"+sName+"</c>");
    return;
    }
}
