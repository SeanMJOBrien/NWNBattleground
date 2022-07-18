void main()
{
string sRace = GetLocalString(OBJECT_SELF,"race");
int iApp = GetAppearanceType(OBJECT_SELF);


if (sRace=="goblin")
        {
        int iRoll = d6();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOBLIN_B);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOBLIN_CHIEF_B);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOBLIN_CHIEF_A);
        if (iRoll==4) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOBLIN_SHAMAN_B);
        if (iRoll==5) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOBLIN_SHAMAN_A);
        if (iRoll==6) return;
        return;
        }
if (sRace=="bugbear")
        {
        int iRoll = d6();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BUGBEAR_B);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_B);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_A);
        if (iRoll==4) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BUGBEAR_SHAMAN_B);
        if (iRoll==5) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BUGBEAR_SHAMAN_A);
        if (iRoll==6) return;
        return;
        }
if (sRace=="orc"||iApp==APPEARANCE_TYPE_HALF_ORC)
        {
        SetCreatureBodyPart(CREATURE_PART_HEAD,Random(13)+1,OBJECT_SELF);
        SetPhenoType(PHENOTYPE_BIG,OBJECT_SELF);
        }
if (sRace=="gnoll")
        {
        int iRoll = Random(2);
        if (iRoll==0) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GNOLL_WIZ);
        if (iRoll==1) return;
        return;
        }
if (sRace=="hobgoblin")
        {
        SetCreatureBodyPart(CREATURE_PART_HEAD,Random(13)+1,OBJECT_SELF);
        }
if (sRace=="kobold")
        {
        int iRoll = d6();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_B);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_B);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_A);
        if (iRoll==4) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_SHAMAN_B);
        if (iRoll==5) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_SHAMAN_A);
        if (iRoll==6) return;
        return;
        }
if (sRace=="lizardman")
        {
        int iRoll = d8();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_LIZARDFOLK_B);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A);
        if (iRoll==4) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B);
        if (iRoll==5) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A);
        if (iRoll==6) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_ASABI_CHIEFTAIN);
        if (iRoll==7) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_ASABI_WARRIOR);
        if (iRoll==8) return;
        return;
        }
if (sRace=="minotaur")
        {
        int iRoll = d4();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINOTAUR_CHIEFTAIN);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINOTAUR_SHAMAN);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINOTAUR_CHIEFTAIN);
        if (iRoll==4) return;
        return;
        }
if (sRace=="ogre")
        {
        int iRoll = d6();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OGRE_CHIEFTAIN);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OGRE_CHIEFTAINB);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OGRE_MAGE);
        if (iRoll==4) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OGRE_MAGEB);
        if (iRoll==5) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OGREB);
        if (iRoll==6) return;
        return;
        }
if (sRace=="trog")
        {
        int iRoll = d4();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_TROGLODYTE_WARRIOR);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_TROGLODYTE_CLERIC);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_TROGLODYTE_WARRIOR);
        if (iRoll==4) return;
        return;
        }
if (sRace=="rakshasa")
        {
        int iRoll = d4();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_RAKSHASA_TIGER_MALE);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE);
        if (iRoll==4) return;
        return;
        }
if (sRace=="mindflayer")
        {
        int iRoll = d4();
        if (iRoll==1) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINDFLAYER_2);
        if (iRoll==2) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINDFLAYER_2);
        if (iRoll==3) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MINDFLAYER_ALHOON);
        if (iRoll==4) return;
        return;
        }
if (sRace=="hillgiant")
        {
        int iRoll = Random(2);
        if (iRoll==0) SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GIANT_MOUNTAIN);
        if (iRoll==1) return;
        return;
        }
}
