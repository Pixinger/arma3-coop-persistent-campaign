removeAllAssignedItems _this;
removeAllPrimaryWeaponItems _this;
removeAllHandgunItems _this;
removeAllWeapons _this; 
removeBackpack _this;
removeHeadgear _this;
removeVest _this;
removeUniform _this;
removeGoggles _this;

//addPrimaryWeaponItem
//player linkItem "Laserdesignator"; 
_this addHeadgear "H_MilCap_dgtl";
_this addGoggles "G_Sport_Greenblack";/*G_Sport_Red / G_Sport_BlackWhite / G_Shades_Black / G_Combat /  G_Tactical_Clear / ["Taucher", ["G_Diving","","U_B_Wetsuit","V_RebreatherB","keep"]]

/*Uniform*/
_this addUniform "U_I_CombatUniform";
(uniform _this) addItemCargoGlobal "FirstAidKit";
/*
_this addItem "FirstAidKit";
_this addMagazine "SmokeShell";
_this addMagazine "SmokeShell";
_this addMagazine "HandGrenade";
_this addMagazine "HandGrenade";
*/

/*Weste & Waffen*/
_this addVest "V_PlateCarrierIA2_dgtl";
(vest _this) addMagazineCargoGlobal "30Rnd_65x39_caseless_mag";
/*_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addWeapon "arifle_MX_GL_Hamr_pointer_F";
_this addPrimaryWeaponItem "optic_Arco";
_this addMagazine "11Rnd_45ACP_Mag";
_this addWeapon "hgun_Pistol_heavy_01_MRD_F";
_this addHandgunItem "muzzle_snds_acp";
_this addMagazine "Laserbatteries";
_this addWeapon "Laserdesignator";
_this addItem "muzzle_snds_H";
_this addMagazine "30Rnd_65x39_caseless_mag";
/*_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag";
_this addMagazine "30Rnd_65x39_caseless_mag_Tracer";
_this addMagazine "30Rnd_65x39_caseless_mag_Tracer";
_this addMagazine "30Rnd_65x39_caseless_mag_Tracer";
_this addMagazine "30Rnd_65x39_caseless_mag_Tracer";
_this addMagazine "30Rnd_65x39_caseless_mag_Tracer";*/

/*Rucksack & Werfer*/
_this addBackpack "B_AssaultPack_rgr";
(unitbackpack _this) addItemCargoGlobal "optic_Nightstalker";
(unitbackpack _this) addMagazineCargoGlobal "1Rnd_HE_Grenade_shell";
//_this addItem "optic_Nightstalker";
/*_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";*/
/*_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addMagazine "1Rnd_Smoke_Grenade_shell";
_this addMagazine "1Rnd_Smoke_Grenade_shell";
_this addMagazine "1Rnd_Smoke_Grenade_shell";
_this addMagazine "1Rnd_Smoke_Grenade_shell";
_this addMagazine "1Rnd_SmokePurple_Grenade_shell";
_this addMagazine "1Rnd_SmokePurple_Grenade_shell";
_this addMagazine "1Rnd_HE_Grenade_shell";
_this addItem "NVGoggles_INDEP";
//_this addItem "ItemGPS";
//_this assignItem "ItemGPS";
_this addItem "H_HelmetIA";*/
_this addItem "B_UavTerminal";
_this assignItem "B_UavTerminal";
