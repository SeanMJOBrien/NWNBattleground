void main()
{
/////////////////set up magic level////////////////
int iHD = GetLocalInt(OBJECT_SELF,"mylevel");
int iMult = 1;
float iMrate = GetLocalFloat(GetModule(),"magic");
iHD = FloatToInt(iHD*iMrate)*iMult;
if (iHD<=0) iHD=0;
if (iHD>=40) iHD=40;
///////////////////////////////////////////////////
int    nProperty;
int    nRoll=Random(270)+1;
string sName;
int iLevel=0;
int iTimes = iHD+d20();
int iUses;

if (iTimes<=14) iUses = 2;
if (iTimes>=15&&iTimes<=22) iUses = 3;
if (iTimes>=23&&iTimes<=28) iUses = 4;
if (iTimes>=29&&iTimes<=34) iUses = 5;
if (iTimes>=35&&iTimes<=39) iUses = 6;
if (iTimes>=40&&iTimes<=45) iUses = 8;
if (iTimes>=46&&iTimes<=51) iUses = 9;
if (iTimes>=52&&iTimes<=54) iUses = 10;
if (iTimes>=55&&iTimes<=57) iUses = 11;
if (iTimes==58||iTimes==59) iUses = 12;
if (iTimes>=60) iUses = 13;

switch (nRoll)
    {
     case 1 : nProperty = IP_CONST_CASTSPELL_ACID_FOG_11; iLevel=11; sName = "Acid Fog"; break;
     case 2 : nProperty = IP_CONST_CASTSPELL_ACID_SPLASH_1; iLevel=1; sName = "Acid Splash"; break;
     case 3 : nProperty = IP_CONST_CASTSPELL_AID_3; iLevel=3; sName = "Aid";break;
     case 4 : nProperty = IP_CONST_CASTSPELL_AMPLIFY_5; iLevel=5; sName = "Amplify";break;
     case 5 : nProperty = IP_CONST_CASTSPELL_ANIMATE_DEAD_10; iLevel=10; sName = "Animate Dead";break;
     case 6 : nProperty = IP_CONST_CASTSPELL_ANIMATE_DEAD_15; iLevel=15; sName = "Animate Dead";break;
     case 7 : nProperty = IP_CONST_CASTSPELL_ANIMATE_DEAD_5; iLevel=5; sName = "Animate Dead";break;
     case 8 : nProperty = IP_CONST_CASTSPELL_AURA_OF_VITALITY_13; iLevel=13; sName = "Aura of Vitality";break;
     case 9 : nProperty = IP_CONST_CASTSPELL_AURA_VERSUS_ALIGNMENT_15; iLevel=15; sName = "Aura Versus Alignment";break;
     case 10 : nProperty = IP_CONST_CASTSPELL_AURAOFGLORY_7; iLevel=7; sName ="Aura of Glory";break;
     case 11 : nProperty = IP_CONST_CASTSPELL_AWAKEN_9; iLevel=9; sName ="Awaken";break;
     case 12 : nProperty = IP_CONST_CASTSPELL_BALAGARNSIRONHORN_7; iLevel=7; sName = "Balagarn's Iron Horn";break;
     case 13 : nProperty = IP_CONST_CASTSPELL_BANE_5; iLevel=5; sName ="Bane";break;
     case 14 : nProperty = IP_CONST_CASTSPELL_BANISHMENT_15; iLevel=15; sName ="Banishment";break;
     case 15 : nProperty = IP_CONST_CASTSPELL_BARKSKIN_12; iLevel=12; sName ="Barkskin";break;
     case 16 : nProperty = IP_CONST_CASTSPELL_BARKSKIN_3; iLevel=3; sName ="Barkskin";break;
     case 17 : nProperty = IP_CONST_CASTSPELL_BARKSKIN_6; iLevel=6; sName ="Barkskin";break;
     case 18 : nProperty = IP_CONST_CASTSPELL_BESTOW_CURSE_5; iLevel=5; sName ="Bestow Curse";break;
     case 19 : nProperty = IP_CONST_CASTSPELL_BIGBYS_CLENCHED_FIST_20;iLevel=20; sName ="Bigby's Clenched Fist"; break;
     case 20 : nProperty = IP_CONST_CASTSPELL_BIGBYS_CRUSHING_HAND_20; iLevel=20; sName ="Bigby's Crushing Hand";break;
     case 21 : nProperty = IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15;iLevel=15; sName = "Bigby's Forceful Hand";break;
     case 22 : nProperty = IP_CONST_CASTSPELL_BIGBYS_GRASPING_HAND_17; iLevel=17; sName ="Bigby's Grasping Hand";break;
     case 23 : nProperty = IP_CONST_CASTSPELL_BIGBYS_INTERPOSING_HAND_15; iLevel=15; sName ="Bigby's Interposing Hand";break;
     case 24 : nProperty = IP_CONST_CASTSPELL_BLADE_BARRIER_11; iLevel=11; sName ="Blade Barrier";break;
     case 25 : nProperty = IP_CONST_CASTSPELL_BLADE_BARRIER_15;iLevel=15; sName = "Blade Barrier"; break;
     case 26 : nProperty = IP_CONST_CASTSPELL_BLESS_2; iLevel=2; sName ="Bless";break;
     case 27 : nProperty = IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3; iLevel=3; sName ="Blindness and Deafness";break;
     case 28 : nProperty = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;iLevel=7; sName = "Blood Frenzy";break;
     case 29 : nProperty = IP_CONST_CASTSPELL_BOMBARDMENT_20; iLevel=20; sName ="Bombardment";break;
     case 30 : nProperty = IP_CONST_CASTSPELL_BULLS_STRENGTH_10; iLevel=10; sName ="Bull's Strength";break;
     case 31 : nProperty = IP_CONST_CASTSPELL_BURNING_HANDS_2; iLevel=2; sName ="Burning Hands";break;
     case 32 : nProperty = IP_CONST_CASTSPELL_CALL_LIGHTNING_10; iLevel=10; sName ="Call Lightning";break;
     case 33 : nProperty = IP_CONST_CASTSPELL_CATS_GRACE_10; iLevel=10; sName ="Cat's Grace";break;
     case 34 : nProperty = IP_CONST_CASTSPELL_CAMOFLAGE_5; iLevel=5; sName ="Camouflage";break;
     case 35 : nProperty = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20; iLevel=20; sName ="Chain Lightning";break;
     case 36 : nProperty = IP_CONST_CASTSPELL_CHARM_MONSTER_10; iLevel=10; sName ="Charm Monster";break;
     case 37 : nProperty = IP_CONST_CASTSPELL_CHARM_PERSON_10;iLevel=10; sName = "Charm Person";break;
     case 38 : nProperty = IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10;iLevel=10; sName ="Charm Person or Animal"; break;
     case 39 : nProperty = IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_11; iLevel=11; sName ="Circle of Death";break;
     case 40 : nProperty = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20; iLevel=20; sName ="Circle of Doom";break;
     case 41 : nProperty = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_10; iLevel=10; sName ="Clairaudience and Clairvoyance";break;
     case 42 : nProperty = IP_CONST_CASTSPELL_CLARITY_3; iLevel=3; sName ="Clarity";break;
     case 43 : nProperty = IP_CONST_CASTSPELL_CLOUDKILL_9;iLevel=9; sName ="Cloudkill"; break;
     case 44 : nProperty = IP_CONST_CASTSPELL_COLOR_SPRAY_2;iLevel=2; sName = "Color Spray";break;
     case 45 : nProperty = IP_CONST_CASTSPELL_CONE_OF_COLD_15; iLevel=15; sName ="Cone of Cold";break;
     case 46 : nProperty = IP_CONST_CASTSPELL_CONFUSION_10; iLevel=10; sName ="Confusion";break;
     case 47 : nProperty = IP_CONST_CASTSPELL_CONTROL_UNDEAD_13; iLevel=13; sName ="Control Undead";break;
     case 48 : nProperty = IP_CONST_CASTSPELL_CONTINUAL_FLAME_7; iLevel=7; sName ="Continual Flame";break;
     case 49 : nProperty = IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_15; iLevel=15; sName ="Create Greater Undead";break;
     case 50 : nProperty = IP_CONST_CASTSPELL_CREATE_UNDEAD_16; iLevel=16; sName ="Create Undead";break;
     case 51 : nProperty = IP_CONST_CASTSPELL_CREEPING_DOOM_13;iLevel=13; sName ="Creeping Doom";break;
     case 52 : nProperty = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15; iLevel=15; sName ="Cure Critical Wounds";break;
     case 53 : nProperty = IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5;iLevel=5; sName ="Cure Light Wounds"; break;
     case 54 : nProperty = IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_6; iLevel=6; sName ="Cure Moderate Wounds";break;
     case 55 : nProperty = IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10; iLevel=10; sName ="Cure Serious Wounds";break;
     case 56 : nProperty = IP_CONST_CASTSPELL_DARKVISION_3;iLevel=3; sName ="Darkvision"; break;
     case 57 : nProperty = IP_CONST_CASTSPELL_DAZE_1;iLevel=1; sName ="Daze";break;
     case 58 : nProperty = IP_CONST_CASTSPELL_DEATH_WARD_7; iLevel=7; sName ="Death Ward";break;
     case 59 : nProperty = IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_15;iLevel=15; sName ="Delayed Fireball";break;
     case 60 : nProperty = IP_CONST_CASTSPELL_DESTRUCTION_13; iLevel=13; sName ="Destruction";break;
     case 61 : nProperty = IP_CONST_CASTSPELL_DISMISSAL_18; iLevel=18; sName ="Dismissal";break;
     case 62 : nProperty = IP_CONST_CASTSPELL_DIRGE_15; iLevel=15; sName ="Dirge";break;
     case 63 : nProperty = IP_CONST_CASTSPELL_DISPEL_MAGIC_10; iLevel=10; sName ="Dispel Magic";break;
     case 64 : nProperty = IP_CONST_CASTSPELL_DISPLACEMENT_9; iLevel=9; sName ="Displacement";break;
     case 65 : nProperty = IP_CONST_CASTSPELL_DIVINE_MIGHT_5; iLevel=5; sName ="Divine Might";break;
     case 66 : nProperty = IP_CONST_CASTSPELL_DIVINE_FAVOR_5; iLevel=5; sName ="Divine Favor";break;
     case 67 : nProperty = IP_CONST_CASTSPELL_DIVINE_SHIELD_5; iLevel=5; sName ="Divine Shield";break;
     case 68 : nProperty = IP_CONST_CASTSPELL_DOMINATE_ANIMAL_5; iLevel=5; sName ="Dominate Animal";break;
     case 69 : nProperty = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;iLevel=17; sName ="Dominate Monster"; break;
     case 70 : nProperty = IP_CONST_CASTSPELL_DOOM_5;iLevel=5; sName ="Doom";break;
     case 71 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_ACID_10;iLevel=11; sName ="Dragon Breath (Acid)"; break;
     case 72 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_COLD_10; iLevel=11; sName ="Dragon Breath (Cold)";break;
     case 73 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10; iLevel=11; sName ="Dragon Breath (Fire)";break;
     case 74 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_FEAR_10; iLevel=11; sName ="Dragon Breath (Fear)";break;
     case 75 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_GAS_10;iLevel=11; sName ="Dragon Breath (Gas)";break;
     case 76 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_LIGHTNING_10;iLevel=11;  sName ="Dragon Breath (Lightning)";break;
     case 77 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_PARALYZE_10;iLevel=11; sName ="Dragon Breath (Paralyze)";break;
     case 78 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_SLEEP_10; iLevel=11; sName ="Dragon Breath (Sleep)";break;
     case 79 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_SLOW_10; iLevel=11; sName ="Dragon Breath (Slow)";break;
     case 80 : nProperty = IP_CONST_CASTSPELL_DRAGON_BREATH_WEAKEN_10; iLevel=11; sName ="Dragon Breath (Weakening)";break;
     case 81 : nProperty = IP_CONST_CASTSPELL_DROWN_15; iLevel=15; sName ="Drown";break;
     case 82 : nProperty = IP_CONST_CASTSPELL_EAGLE_SPLEDOR_10;iLevel=10; sName ="Eagle's Splendor"; break;
     case 83 : nProperty = IP_CONST_CASTSPELL_EARTHQUAKE_20; iLevel=20; sName ="Earthquake";break;
     case 84 : nProperty = IP_CONST_CASTSPELL_ELECTRIC_JOLT_1; iLevel=1; sName ="Electrical Bolt";break;
     case 85 : nProperty = IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17;iLevel=17; sName ="Elemental Swarm"; break;
     case 86 : nProperty = IP_CONST_CASTSPELL_ENDURANCE_15; iLevel=15; sName ="Endurance";break;
     case 87 : nProperty = IP_CONST_CASTSPELL_ENERGY_BUFFER_15; iLevel=15; sName ="Energy Buffer";break;
     case 88 : nProperty = IP_CONST_CASTSPELL_ENERGY_DRAIN_17; iLevel=17; sName ="Energy Drain"; break;
     case 89 : nProperty = IP_CONST_CASTSPELL_ENERVATION_7; iLevel=7; sName ="Enervation";break;
     case 90 : nProperty = IP_CONST_CASTSPELL_ENTANGLE_2; iLevel=2; sName ="Entangle";break;
     case 91 : nProperty = IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5; iLevel=5; sName ="Entropic Shield";break;
     case 92 : nProperty = IP_CONST_CASTSPELL_ETHEREAL_VISAGE_9; iLevel=9; sName ="Ethereal Visage";break;
     case 93 : nProperty = IP_CONST_CASTSPELL_ETHEREALNESS_18;iLevel=18; sName ="Etherealness";break;
     case 94 : nProperty = IP_CONST_CASTSPELL_EVARDS_BLACK_TENTACLES_15; iLevel=15; sName ="Evard's Black Tentacles";break;
     case 95 : nProperty = IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5; iLevel=5; sName ="Expeditious Retreat";break;
     case 96 : nProperty = IP_CONST_CASTSPELL_FEAR_5; iLevel=5; sName ="Fear";break;
     case 97 : nProperty = IP_CONST_CASTSPELL_FEEBLEMIND_9; iLevel=9; sName ="Feeblemind";break;
     case 98 : nProperty = IP_CONST_CASTSPELL_FIND_TRAPS_3; iLevel=3; sName ="Find Trap";break;
     case 99 : nProperty = IP_CONST_CASTSPELL_FINGER_OF_DEATH_13; iLevel=13; sName ="Finger Of Death";break;
     case 100 : nProperty = IP_CONST_CASTSPELL_FIRE_STORM_18; iLevel=18; sName ="Fire Storm";break;
     case 101 : nProperty = IP_CONST_CASTSPELL_FIREBALL_10; iLevel=10; sName ="Fireball";break;
     case 102 : nProperty = IP_CONST_CASTSPELL_FIREBRAND_15; iLevel=15; sName ="Firebrand";break;
     case 103 : nProperty = IP_CONST_CASTSPELL_FLAME_ARROW_18; iLevel=18; sName ="Flame Arrow";break;
     case 104 : nProperty = IP_CONST_CASTSPELL_FLAME_LASH_10; iLevel=10; sName ="Flame Lash";break;
     case 105 : nProperty = IP_CONST_CASTSPELL_FLAME_STRIKE_18;iLevel=18; sName ="Flame Strike"; break;
     case 106 : nProperty = IP_CONST_CASTSPELL_FLARE_1; iLevel=1; sName ="Flare";break;
     case 107 : nProperty = IP_CONST_CASTSPELL_FOXS_CUNNING_10; iLevel=10; sName ="Fox's Cunning";break;
     case 108 : nProperty = IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;iLevel=7; sName ="Freedom of Movment"; break;
     case 109 : nProperty = IP_CONST_CASTSPELL_GATE_17; iLevel=17; sName ="Gate";break;
     case 110 : nProperty = IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15;iLevel=15; sName ="Ghostly Visage";break;
     case 111 : nProperty = IP_CONST_CASTSPELL_GHOUL_TOUCH_3; iLevel=3; sName ="Ghoul Touch";break;
     case 112 : nProperty = IP_CONST_CASTSPELL_GLOBE_OF_INVULNERABILITY_11;iLevel=11; sName ="Globe of Invulnerability"; break;
     case 113 : nProperty = IP_CONST_CASTSPELL_GREASE_2;iLevel=2; sName ="Grease";break;
     case 114 : nProperty = IP_CONST_CASTSPELL_GREATER_BULLS_STRENGTH_11; iLevel=11; sName ="Greater Bull's Strength";break;
     case 115 : nProperty = IP_CONST_CASTSPELL_GREATER_CATS_GRACE_11;iLevel=11;  sName ="Greater Cat's Grace";break;
     case 116 : nProperty = IP_CONST_CASTSPELL_GREATER_DISPELLING_15;iLevel=15;  sName ="Greater Dispelling";break;
     case 117 : nProperty = IP_CONST_CASTSPELL_GREATER_EAGLES_SPLENDOR_11; iLevel=11; sName ="Greater Eagle's Splendor";break;
     case 118 : nProperty = IP_CONST_CASTSPELL_GREATER_ENDURANCE_11; iLevel=11; sName ="Greater Endurance";break;
     case 119 : nProperty = IP_CONST_CASTSPELL_GREATER_FOXS_CUNNING_11; iLevel=11; sName ="Greater Fox's Cunning";break;
     case 120 : nProperty = IP_CONST_CASTSPELL_GREATER_MAGIC_FANG_9; iLevel=9; sName ="Greater Magic Fang";break;
     case 121 : nProperty = IP_CONST_CASTSPELL_GREATER_OWLS_WISDOM_11; iLevel=11; sName ="Greater Owl's Wisdom";break;
     case 122 : nProperty = IP_CONST_CASTSPELL_GREATER_PLANAR_BINDING_15; iLevel=15; sName ="Greater Planar Binding";break;
     case 123 : nProperty = IP_CONST_CASTSPELL_GREATER_RESTORATION_13; iLevel=13; sName ="Greater Restoration";break;
     case 124 : nProperty = IP_CONST_CASTSPELL_GREATER_SHADOW_CONJURATION_9; iLevel=9; sName ="Greater Shadow Conjuration";break;
     case 125 : nProperty = IP_CONST_CASTSPELL_GREATER_SPELL_BREACH_11; iLevel=11; sName ="Greater Spell Breach";break;
     case 126 : nProperty = IP_CONST_CASTSPELL_GREATER_SPELL_MANTLE_17;iLevel=17; sName = "Greater Spell Mantle";break;
     case 127 : nProperty = IP_CONST_CASTSPELL_GREATER_STONESKIN_11; iLevel=11; sName ="Greater Stoneskin";break;
     case 128 : nProperty = IP_CONST_CASTSPELL_GREATER_BULLS_STRENGTH_11; iLevel=11; sName ="Greater Bull's Strength";break;
     case 129 : nProperty = IP_CONST_CASTSPELL_GREATER_FOXS_CUNNING_11; iLevel=11; sName ="Greater Fox's Cunning";break;
     case 130 : nProperty = IP_CONST_CASTSPELL_GREATER_OWLS_WISDOM_11; iLevel=11; sName ="Greater Owl's Wisdom";break;
     case 131 : nProperty = IP_CONST_CASTSPELL_GREATER_EAGLES_SPLENDOR_11; iLevel=11; sName ="Greater Eagle's Splendor";break;
     case 132 : nProperty = IP_CONST_CASTSPELL_GREATER_RESTORATION_13; iLevel=13; sName ="Greater Restoration";break;
     case 133 : nProperty = IP_CONST_CASTSPELL_GREATER_ENDURANCE_11; iLevel=11; sName ="Greater Endurance";break;
     case 134 : nProperty = IP_CONST_CASTSPELL_GREATER_CATS_GRACE_11;iLevel=11;  sName ="Greater Cat's Grace";break;
     case 135 : nProperty = IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15;iLevel=15; sName ="Ghostly Visage";break;
     case 136 : nProperty = IP_CONST_CASTSPELL_GUST_OF_WIND_10; iLevel=10;sName ="Gust of Wind";break;
     case 137 : nProperty = IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_12; iLevel=12;sName ="Hammer of the Gods";break;
     case 138 : nProperty = IP_CONST_CASTSPELL_HARM_11; iLevel=11;sName ="Harm";break;
     case 139 : nProperty = IP_CONST_CASTSPELL_HASTE_10; iLevel=10;sName ="Haste";break;
     case 140 : nProperty = IP_CONST_CASTSPELL_HEAL_11; iLevel=11;sName ="Heal";break;
     case 141 : nProperty = IP_CONST_CASTSPELL_HEALING_CIRCLE_16; iLevel=16;sName ="Healing Circle";break;
     case 142 : nProperty = IP_CONST_CASTSPELL_HOLD_MONSTER_7;iLevel=7;sName = "Hold Monster";break;
     case 143 : nProperty = IP_CONST_CASTSPELL_HOLD_ANIMAL_3; iLevel=3;sName ="Hold Animal";break;
     case 144 : nProperty = IP_CONST_CASTSPELL_HORRID_WILTING_20;iLevel=20;sName = "Horrid Wilting";break;
     case 145 : nProperty = IP_CONST_CASTSPELL_ICE_STORM_9;iLevel=9;sName = "Ice Storm";break;
     case 146 : nProperty = IP_CONST_CASTSPELL_IDENTIFY_3;iLevel=3; sName ="Identify";break;
     case 147 : nProperty = IP_CONST_CASTSPELL_IMPLOSION_17;iLevel=17;sName ="Implosion"; break;
     case 148 : nProperty = IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7; iLevel=7;sName ="Improved Invisibility";break;
     case 149 : nProperty = IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15;iLevel=15;sName ="Incendiary Cloud"; break;
     case 150 : nProperty = IP_CONST_CASTSPELL_INFERNO_15; iLevel=15;sName ="Inferno";break;
     case 151 : nProperty = IP_CONST_CASTSPELL_INFLICT_CRITICAL_WOUNDS_12;iLevel=12;sName ="Inflict Critical Wounds";break;
     case 152 : nProperty = IP_CONST_CASTSPELL_INFLICT_MINOR_WOUNDS_1; iLevel=1;sName ="Inflict Minor Wounds";break;
     case 153 : nProperty = IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5;iLevel=5;sName ="Inflict Light Wounds"; break;
     case 154 : nProperty = IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7; iLevel=7;sName ="Inflict Moderate Wounds";break;
     case 155 : nProperty = IP_CONST_CASTSPELL_INFLICT_SERIOUS_WOUNDS_9;iLevel=9;sName ="Inflict Serious Wounds";break;
     case 156 : nProperty = IP_CONST_CASTSPELL_INVISIBILITY_3; iLevel=3;sName ="Invisibility";break;
     case 157 : nProperty = IP_CONST_CASTSPELL_INVISIBILITY_PURGE_5; iLevel=5;sName ="Invisibility Purge";break;
     case 158 : nProperty = IP_CONST_CASTSPELL_INVISIBILITY_SPHERE_5; iLevel=5;sName ="Invisibility Sphere";break;
     case 159 : nProperty = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15; iLevel=15;sName ="Isaac's Greater Missile Storm";break;
     case 160 : nProperty = IP_CONST_CASTSPELL_KNOCK_3;iLevel=3;sName ="Knock";break;
     case 161 : nProperty = IP_CONST_CASTSPELL_LEGEND_LORE_5; iLevel=5;sName ="Legend Lore";break;
     case 162 : nProperty = IP_CONST_CASTSPELL_LESSER_DISPEL_3; iLevel=3;sName ="Lesser Dispel";break;
     case 163 : nProperty = IP_CONST_CASTSPELL_LESSER_MIND_BLANK_9;iLevel=9;sName ="Lesser Mind Blank"; break;
     case 164 : nProperty = IP_CONST_CASTSPELL_LESSER_PLANAR_BINDING_9;iLevel=9;sName ="Lesser Planar Binding";break;
     case 165 : nProperty = IP_CONST_CASTSPELL_LESSER_RESTORATION_3; iLevel=3;sName ="Lesser Restoration";break;
     case 166 : nProperty = IP_CONST_CASTSPELL_LESSER_SPELL_BREACH_7;iLevel=7; sName ="Lesser Spell Breah";break;
     case 167 : nProperty = IP_CONST_CASTSPELL_LESSER_SPELL_MANTLE_9; iLevel=9;sName ="Lesser Spell Mantle";break;
     case 168 : nProperty = IP_CONST_CASTSPELL_LIGHT_5; iLevel=5;sName ="Light";break;
     case 169 : nProperty = IP_CONST_CASTSPELL_LIGHTNING_BOLT_10;iLevel=10;sName ="Lightning Bolt"; break;
     case 170 : nProperty = IP_CONST_CASTSPELL_MAGE_ARMOR_2; iLevel=2;sName ="Mage Armor";break;
     case 171 : nProperty = IP_CONST_CASTSPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT_5; iLevel=5;sName ="Magic Circle Against Alignment";break;
     case 172 : nProperty = IP_CONST_CASTSPELL_MAGIC_FANG_5; iLevel=5;sName ="Magic Fang";break;
     case 173 : nProperty = IP_CONST_CASTSPELL_MAGIC_MISSILE_9; iLevel=9;sName ="Magic Missile";break;
     case 174 : nProperty = IP_CONST_CASTSPELL_MASS_HEAL_15; iLevel=15;sName ="Mass Heal";break;
     case 175 : nProperty = IP_CONST_CASTSPELL_MASS_BLINDNESS_DEAFNESS_15; iLevel=15;sName ="Mass Blindness and Deafness"; break;
     case 176 : nProperty = IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13;iLevel=13;sName ="Mass Camouflage"; break;
     case 177 : nProperty = IP_CONST_CASTSPELL_MASS_CHARM_15; iLevel=15;sName ="Mass Charm";break;
     case 178 : nProperty = IP_CONST_CASTSPELL_MASS_HASTE_11; iLevel=9;sName ="Mass Haste";break;
     case 179 : nProperty = IP_CONST_CASTSPELL_MASS_HEAL_15; iLevel=15;sName ="Mass Heal";break;
     case 180 : nProperty = IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9; iLevel=9;sName ="Melf's Acid Arrow";break;
     case 181 : nProperty = IP_CONST_CASTSPELL_METEOR_SWARM_17; iLevel=17;sName ="Meteor Swarm";break;
     case 182 : nProperty = IP_CONST_CASTSPELL_MIND_BLANK_15; iLevel=15;sName ="Mind Blank";break;
     case 183 : nProperty = IP_CONST_CASTSPELL_MIND_FOG_9; iLevel=9;sName ="Mind Fog";break;
     case 184 : nProperty = IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_15; iLevel=15;sName ="Minor Globe of Invulnerability";break;
     case 185 : nProperty = IP_CONST_CASTSPELL_MORDENKAINENS_DISJUNCTION_17; iLevel=17;sName ="Mordenkainen's Disjunction";break;
     case 186 : nProperty = IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_18; iLevel=18;sName ="Mordenkainen's Sword";break;
     case 187 : nProperty = IP_CONST_CASTSPELL_NATURES_BALANCE_15; iLevel=15;sName ="Nature's Balance";break;
     case 188 : nProperty = IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_10; iLevel=10;sName ="Negative Energy Burst";break;
     case 189 : nProperty = IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_15; iLevel=15;sName ="Negative Energy Protection";break;
     case 190 : nProperty = IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_9; iLevel=9;sName ="Negative Energy Ray";break;
     case 191 : nProperty = IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5; iLevel=5;sName ="Neutralyze Poison";break;
     case 192 : nProperty = IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7; iLevel=7;sName ="One With the Land";break;
     case 193 : nProperty = IP_CONST_CASTSPELL_OWLS_INSIGHT_15;iLevel=15;sName ="Owl's Insight"; break;
     case 194 : nProperty = IP_CONST_CASTSPELL_PHANTASMAL_KILLER_7; iLevel=7;sName ="Phantasmal Killer";break;
     case 195 : nProperty = IP_CONST_CASTSPELL_PLANAR_BINDING_11; iLevel=11;sName ="Planar Binding";break;
     case 196 : nProperty = IP_CONST_CASTSPELL_PLANAR_ALLY_15; iLevel=15;sName ="Planar Ally";break;
     case 197 : nProperty = IP_CONST_CASTSPELL_PLANAR_BINDING_11; iLevel=11;sName ="Planar Binding";break;
     case 198 : nProperty = IP_CONST_CASTSPELL_POISON_5; iLevel=5;sName ="Poison";break;
     case 199 : nProperty = IP_CONST_CASTSPELL_POLYMORPH_SELF_7; iLevel=7;sName ="Polymorph Self";break;
     case 200 : nProperty = IP_CONST_CASTSPELL_POWER_WORD_KILL_17; iLevel=17;sName ="Power Word Kill";break;
     case 201 : nProperty = IP_CONST_CASTSPELL_POWER_WORD_STUN_13; iLevel=13;sName ="Power Word Stun";break;
     case 202 : nProperty = IP_CONST_CASTSPELL_PRAYER_5; iLevel=5;sName ="Prayer";break;
     case 203 : nProperty = IP_CONST_CASTSPELL_PREMONITION_15; iLevel=15;sName ="Premonition";break;
     case 204 : nProperty = IP_CONST_CASTSPELL_PRISMATIC_SPRAY_13; iLevel=13;sName ="Prismatic Spray";break;
     case 205 : nProperty = IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_2; iLevel=2;sName ="Protection from Alignment";break;
     case 206 : nProperty = IP_CONST_CASTSPELL_QUILLFIRE_8; iLevel=8;sName ="Quillfire";break;
     case 207 : nProperty = IP_CONST_CASTSPELL_RAISE_DEAD_9; iLevel=9;sName ="Raise Dead";break;
     case 208 : nProperty = IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2;iLevel=2;sName = "Ray of Enfeeblement";break;
     case 209 : nProperty = IP_CONST_CASTSPELL_RAY_OF_FROST_1;iLevel=1;sName ="Ray of Frost"; break;
     case 210 : nProperty = IP_CONST_CASTSPELL_REGENERATE_13;iLevel=13;sName ="Regenerate";break;
     case 211 : nProperty = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5; iLevel=5;sName ="Remove Blindness Deafness";break;
     case 212 : nProperty = IP_CONST_CASTSPELL_REMOVE_CURSE_5;iLevel=5;sName ="Remove Curse"; break;
     case 213 : nProperty = IP_CONST_CASTSPELL_REMOVE_DISEASE_5; iLevel=5;sName ="Remove Disease";break;
     case 214 : nProperty = IP_CONST_CASTSPELL_REMOVE_FEAR_2; iLevel=2;sName ="Remove Fear";break;
     case 215 : nProperty = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3; iLevel=3;sName ="Remove Paralysis";break;
     case 216 : nProperty = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10; iLevel=10;sName ="Resist Elements";break;
     case 217 : nProperty = IP_CONST_CASTSPELL_RESISTANCE_2; iLevel=2;sName ="Resistance";break;
     case 218 : nProperty = IP_CONST_CASTSPELL_RESURRECTION_13;iLevel=13;sName ="Resurrection"; break;
     case 219 : nProperty = IP_CONST_CASTSPELL_ROGUES_CUNNING_3; iLevel=3;sName ="Rogue's Cunning";break;
     case 220 : nProperty = IP_CONST_CASTSPELL_SANCTUARY_2;iLevel=2;sName ="Sanctuary"; break;
     case 221 : nProperty = IP_CONST_CASTSPELL_SCARE_2; iLevel=2;sName ="Scare";break;
     case 222 : nProperty = IP_CONST_CASTSPELL_SEARING_LIGHT_5; iLevel=5;sName ="Searing Light";break;
     case 223 : nProperty = IP_CONST_CASTSPELL_SEE_INVISIBILITY_3; iLevel=3;sName ="See Invisibility";break;
     case 224 : nProperty = IP_CONST_CASTSPELL_SHADES_11; iLevel=11;sName ="Shades";break;
     case 225 : nProperty = IP_CONST_CASTSPELL_SHADOW_CONJURATION_7; iLevel=7;sName ="Shadow Conjuration";break;
     case 226 : nProperty = IP_CONST_CASTSPELL_SHADOW_SHIELD_13; iLevel=13;sName ="Shadow Shield";break;
     case 227 : nProperty = IP_CONST_CASTSPELL_SHAPECHANGE_17; iLevel=17;sName ="Shapechange"; break;
     case 228 : nProperty = IP_CONST_CASTSPELL_SHIELD_5; iLevel=5;sName ="Shield";break;
     case 229 : nProperty = IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5; iLevel=5;sName ="Shield of Faith";break;
     case 230 : nProperty = IP_CONST_CASTSPELL_SILENCE_3; iLevel=3;sName ="Silence";break;
     case 231 : nProperty = IP_CONST_CASTSPELL_SLAY_LIVING_9; iLevel=9;sName ="Slay Living";break;
     case 232 : nProperty = IP_CONST_CASTSPELL_SLEEP_5; iLevel=5;sName ="Sleep";break;
     case 233 : nProperty = IP_CONST_CASTSPELL_SLOW_5; iLevel=5;sName ="Slow";break;
     case 234 : nProperty = IP_CONST_CASTSPELL_SOUND_BURST_3; iLevel=3;sName ="Sound Burst";break;
     case 235 : nProperty = IP_CONST_CASTSPELL_SOUND_BURST_3; iLevel=3;sName ="Sound Burst";break;
     case 236 : nProperty = IP_CONST_CASTSPELL_SILENCE_3; iLevel=3;sName ="Silence";break;
     case 237 : nProperty = IP_CONST_CASTSPELL_SPELL_MANTLE_13; iLevel=13;sName ="Spell Mantle";break;
     case 238 : nProperty = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15; iLevel=15;sName ="Spell Resistance";break;
     case 239 : nProperty = IP_CONST_CASTSPELL_SPIKE_GROWTH_9; iLevel=9;sName ="Spike Growth";break;
     case 240 : nProperty = IP_CONST_CASTSPELL_STINKING_CLOUD_5; iLevel=5;sName ="Stinking Cloud";break;
     case 241 : nProperty = IP_CONST_CASTSPELL_STONE_TO_FLESH_5; iLevel=5;sName ="Stone To Flesh";break;
     case 242 : nProperty = IP_CONST_CASTSPELL_STONESKIN_7; iLevel=7;sName ="Stone Skin";break;
     case 243 : nProperty = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;iLevel=17; sName ="Storm of Vengeance";break;
     case 244 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2; iLevel=2;sName ="Summon Creature I";break;
     case 245 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3;iLevel=3;sName ="Summon Creature II";break;
     case 246 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5;iLevel=5; sName ="Summon Creature III";break;
     case 247 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_IV_7; iLevel=7;sName ="Summon Creature IV";break;
     case 248 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17; iLevel=17;sName ="Summon Creature IX";break;
     case 249 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_V_9; iLevel=9;sName ="Summon Creature V";break;
     case 250 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13; iLevel=13;sName ="Summon Creature VII";break;
     case 251 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11; iLevel=11;sName ="Summon Creature VI";break;
     case 252 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13; iLevel=13;sName ="Summon Creature VII";break;
     case 253 : nProperty = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15; iLevel=15;sName ="Summon Creature VIII";break;
     case 254 : nProperty = IP_CONST_CASTSPELL_SUNBEAM_13; iLevel=13;sName ="Sunbeam";break;
     case 255 : nProperty = IP_CONST_CASTSPELL_SUNBURST_20; iLevel=20;sName ="Sunburst";break;
     case 256 : nProperty = IP_CONST_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER_7; iLevel=7;sName ="Tasha's Hideous Laughter";break;
     case 257 : nProperty = IP_CONST_CASTSPELL_TENSERS_TRANSFORMATION_11; iLevel=11;sName ="Tenser's Transformation";break;
     case 258 : nProperty = IP_CONST_CASTSPELL_TIME_STOP_17; iLevel=17;sName ="Time Stop";break;
     case 259 : nProperty = IP_CONST_CASTSPELL_TRUE_SEEING_9; iLevel=9;sName ="True Seeing";break;
     case 260 : nProperty = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20; iLevel=20;sName ="Undeath's Eternal Foe";break;
     case 261 : nProperty = IP_CONST_CASTSPELL_TRUE_STRIKE_5; iLevel=5;sName ="True Strike";break;
     case 262 : nProperty = IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5;iLevel=5;sName ="Vampiric Touch"; break;
     case 263 : nProperty = IP_CONST_CASTSPELL_VIRTUE_1; iLevel=1;sName ="Virtue";break;
     case 264 : nProperty = IP_CONST_CASTSPELL_WAIL_OF_THE_BANSHEE_17;iLevel=17; sName ="Wail of the Banshee";break;
     case 265 : nProperty = IP_CONST_CASTSPELL_WALL_OF_FIRE_9; iLevel=9;sName ="Wall of Fire";break;
     case 266 : nProperty = IP_CONST_CASTSPELL_WAR_CRY_7; iLevel=7;sName ="War Cry";break;
     case 267 : nProperty = IP_CONST_CASTSPELL_WEB_3; iLevel=3;sName ="Web";break;
     case 268 : nProperty = IP_CONST_CASTSPELL_WEIRD_17; iLevel=17;sName ="Weird";break;
     case 269 : nProperty = IP_CONST_CASTSPELL_WORD_OF_FAITH_13; iLevel=13;sName ="Word of Faith";break;
     case 270 : nProperty = IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9; iLevel=9;sName ="Wounding Whispers";break;
   }
if (iLevel>iHD) return;
itemproperty nBoost = ItemPropertyCastSpell(nProperty,iUses);
AddItemProperty(DURATION_TYPE_PERMANENT,nBoost,OBJECT_SELF);
string sOName = GetName(OBJECT_SELF);
if (GetLocalInt(OBJECT_SELF,"dontrename")!=1) SetName(OBJECT_SELF,sOName+" of "+sName);
}
