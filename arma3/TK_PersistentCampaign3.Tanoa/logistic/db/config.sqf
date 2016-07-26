if (isServer) then  
{
	logisticDbPrefix = "PC3LOGTANOA";	
	
	// Die Fahrzeuge die in der Datenbank gespeichert werden sollen.
	logisticDbVehicles = [
		"B_HMG_01_F", 		//="B_T_HMG_01_F",
		"B_HMG_01_high_F",
		"B_HMG_01_A_F",
		"B_GMG_01_F", 		//="B_T_GMG_01_F",
		"B_GMG_01_high_F",
		"B_GMG_01_A_F",
		"B_Mortar_01_F",	//"B_T_Mortar_01_F",
		"B_Static_AA_F",	//="B_T_static_AA_F",
		"B_static_AT_F",	//="B_T_static_AT_F",		
		// Boote
		"B_T_Boat_Transport_01_F",
		"B_T_Boat_Armed_01_minigun_F",
		"I_G_Boat_Transport_01_F",
		// Truppentransporter
		"B_T_APC_Tracked_01_CRV_F",
		"B_T_APC_Tracked_01_rcws_F",
		"B_T_APC_Wheeled_01_cannon_F",
		// Flugzeuge
		"B_T_VTOL_01_armed_F",
		"B_T_VTOL_01_vehicle_F",
		"B_T_VTOL_01_infantry_F",
		"B_T_UAV_03_F",
		"B_CTRG_Heli_Transport_01_tropic_F",
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_Heli_light_01_F",
		"B_Heli_Light_01_armed_F",
		"B_Heli_Light_01_stripped_F",
		"B_Heli_Attack_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F",
		"B_Heli_Transport_03_F",
		"B_Heli_Transport_03_unarmed_F",
		"B_Heli_Transport_03_black_F",
		"B_Heli_Transport_03_unarmed_green_F",
		"B_Plane_CAS_01_F",
		"B_UAV_02_F",
		"B_UAV_02_CAS_F",
		// Fahrzeuge
		"B_T_MRAP_01_F",
		"B_T_MRAP_01_gmg_F",
		"B_T_MRAP_01_hmg_F",
		"B_T_LSV_01_armed_F",
		"B_T_LSV_01_unarmed_F",
		"B_CTRG_LSV_01_light_F",
		"I_C_Offroad_02_unarmed_F",
		"I_G_Offroad_01_F",
		"I_G_Offroad_01_armed_F",
		// Ladeflächen Fahrzeuge
		"C_Van_01_box_F",
		"C_Van_01_transport_F",
		"I_G_Van_01_transport_F",
		"B_T_Truck_01_box_F",
		"B_T_Truck_01_transport_F",
		"B_T_Truck_01_covered_F",
		// Schlepper
		"B_T_Truck_01_mover_F"];
	
	// Die Munitionskisten die in der Datenbank gespeichert werden sollen.
	logisticDbAmmoboxes = [
		"B_CargoNet_01_ammo_F"
	];
		
	// Die Objekte die in der Datenbank gespeichert werden sollen.
	logisticDbObjects = [
		// Buildables
		"Land_PortableLight_double_F",
		"Land_BarGate_F",
		"Land_HBarrier_1_F",
		"Land_HBarrier_3_F",
		"Land_HBarrier_5_F",
		"Land_BagFence_Long_F",
		"Land_BagBunker_Small_F",
		"Land_BagBunker_Large_F",
		"Land_Mil_WallBig_4m_F",
		"Land_BagFence_01_long_green_F",
		"Land_HBarrier_01_line_1_green_F",
		"Land_HBarrier_01_line_3_green_F",
		"Land_HBarrier_01_line_5_green_F",
		"Land_BagBunker_01_small_green_F",
		"Land_BagBunker_01_large_green_F",

		// Objekte
		"ACE_Wheel",
		"ACE_Track",
		"B_Slingload_01_Repair_F",
		"B_Slingload_01_Cargo_F",
		"Land_PaperBox_closed_F",
		"Land_PaperBox_open_full_F",
		"Land_Pipes_small_F",
		"Land_Pipes_large_F",
		"Land_DataTerminal_01_F",
		"Land_Pallet_MilBoxes_F",
		"Land_Sacks_heap_F",
		"Land_WaterBarrel_F",
		"Land_Bricks_V1_F",
		"Land_Timbers_F"
	];
	

	// ------------------------------------------------------------------------------
	// Runtime Variablen initialisieren (nicht verändern!)
	logisticDbInitCompleted = false;
	logisticDbSaving = false;
	logisticInitialized = false; // Komplette Logistic ist fertig initialisiert (publicVariable)
};

private _worldSize = [] call PIX_fnc_WorldSize;	
diag_log format["INFO: WorldSize=%1", _worldSize];
logisticDbMapCenter = _worldSize select 1;
logisticDbMapRadiusSqr = sqrt(((logisticDbMapCenter select 0)*(logisticDbMapCenter select 0)) + ((logisticDbMapCenter select 0)*(logisticDbMapCenter select 0)));
