/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.0

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625

     Script Modified by DawnWalker and Script Wizard*/
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oSpawn;
location lTarget;
oTarget = oPC;

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_STORE, "stock_magpotmisc", lTarget);

object oStore = GetNearestObjectByTag("stock_magpotmisc");
     if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
         OpenStore(oStore, GetPCSpeaker());
       else
         ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}

