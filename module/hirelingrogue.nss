//Summon merc005 (hireling swordsman)

//::///////////////////////////////////////////////
//:: Name          Fignar the Barbarian
//:: FileName      GongRing
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:  Fignar the Barbarian
//:: Created On:6/23/02
//:://////////////////////////////////////////////
void Summon(string sTag, location coffin_loc);
int Random(int nMaxInteger);

#include "NW_I0_GENERIC"

void main()
{
        int x = 0;
        int i = 0;

        x = Random(2)  ;
        object oPC;
        location gong_loc = GetLocation(OBJECT_SELF);    //Store the location of the object
        oPC = GetLastUsedBy();

        ActionDoCommand(PlaySound("as_cv_gongring1"));
        ActionDoCommand(Summon("rogue1", gong_loc));

}
void Summon(string sTag, location gong_loc)
{
        CreateObject(OBJECT_TYPE_CREATURE, sTag, gong_loc);
}
