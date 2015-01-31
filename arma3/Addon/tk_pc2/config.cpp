

class CfgPatches
{
	class PC2_Pack
	{
		units[] = {				
			"PC2_O_G_Offroad_01_armed_F",
			"PC2_O_G_Offroad_01_F",
			"PC2_O_G_Quadbike_01_F",
			"PC2_O_G_Van_01_transport_F",
			"PC2_O_G_Van_01_fuel_F",
			"PC2_O_G_Boat_Civil_01_F",
			"PC2_O_G_Boat_Transport_01_F",
			"PC2_O_G_Lifeboat",
			"PC2_O_G_Mortar_01_F",
			"PC2_O_G_static_AA_F",
			"PC2_O_G_static_AT_F",
			"PC2_O_G_engineer_F",
			"PC2_O_G_medic_F",
			"PC2_O_G_officer_F",
			"PC2_O_G_Story_Colonel_F",
			"PC2_O_G_Soldier_A_F",
			"PC2_O_G_Soldier_AR_F",
			"PC2_O_G_Soldier_exp_F",
			"PC2_O_G_Soldier_F",
			"PC2_O_G_Soldier_GL_F",
			"PC2_O_G_Soldier_LAT_F",
			"PC2_O_G_Soldier_AT_F",
			"PC2_O_G_Soldier_AA_F",
			"PC2_O_G_Soldier_lite_F",
			"PC2_O_G_Soldier_M_F",
			"PC2_O_G_Soldier_SL_F",
			"PC2_O_G_Soldier_TL_F"
		};
	};
};
class CfgFactionClasses
{
	class PC2_O_FIA
	{
		displayName = "FIA (OPFOR)";
		priority = 1;
		side = 0;
		flag = "\a3\Data_f\Flags\flag_FIA_co.paa";
		icon = "\a3\Data_f\cfgFactionClasses_IND_G_ca.paa";		
	};	
};	

class CfgVehicleClasses
{	
	class PC2_Man
	{
		displayName = "PC2_Man";
	};		
};

