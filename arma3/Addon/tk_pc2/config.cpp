

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
	class PC2_O_G_engineer_F: B_G_engineer_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_2";
	};
	class PC2_O_G_medic_F: B_G_medic_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_3";
	};
	class PC2_O_G_officer_F: B_G_officer_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_3";		
	};
	class PC2_O_G_Story_Colonel_F: I_Story_Colonel_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_O_OfficerUniform_ocamo";
		displayname = "General";
	};	
	class PC2_O_G_Soldier_A_F: B_G_Soldier_A_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla1_1";
	};
	class PC2_O_G_Soldier_AR_F: B_G_Soldier_AR_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_1";
		magazines[] = {"200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box", "HandGrenade", "MiniGrenade", "SmokeShell"};
		respawnmagazines[] = {"200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box", "HandGrenade", "MiniGrenade", "SmokeShell"};
		
	};
	class PC2_O_G_Soldier_exp_F: B_G_Soldier_exp_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_1";
	};
	class PC2_O_G_Soldier_F: B_G_Soldier_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla1_1";
	};
	class PC2_O_G_Soldier_GL_F: B_G_Soldier_GL_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla2_3";
	};
	class PC2_O_G_Soldier_LAT_F: B_G_Soldier_LAT_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla3_2";
		backpack = "G_FieldPack_LAT";
		weapons[] = {"arifle_TRG21_F", "launch_RPG32_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "RPG32_F"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "RPG32_F"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_RPG32_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_AT_F: B_G_Soldier_LAT_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla3_2";
		displayname = "Missile Specialist (AT)";
		backpack = "B_FieldPack_cbr_AT";
		weapons[] = {"arifle_TRG21_F", "launch_O_Titan_short_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_O_Titan_short_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_AA_F: B_G_Soldier_LAT_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla3_2";
		displayname = "Missile Specialist (AA)";
		backpack = "B_FieldPack_ocamo_AA";
		weapons[] = {"arifle_TRG21_F", "launch_B_Titan_F", "Throw", "Put"};
		magazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnmagazines[] = {"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag"};
		respawnweapons[] = {"arifle_TRG21_F", "launch_B_Titan_F", "Throw", "Put"};
	};
	class PC2_O_G_Soldier_lite_F: B_G_Soldier_lite_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla1_1";
	};
	class PC2_O_G_Soldier_M_F: B_G_Soldier_M_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_Guerilla3_1";		
	};
	class PC2_O_G_Soldier_SL_F: B_G_Soldier_SL_F 
	{
		author = "Pixinger";
		scope = 2;
		side = 0;
		vehicleClass = "Men";
		faction = "PC2_O_FIA";
		uniformclass = "U_OG_leader";
	};
	class PC2_O_G_Soldier_TL_F: B_G_Soldier_TL_F 
	{
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
	};
};
