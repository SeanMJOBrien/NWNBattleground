void main()
{
int iRoll = Random(33)+1;
string sRes = "immitem"+IntToString(iRoll);
CreateItemOnObject(sRes,OBJECT_SELF);
}