class CfgVehicles
{	
	// Car
	class B_G_Offroad_01_armed_F;
	class B_G_Offroad_01_F;
	class B_G_Quadbike_01_F;
	class B_G_Van_01_transport_F;
	class PC2_O_G_Offroad_01_armed_F: B_G_Offroad_01_armed_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Car";
		faction = "PC2_O_FIA";
	};
	class PC2_O_G_Offroad_01_F: B_G_Offroad_01_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Car";
		faction = "PC2_O_FIA";
	};
	class PC2_O_G_Quadbike_01_F: B_G_Quadbike_01_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Car";
		faction = "PC2_O_FIA";
	};
	class PC2_O_G_Van_01_transport_F: B_G_Van_01_transport_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Car";
		faction = "PC2_O_FIA";
	};

	// Support
	class B_G_Van_01_fuel_F;
	class PC2_O_G_Van_01_fuel_F: B_G_Van_01_fuel_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Support";
		faction = "PC2_O_FIA";
	};

	// Ship
	class C_Boat_Civil_01_F;
	class O_Boat_Transport_01_F;
	class O_Lifeboat;
	class PC2_O_G_Boat_Civil_01_F: C_Boat_Civil_01_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Ship";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};	
	class PC2_O_G_Boat_Transport_01_F: O_Boat_Transport_01_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Ship";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};	
	class PC2_O_G_Lifeboat: O_Lifeboat 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Ship";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};	
	
	// Static
	class B_G_Mortar_01_F;
	class O_static_AA_F;
	class O_static_AT_F;
	class PC2_O_G_Mortar_01_F: B_G_Mortar_01_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Static";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};	
	class PC2_O_G_static_AA_F: O_static_AA_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Static";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};	
	class PC2_O_G_static_AT_F: O_static_AT_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Static";
		faction = "PC2_O_FIA";
		crew = "PC2_O_G_Soldier_F";
	};		
	
	// Men
	class SoldierEB;
	class PC2_O_G_Soldier_base_F: SoldierEB {
		_generalmacro = "PC2_O_G_Soldier_base_F";
		accuracy = 3.9;
		author = "Pixinger";
		camouflage = 1.1;
		cancarrybackpack = 1;
		cost = 100000;
		expansion = 1;
		facetype = "Man_A3";
		faction = "PC2_O_FIA";
		genericnames = "GreekMen";
		hiddenselections[] = {"Camo"};
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla2_1_co.paa"};
		icon = "iconMan";
		identitytypes[] = {"LanguageGRE_F", "Head_Greek", "G_GUERIL_default"};
		items[] = {"FirstAidKit"};
		linkeditems[] = {"V_Chestrig_oli", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		minfiretime = 10;
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla1_1.p3d";
		modelsides[] = {0, 1, 2, 3};
		nakeduniform = "U_BasicBody";
		picture = "";
		portrait = "";
		respawnitems[] = {"FirstAidKit"};
		respawnlinkeditems[] = {"V_Chestrig_oli", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG21_F", "Throw", "Put"};
		scope = 0;
		sensitivity = 2;
		side = 0;
		threat[] = {1, 0.1, 0.1};
		uniformclass = "U_OG_Guerilla1_1";
		vehicleclass = "Men";
		weapons[] = {"arifle_TRG21_F", "Throw", "Put"};
		class Wounds {
			mat[] = {"A3\Characters_F\Civil\Data\c_cloth1.rvmat", "A3\Characters_F\Civil\Data\c_cloth1_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth1_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth2.rvmat", "A3\Characters_F\Civil\Data\c_cloth2_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth2_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth3.rvmat", "A3\Characters_F\Civil\Data\c_cloth3_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth3_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth4.rvmat", "A3\Characters_F\Civil\Data\c_cloth4_injury.rvmat", "A3\Characters_F\Civil\Data\c_cloth4_injury.rvmat", "A3\characters_f\civil\data\c_poloshirt.rvmat", "A3\Characters_F\Civil\Data\c_poloshirt_injury.rvmat", "A3\Characters_F\Civil\Data\c_poloshirt_injury.rvmat", "A3\characters_f\common\data\coveralls.rvmat", "A3\Characters_F\Common\Data\coveralls_injury.rvmat", "A3\Characters_F\Common\Data\coveralls_injury.rvmat", "A3\Characters_F\Civil\Data\hunter.rvmat", "A3\Characters_F\Civil\Data\hunter_injury.rvmat", "A3\Characters_F\Civil\Data\hunter_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_bald_muscular.rvmat", "A3\Characters_F\Heads\Data\hl_white_bald_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_bald_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_black_bald_muscular.rvmat", "A3\Characters_F\Heads\Data\hl_black_bald_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_black_bald_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_hairy_muscular.rvmat", "A3\Characters_F\Heads\Data\hl_white_hairy_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_hairy_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_old.rvmat", "A3\Characters_F\Heads\Data\hl_white_old_injury.rvmat", "A3\Characters_F\Heads\Data\hl_white_old_injury.rvmat", "A3\Characters_F\Heads\Data\hl_asian_bald_muscular.rvmat", "A3\Characters_F\Heads\Data\hl_asian_bald_muscular_injury.rvmat", "A3\Characters_F\Heads\Data\hl_asian_bald_muscular_injury.rvmat"};
			tex[] = {};
		};
	};	
	class B_G_engineer_F;
	class B_G_medic_F;
	class B_G_officer_F;
	class I_Story_Colonel_F;
	class B_G_Soldier_A_F;
	class B_G_Soldier_AR_F;
	class B_G_Soldier_exp_F;
	class B_G_Soldier_F;
	class B_G_Soldier_GL_F;
	class B_G_Soldier_LAT_F;
	class B_G_Soldier_lite_F;
	class B_G_Soldier_M_F;
	class B_G_Soldier_SL_F;
	class B_G_Soldier_TL_F;	
	class PC2_O_G_engineer_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_engineer_F";
		author = "Pixinger";
		scope = 2;
		faction = "PC2_O_FIA";
		backpack = "G_TacticalPack_Eng";
		candeactivatemines = 1;
		cost = 220000;
		detectskill = 70;
		displayname = "Engineer";
		engineer = 1;
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla2_2_co.paa"};
		icon = "iconManEngineer";
		linkeditems[] = {"V_Chestrig_blk", "H_Watchcap_camo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla2_1.p3d";
		picture = "pictureRepair";
		respawnlinkeditems[] = {"V_Chestrig_blk", "H_Watchcap_camo", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG20_ACO_F", "Throw", "Put"};
		uniformclass = "U_OG_Guerilla2_2";
		weapons[] = {"arifle_TRG20_ACO_F", "Throw", "Put"};
	};
	class PC2_O_G_medic_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_medic_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla2_3";		
		attendant = 1;
		backpack = "G_FieldPack_Medic";
		cost = 300000;
		displayname = "Combat Life Saver";
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla2_3_co.paa"};
		icon = "iconManMedic";
		linkeditems[] = {"V_TacVest_blk", "H_Cap_oli", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla2_1.p3d";
		namesound = "veh_infantry_medic_s";
		picture = "pictureHeal";
		respawnlinkeditems[] = {"V_TacVest_blk", "H_Cap_oli", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_Mk20_F", "hgun_ACPC2_F", "Throw", "Put"};
		textplural = "medics";
		textsingular = "medic";
		weapons[] = {"arifle_Mk20_F", "hgun_ACPC2_F", "Throw", "Put"};
		class SpeechVariants {
			class Default {
				speechplural[] = {"veh_infantry_medic_p"};
				speechsingular[] = {"veh_infantry_medic_s"};
			};
		};		
	};
	class PC2_O_G_officer_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_officer_F";
		author = "Pixinger";
		scope = 2;
		camouflage = 1.6;
		cost = 600000;
		displayname = "Officer";
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla2_3_co.paa"};
		icon = "iconManOfficer";
		linkeditems[] = {"V_Chestrig_oli", "H_Watchcap_blk", "ItemGPS", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		respawnlinkeditems[] = {"V_Chestrig_oli", "H_Watchcap_blk", "ItemGPS", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG21_MRCO_F", "hgun_ACPC2_F", "Throw", "Put"};
		sensitivity = 3;
		weapons[] = {"arifle_TRG21_MRCO_F", "hgun_ACPC2_F", "Throw", "Put"};
		class Wounds {
			mat[] = {"A3\Characters_F_Beta\INDEP\Data\officer.rvmat", "A3\Characters_F_Beta\INDEP\Data\officer_injury.rvmat", "A3\Characters_F_Beta\INDEP\Data\officer_injury.rvmat"};
			tex[] = {};
		};		
		uniformclass = "U_OG_Guerilla2_3";		
	};
	class PC2_O_G_Story_Colonel_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Story_Colonel_F";		
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_O_OfficerUniform_ocamo";
		displayname = "General";
		magazines[] = {"Chemlight_red"};
		respawnMagazines[] = {"Chemlight_red"};
		weapons[] = {"Throw","Put"};
		respawnWeapons[] = {"Throw","Put"};
		linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio"};
		respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio"};
		Items[] = {"FirstAidKit"};
		RespawnItems[] = {"FirstAidKit"};
		facetype = "O_Colonel";
		identitytypes[] = {"O_Colonel"};
	};		
	class PC2_O_G_Soldier_A_F: PC2_O_G_Soldier_base_F 
	{
		author = "Pixinger";
		scope = 2;
		backpack = "G_Carryall_Ammo";
		cost = 50000;
		displayname = "Ammo Bearer";
		linkeditems[] = {"V_Chestrig_oli", "H_Booniehat_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnlinkeditems[] = {"V_Chestrig_oli", "H_Booniehat_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG20_F", "Throw", "Put"};
		weapons[] = {"arifle_TRG20_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_AR_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_AR_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla2_1";
		magazines[] = {"200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box", "HandGrenade", "MiniGrenade", "SmokeShell"};
		respawnmagazines[] = {"200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box", "HandGrenade", "MiniGrenade", "SmokeShell"};
		cost = 40000;
		displayname = "Autorifleman";
		icon = "iconManMG";
		linkeditems[] = {"V_TacVest_blk", "H_Bandanna_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla2_1.p3d";
		namesound = "veh_infantry_MG_s";
		respawnlinkeditems[] = {"V_TacVest_blk", "H_Bandanna_khk", "D efaultManGuerillaLinkedItems"};
		respawnweapons[] = {"LMG_Mk200_F", "Throw", "Put"};
		textplural = "machinegunners";
		textsingular = "machinegunner";
		weapons[] = {"LMG_Mk200_F", "Throw", "Put"};
		class SpeechVariants {
			class Default {
				speechplural[] = {"veh_infantry_MG_p"};
				speechsingular[] = {"veh_infantry_MG_s"};
			};
		};		
	};
	class PC2_O_G_Soldier_exp_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_exp_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla2_1";
		backpack = "G_Carryall_Exp";
		camouflage = 1.6;
		candeactivatemines = 1;
		cost = 115000;
		detectskill = 80;
		displayname = "Explosive Specialist";
		icon = "iconManExplosive";
		linkeditems[] = {"V_Chestrig_blk", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "APERSMine_Range_Mag", "APERSMine_Range_Mag", "APERSMine_Range_Mag", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla2_1.p3d";
		picture = "pictureExplosive";
		respawnlinkeditems[] = {"V_Chestrig_blk", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "APERSMine_Range_Mag", "APERSMine_Range_Mag", "APERSMine_Range_Mag", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_Mk20C_ACO_F", "Throw", "Put"};
		sensitivity = 2.8;
		threat[] = {1, 0.5, 0.1};
		weapons[] = {"arifle_Mk20C_ACO_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla1_1";
	};
	class PC2_O_G_Soldier_GL_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_GL_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla2_3";
		cost = 130000;
		displayname = "Grenadier";
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla2_3_co.paa"};
		linkeditems[] = {"V_Chestrig_blk", "H_Bandanna_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "HandGrenade", "MiniGrenade", "MiniGrenade", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue", "1Rnd_Smoke_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla2_1.p3d";
		respawnlinkeditems[] = {"V_Chestrig_blk", "H_Bandanna_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "HandGrenade", "MiniGrenade", "MiniGrenade", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue", "1Rnd_Smoke_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell"};
		respawnweapons[] = {"arifle_TRG21_GL_F", "Throw", "Put"};
		weapons[] = {"arifle_TRG21_GL_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_LAT_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_LAT_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla3_2";
		backpack = "G_FieldPack_LAT";
		weapons[] = {"arifle_TRG21_F", "launch_RPG32_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "RPG32_F"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "RPG32_F"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_RPG32_F", "Throw", "Put"};
		displayname = "Rifleman (AT)";
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla3_2_co.paa"};
		icon = "iconManAT";
		linkeditems[] = {"V_TacVest_blk", "H_Bandanna_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla3_1.p3d";
		namesound = "veh_infantry_AT_s";
		respawnlinkeditems[] = {"V_TacVest_blk", "H_Bandanna_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		textplural = "AT soldiers";
		textsingular = "AT soldier";
		class SpeechVariants {
			class Default {
				speechplural[] = {"veh_infantry_AT_p"};
				speechsingular[] = {"veh_infantry_AT_s"};
			};
		};		
	};
	class PC2_O_G_Soldier_AT_F: PC2_O_G_Soldier_LAT_F 
	{
		_generalmacro = "PC2_O_G_Soldier_AT_F";
		author = "Pixinger";
		uniformclass = "U_OG_Guerilla3_2";
		displayname = "Missile Specialist (AT)";
		backpack = "B_FieldPack_cbr_AT";
		weapons[] = {"arifle_TRG21_F", "launch_O_Titan_short_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_O_Titan_short_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_AA_F: PC2_O_G_Soldier_LAT_F 
	{
		_generalmacro = "PC2_O_G_Soldier_AA_F";
		author = "Pixinger";
		uniformclass = "U_OG_Guerilla3_2";
		displayname = "Missile Specialist (AA)";
		backpack = "B_FieldPack_ocamo_AA";
		weapons[] = {"arifle_TRG21_F", "launch_B_Titan_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_B_Titan_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_lite_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_lite_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla1_1";
		camouflage = 1.2;
		cost = 90000;
		displayname = "Rifleman (Light)";
		linkeditems[] = {"V_BandollierB_blk", "H_Cap_oli", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnlinkeditems[] = {"V_BandollierB_blk", "H_Cap_oli", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG20_F", "Throw", "Put"};
		weapons[] = {"arifle_TRG20_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_M_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_M_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_Guerilla3_1";		
		cost = 150000;
		displayname = "Marksman";
		hiddenselectionstextures[] = {"\A3\Characters_F_Gamma\Guerrilla\Data\ig_guerrilla3_1_co.paa"};
		linkeditems[] = {"V_BandollierB_khk", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_guerrilla3_1.p3d";
		respawnlinkeditems[] = {"V_BandollierB_khk", "H_Shemag_olive", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_Mk20_MRCO_F", "Throw", "Put"};
		weapons[] = {"arifle_Mk20_MRCO_F", "Throw", "Put"};		
	};
	class PC2_O_G_Soldier_SL_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_SL_F";
		author = "Pixinger";
		scope = 2;
		uniformclass = "U_OG_leader";		
		camouflage = 1.6;
		cost = 500000;
		displayname = "Squad Leader";
		icon = "iconManLeader";
		linkeditems[] = {"V_Chestrig_blk", "H_Watchcap_blk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Yellow", "30Rnd_556x45_Stanag_Tracer_Yellow", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_leader.p3d";
		respawnlinkeditems[] = {"V_Chestrig_blk", "H_Watchcap_blk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Yellow", "30Rnd_556x45_Stanag_Tracer_Yellow", "9Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "HandGrenade", "MiniGrenade", "SmokeShell", "SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "Chemlight_blue", "Chemlight_blue"};
		respawnweapons[] = {"arifle_TRG20_ACO_F", "hgun_ACPC2_F", "Throw", "Put", "Binocular"};
		sensitivity = 3.2;
		weapons[] = {"arifle_TRG20_ACO_F", "hgun_ACPC2_F", "Throw", "Put", "Binocular"};		
	};
	class PC2_O_G_Soldier_TL_F: PC2_O_G_Soldier_base_F 
	{
		_generalmacro = "PC2_O_G_Soldier_TL_F";

		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_leader";		
		linkeditems[] = {"V_TacVest_blk", "H_Booniehat_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Yellow", "30Rnd_556x45_Stanag_Tracer_Yellow", "9Rnd_45ACP_Mag", "HandGrenade", "MiniGrenade", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue", "1Rnd_Smoke_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell"};
		model = "\A3\characters_F_gamma\Guerrilla\ig_leader.p3d";
		respawnlinkeditems[] = {"V_TacVest_blk", "H_Booniehat_khk", "ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Yellow", "30Rnd_556x45_Stanag_Tracer_Yellow", "9Rnd_45ACP_Mag", "HandGrenade", "MiniGrenade", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "1Rnd_HE_Grenade_shell", "SmokeShell", "SmokeShellGreen", "Chemlight_blue", "Chemlight_blue", "1Rnd_Smoke_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell"};
		respawnweapons[] = {"arifle_Mk20_GL_ACO_F", "hgun_ACPC2_F", "Throw", "Put"};
		weapons[] = {"arifle_Mk20_GL_ACO_F", "hgun_ACPC2_F", "Throw", "Put"};		
		cost = 450000;
		displayname = "Team Leader";
		icon = "iconManLeader";
		sensitivity = 3.2;
		threat[] = {1, 0.3, 0.1};
	};
};
