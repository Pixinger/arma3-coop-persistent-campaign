/*
pixLogisticLiftVehicles
pixLogisticLiftVehiclesStrength

pixLogisticLiftObjects
pixLogisticLiftObjectWeights

pixLogisticLiftPilots
pixLogisticLiftRadius = 5;
pixLogisticLiftHeightMin = 8;
pixLogisticLiftHeightMax = 15;
*/
pixLogisticLiftRadius = 5;
pixLogisticLiftHeightMin = 8;
pixLogisticLiftHeightMax = 15;

/* ---------------------------- */
/* Nur Client oder ServerClient */
/* ---------------------------- */
if (!isServer || !isDedicated) then
{
	/*-----------------------------------------*/
	/* Definiert, welche Klassen Liften können */
	/*-----------------------------------------*/
	pixLogisticLiftPilots = [
		"B_Helipilot_F"
	];

	/*--------------------------------------------------*/
	/* Alle Hubschrauber definieren, die Liften können  */
	/*--------------------------------------------------*/
	pixLogisticLiftVehicles = [
		"B_Heli_Light_01_F",
		"O_Heli_Light_02_F",
		"B_Heli_Transport_01_F",
		"I_Heli_Transport_02_F"
	];
	/* Definiert, wieviel Gewicht ein bestimmter "pixLogisticLiftVehicles" Hubschrauber heben kann */
	pixLogisticLiftVehiclesStrength = [
		100,
		100,
		2000,
		2000
	];

	/*---------------------------------*/
	/* Definiert die Liftbaren Objekte */
	/*---------------------------------*/
	pixLogisticLiftObjects = [
		"Land_Cargo20_blue_F",
		"Land_Cargo20_cyan_F",
		"Land_Cargo20_yellow_F",
		"Land_Cargo20_grey_F",
		"Land_Cargo20_light_blue_F",
		"Land_Cargo20_light_green_F",
		"Land_Cargo20_orange_F",
		"Land_Cargo20_red_F",
		"Land_Cargo20_sand_F",
		"Land_Cargo20_white_F",
		"Land_Cargo20_brick_red_F",
		"Land_Cargo20_military_green_F",
		"Land_Cargo40_military_green_F",
		"B_Truck_01_mover_F",
		"B_Truck_01_box_F",
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		"B_MRAP_01_F",
		"B_MRAP_01_gmg_F",
		"B_MRAP_01_hmg_F",
		"B_Quadbike_01_F",
		"B_APC_Wheeled_01_cannon_F",
		"B_UGV_01_rcws_F",
		"B_UGV_01_F",
		"B_UAV_02_CAS_F",
		"B_UAV_02_F",
		"B_Heli_Light_01_armed_F",
		"B_Heli_Attack_01_F",
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F",
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_03_CAS_F",
		"B_APC_Tracked_01_AA_F",
		"B_APC_Tracked_01_rcws_F",
		"B_MBT_01_cannon_F",
		"B_MBT_01_arty_F",
		"B_MBT_01_mlrs_F",
		"B_APC_Tracked_01_CRV_F",
		"B_Truck_01_Repair_F",
		"B_Truck_01_ammo_F",
		"B_Truck_01_medical_F",
		"B_Truck_01_fuel_F",
		"B_Boat_Transport_01_F",
		"B_Lifeboat",
		"B_Boat_Armed_01_minigun_F",
		"B_SDV_01_F",
		/* OPFOR */
		"O_MRAP_02_F",
		"O_MRAP_02_gmg_F",
		"O_MRAP_02_hmg_F",
		"O_Quadbike_01_F",
		"O_Truck_02_transport_F",
		"O_Truck_02_covered_F",
		"O_APC_Wheeled_02_rcws_F",
		"O_APC_Tracked_02_AA_F",
		"O_APC_Tracked_02_cannon_F",
		"O_MBT_02_cannon_F",
		"O_MBT_02_arty_F",
		"O_Lifeboat",
		"O_Boat_Armed_01_hmg_F",
		"O_Boat_Transport_01_F",
		"O_SDV_01_F",
		"O_Truck_02_Ammo_F",
		"O_Truck_02_box_F",
		"O_Truck_02_medical_F",
		"O_Truck_02_fuel_F",
		"O_UGV_01_F",
		"O_UGV_01_rcws_F",
		"O_UAV_02_F",
		"O_UAV_02_CAS_F",
		"O_Heli_Light_02_unarmed_F",
		"O_Heli_Light_02_F",
		"O_Heli_Attack_02_black_F",
		"O_Heli_Attack_02_F"		
		];
	/* Die Gewichte der Liftbaren Objekte */
	pixLogisticLiftObjectWeights = [
		2000, /*"Land_Cargo20_blue_F",*/
		2000, /*"Land_Cargo20_cyan_F",*/
		2000, /*"Land_Cargo20_yellow_F",*/
		2000, /*"Land_Cargo20_grey_F",*/
		2000, /*"Land_Cargo20_light_blue_F",*/
		2000, /*"Land_Cargo20_light_green_F",*/
		2000, /*"Land_Cargo20_orange_F",*/
		2000, /*"Land_Cargo20_red_F",*/
		2000, /*"Land_Cargo20_sand_F",*/
		2000, /*"Land_Cargo20_white_F",*/
		2000, /*"Land_Cargo20_brick_red_F",*/
		2000, /*"Land_Cargo20_military_green_F",*/
		2000, /*"Land_Cargo40_military_green_F"*/
		2000, /*"B_Truck_01_mover_F",*/
		2000, /*"B_Truck_01_box_F",*/
		2000, /*"B_Truck_01_transport_F",*/
		2000, /*"B_Truck_01_covered_F",*/
		2000, /*"B_MRAP_01_F",*/
		2000, /*"B_MRAP_01_gmg_F",*/
		2000, /*"B_MRAP_01_hmg_F",*/
		100, /*"B_Quadbike_01_F",*/
		2000, /*"B_APC_Wheeled_01_cannon_F",*/
		2000, /*"B_UGV_01_rcws_F",*/
		2000, /*"B_UGV_01_F",*/
		2000, /*"B_UAV_02_CAS_F",*/
		2000, /*"B_UAV_02_F",*/
		2000, /*"B_Heli_Light_01_armed_F",*/
		2000, /*"B_Heli_Attack_01_F",*/
		2000, /*"B_Heli_Light_01_F",*/
		2000, /*"B_Heli_Transport_01_F",*/
		2000, /*"B_Heli_Transport_01_camo_F",*/
		2000, /*"I_Plane_Fighter_03_AA_F",*/
		2000, /*"I_Plane_Fighter_03_CAS_F",*/
		2000, /*"B_APC_Tracked_01_AA_F",*/
		2000, /*"B_APC_Tracked_01_rcws_F",*/
		2000, /*"B_MBT_01_cannon_F",*/
		2000, /*"B_MBT_01_arty_F",*/
		2000, /*"B_MBT_01_mlrs_F",*/
		2000, /*"B_APC_Tracked_01_CRV_F",*/
		2000, /*"B_Truck_01_Repair_F",*/
		2000, /*"B_Truck_01_ammo_F",*/
		2000, /*"B_Truck_01_medical_F",*/
		2000, /*"B_Truck_01_fuel_F",*/
		2000, /*"B_Boat_Transport_01_F",*/
		2000, /*"B_Lifeboat",*/
		2000, /*"B_Boat_Armed_01_minigun_F",*/
		2000, /*"B_SDV_01_F"*/
		/* OPFOR */
		2000, /*"O_MRAP_02_F",*/
		2000, /*"O_MRAP_02_gmg_F",*/
		2000, /*"O_MRAP_02_hmg_F",*/
		100,  /*"O_Quadbike_01_F",*/
		2000, /*"O_Truck_02_transport_F",*/
		2000, /*"O_Truck_02_covered_F",*/
		2000, /*"O_APC_Wheeled_02_rcws_F",*/
		2000, /*"O_APC_Tracked_02_AA_F",*/
		2000, /*"O_APC_Tracked_02_cannon_F",*/
		2000, /*"O_MBT_02_cannon_F",*/
		2000, /*"O_MBT_02_arty_F",*/
		2000, /*"O_Lifeboat",*/
		2000, /*"O_Boat_Armed_01_hmg_F",*/
		2000, /*"O_Boat_Transport_01_F",*/
		2000, /*"O_SDV_01_F",*/
		2000, /*"O_Truck_02_Ammo_F",*/
		2000, /*"O_Truck_02_box_F",*/
		2000, /*"O_Truck_02_medical_F",*/
		2000, /*"O_Truck_02_fuel_F",*/
		2000, /*"O_UGV_01_F",*/
		2000, /*"O_UGV_01_rcws_F",*/
		2000, /*"O_UAV_02_F",*/
		2000, /*"O_UAV_02_CAS_F",*/
		2000, /*"O_Heli_Light_02_unarmed_F",*/
		2000, /*"O_Heli_Light_02_F",*/
		2000, /*"O_Heli_Attack_02_black_F",*/
		2000  /*"O_Heli_Attack_02_F"*/
	];

	if (count pixLogisticLiftVehicles != count pixLogisticLiftVehiclesStrength) then
	{
		private["_msg"];
		_msg = "ERROR: pixLogistic\config.sqf: (count pixLogisticLiftVehicles != count pixLogisticLiftVehiclesStrength)";
		diag_log _msg;
		player globalChat _msg;
	};

	if (count pixLogisticLiftObjects != count pixLogisticLiftObjectWeights) then
	{
		private["_msg"];
		_msg = "ERROR: pixLogistic\config.sqf: (count pixLogisticLiftObjects != count pixLogisticLiftObjectWeights)";
		diag_log _msg;
		player globalChat _msg;
	};	
};