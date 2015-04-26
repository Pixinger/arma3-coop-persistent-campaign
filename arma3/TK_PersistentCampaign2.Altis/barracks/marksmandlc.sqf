if (isServer) then
{
	private["_box"];
	_box = _this select 0;
	
	clearWeaponCargoGlobal _box; 
	clearMagazineCargoGlobal _box; 
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	
	_box addWeaponCargoGlobal ["srifle_DMR_02_F", 1];
	_box addWeaponCargoGlobal ["srifle_DMR_03_F", 1];
	_box addWeaponCargoGlobal ["srifle_DMR_04_F", 1];
	_box addWeaponCargoGlobal ["srifle_DMR_05_hex_F", 1];

	_box addMagazineCargoGlobal ["10Rnd_338_Mag", 3];
	_box addMagazineCargoGlobal ["10Rnd_127x54_Mag", 3];
	_box addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 3];
	_box addMagazineCargoGlobal ["20Rnd_762x51_Mag", 3];

	_box addWeaponCargoGlobal ["MMG_01_hex_F", 1];
	_box addMagazineCargoGlobal ["150Rnd_93x64_Mag", 1];
	_box addWeaponCargoGlobal ["MMG_02_camo_F", 1];
	_box addMagazineCargoGlobal ["130Rnd_338_Mag", 1];

	_box addItemCargoGlobal ["bipod_01_F_blk", 1];
	_box addItemCargoGlobal ["bipod_02_F_blk", 1];
	_box addItemCargoGlobal ["bipod_03_F_blk", 1];
	_box addItemCargoGlobal ["optic_AMS", 1];
	_box addItemCargoGlobal ["optic_KHS_blk", 1];
	_box addItemCargoGlobal ["muzzle_snds_338_black", 1];
	_box addItemCargoGlobal ["muzzle_snds_93mmg", 1];
	
	
	

};


/*
optic_AMS
optic_AMS_base
optic_AMS_khk
optic_AMS_snd
optic_KHS_base
optic_KHS_blk
optic_KHS_hex
optic_KHS_old
optic_KHS_tan
 
muzzle_snds_338_black
muzzle_snds_338_green
muzzle_snds_338_sand
muzzle_snds_93mmg
muzzle_snds_93mmg_tan
 
bipod_01_F_blk
bipod_01_F_mtp
bipod_01_F_snd
bipod_02_F_blk
bipod_02_F_hex
bipod_02_F_tan
bipod_03_F_blk
bipod_03_F_oli
 
"New Clothing"
U_B_FullGhillie_ard
U_B_FullGhillie_lsh
U_B_FullGhillie_sard

.338 Norma Magnum - Medium Maschin Gun

MMG_01_base_F
MMG_01_hex_ACRO_LP_F
MMG_01_hex_F
MMG_01_tan_F

MMG_02_base_F
MMG_02_black_F
MMG_02_camo_F
MMG_02_sand_F
MMG_02_sand_RCO_LP_F

Ammo:

150Rnd_93x64_Mag

______________________________________

MAR-10 .338

srifle_DMR_02_ACO_F
srifle_DMR_02_ARCO_F
srifle_DMR_02_camo_AMS_LP_F
srifle_DMR_02_camo_F
srifle_DMR_02_DMS_F
srifle_DMR_02_F
srifle_DMR_02_MRCO_F
srifle_DMR_02_sniper_AMS_LP_S_F
srifle_DMR_02_sniper_F
srifle_DMR_02_SOS_F

Ammo:

10Rnd_338_Mag

______________________________________

Mk-I EMR 7.62 mm

srifle_DMR_03_ACO_F
srifle_DMR_03_ARCO_F
srifle_DMR_03_DMS_F
srifle_DMR_03_DMS_snds_F
srifle_DMR_03_F
srifle_DMR_03_khaki_F
srifle_DMR_03_MRCO_F
srifle_DMR_03_multicam_F
srifle_DMR_03_SOS_F
srifle_DMR_03_spotter_F
srifle_DMR_03_tan_AMS_LP_F
srifle_DMR_03_tan_F
srifle_DMR_03_woodland_F

Ammo:

20Rnd_762x51_Mag

______________________________________

ASP-1 Kir 12.7 mm

srifle_DMR_04_ACO_F
srifle_DMR_04_ARCO_F
srifle_DMR_04_DMS_F
srifle_DMR_04_F
srifle_DMR_04_MRCO_F
srifle_DMR_04_NS_LP_F
srifle_DMR_04_SOS_F
srifle_DMR_04_Tan_F

Ammo:

10Rnd_127x54_Mag

______________________________________

Cyrus 9.3 mm

srifle_DMR_05_ACO_F
srifle_DMR_05_ARCO_F
srifle_DMR_05_blk_F
srifle_DMR_05_DMS_F
srifle_DMR_05_DMS_snds_F
srifle_DMR_05_hex_F
srifle_DMR_05_KHS_LP_F
srifle_DMR_05_MRCO_F
srifle_DMR_05_SOS_F
srifle_DMR_05_tan_F

Ammo:

10Rnd_93x64_DMR_05_Mag

______________________________________


Mk 14 7.62 mm

srifle_DMR_06_camo_F
srifle_DMR_06_camo_khs_F
srifle_DMR_06_olive_F

Ammo:

20Rnd_762x51_Mag
*/