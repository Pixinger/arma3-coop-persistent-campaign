
/* ---------------------------- */
/* Nur Server oder ServerClient */
/* ---------------------------- */
if (isServer) then
{
	pixlogisticItemDbFilename = "pixLogisticItem.txt";
	pixlogisticDataDbFilename = "pixLogisticData.txt";
};

/* ---------------------------- */
/* Nur Client oder ServerClient */
/* ---------------------------- */
if (!isServer || !isDedicated) then
{
	/* Container in die etwas geladen werden kann */
	pixlogisticTransportContainers = [
		"Land_Cargo20_blue_F", 			/*statische waffen*/
		"Land_Cargo20_cyan_F",
		"Land_Cargo20_yellow_F",
		"Land_Cargo20_grey_F", 			/*bunker*/
		"Land_Cargo20_light_blue_F",
		"Land_Cargo20_light_green_F",
		"Land_Cargo20_orange_F",
		"Land_Cargo20_red_F", 			/*hesco*/
		"Land_Cargo20_sand_F", 			/*beton mauern*/
		"Land_Cargo20_white_F",
		"Land_Cargo20_brick_red_F",		/*ammo boxes */
		"Land_Cargo20_military_green_F",
		"Land_CargoBox_V1_F"
	];
	/* Laderaumgrösse */
	pixlogisticTransportContainersSize = [
		1000, /*"Land_Cargo20_blue_F",*/
		1000, /*"Land_Cargo20_cyan_F",*/
		1000, /*"Land_Cargo20_yellow_F",*/
		1000, /*"Land_Cargo20_grey_F",*/
		1000, /*"Land_Cargo20_light_blue_F",*/
		1000, /*"Land_Cargo20_light_green_F",*/
		1000, /*"Land_Cargo20_orange_F",*/
		1000, /*"Land_Cargo20_red_F",*/
		1000, /*"Land_Cargo20_sand_F",*/
		1000, /*"Land_Cargo20_white_F",*/
		1000, /*"Land_Cargo20_brick_red_F",*/
		1000, /*"Land_Cargo20_military_green_F"*/
		100	  /*"Land_CargoBox_V1_F"*/
	];

	/* Fahrzeuge in die etwas geladen werden kann */
	pixlogisticTransportVehicles = [
		"B_Truck_01_mover_F",
		"B_Truck_01_box_F",
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		"B_MRAP_01_F",
		"B_MRAP_01_gmg_F",
		"B_MRAP_01_hmg_F",
		"B_Quadbike_01_F",
		"B_UGV_01_rcws_F",
		"B_UGV_01_F",
		"B_APC_Wheeled_01_cannon_F",
		"B_APC_Tracked_01_AA_F",
		"B_APC_Tracked_01_rcws_F",
		"B_MBT_01_cannon_F",
		"B_MBT_01_arty_F",
		"B_MBT_01_mlrs_F",
		"B_Heli_Light_01_armed_F",
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F",
		"B_APC_Tracked_01_CRV_F",
		"B_Truck_01_Repair_F",
		"B_Truck_01_ammo_F",
		"B_Truck_01_medical_F",
		"B_Truck_01_fuel_F",
		"B_Boat_Transport_01_F",
		"B_Boat_Armed_01_minigun_F",
		"B_SDV_01_F",
		"C_Van_01_box_F",
		"C_Van_01_transport_F",
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
		"O_UAV_01_F",
		"O_UGV_01_F",
		"O_UGV_01_rcws_F",
		"O_UAV_02_F",
		"O_UAV_02_CAS_F",
		"O_Heli_Light_02_unarmed_F",
		"O_Heli_Light_02_F",
		"O_Heli_Attack_02_black_F",
		"O_Heli_Attack_02_F"		
	];
	/* Laderaumgösse */
	pixlogisticTransportVehiclesSize = [
		50, /*B_Truck_01_mover_F",  HEMT */
		500, /*B_Truck_01_box_F",*/
		100, /*B_Truck_01_transport_F",*/
		500, /*B_Truck_01_covered_F",*/
		40, /*B_MRAP_01_F",*/
		40, /*B_MRAP_01_gmg_F",*/
		40, /*B_MRAP_01_hmg_F",*/
		10, /*B_Quadbike_01_F",*/
		15, /*B_UGV_01_rcws_F",*/
		15, /*B_UGV_01_F",*/
		100, /*B_APC_Wheeled_01_cannon_F",*/
		100, /*B_APC_Tracked_01_AA_F",*/
		100, /*B_APC_Tracked_01_rcws_F",*/
		100, /*B_MBT_01_cannon_F",*/
		100, /*B_MBT_01_arty_F",*/
		100, /*B_MBT_01_mlrs_F",*/
		10, /*B_Heli_Light_01_armed_F",*/
		10, /*B_Heli_Light_01_F",*/
		10, /*B_Heli_Transport_01_F",*/
		10, /*B_Heli_Transport_01_camo_F",*/
		100, /*B_APC_Tracked_01_CRV_F",*/
		50, /*B_Truck_01_Repair_F",*/
		50, /*B_Truck_01_ammo_F",*/
		50, /*B_Truck_01_medical_F",*/
		50, /*B_Truck_01_fuel_F",*/
		10, /*B_Boat_Transport_01_F",*/
		10, /*B_Boat_Armed_01_minigun_F",*/
		10, /*B_SDV_01_F",*/
		10, /*C_Van_01_box_F",*/
		10, /*C_Van_01_transport_F"*/
		/* OPFOR */
		40, /*"O_MRAP_02_F",*/
		40, /*"O_MRAP_02_gmg_F",*/
		40, /*"O_MRAP_02_hmg_F",*/
		10, /*"O_Quadbike_01_F",*/
		100, /*"O_Truck_02_transport_F",*/
		500, /*"O_Truck_02_covered_F",*/
		100, /*"O_APC_Wheeled_02_rcws_F",*/
		100, /*"O_APC_Tracked_02_AA_F",*/
		100, /*"O_APC_Tracked_02_cannon_F",*/
		100, /*"O_MBT_02_cannon_F",*/
		100, /*"O_MBT_02_arty_F",*/
		10, /*"O_Lifeboat",*/
		10, /*"O_Boat_Armed_01_hmg_F",*/
		10, /*"O_Boat_Transport_01_F",*/
		10, /*"O_SDV_01_F",*/
		50, /*"O_Truck_02_Ammo_F",*/
		50, /*"O_Truck_02_box_F",*/
		50, /*"O_Truck_02_medical_F",*/
		50, /*"O_Truck_02_fuel_F",*/
		15, /*"O_UGV_01_F",*/
		15, /*"O_UGV_01_rcws_F",*/
		10, /*"O_Heli_Light_02_unarmed_F",*/
		10, /*"O_Heli_Light_02_F",*/
		10, /*"O_Heli_Attack_02_black_F",*/
		10  /*"O_Heli_Attack_02_F"*/
	];

		
	/* Objekte die Bewegt und in Container/Fahrzeuge geladen werden können */
	pixlogisticMovableObjects = [
		"B_HMG_01_F",
		"B_HMG_01_high_F",
		"B_HMG_01_A_F",
		"B_GMG_01_F",
		"B_GMG_01_high_F",
		"B_GMG_01_A_F",
		"B_Mortar_01_F",
		"B_static_AA_F",
		"B_static_AT_F",
		"Land_CncWall1_F",
		"Land_CncWall4_F",
		"Land_CncBarrierMedium4_F",
		"Land_CncBarrierMedium_F",
		"Land_CncBarrier_F",
		"Land_CncBarrier_stripes_F",
		"Land_Crash_barrier_F",
		"Land_HBarrier_1_F",
		"Land_HBarrier_3_F",
		"Land_HBarrier_5_F",
		"Land_HBarrierBig_F",
		"Land_BagFence_Short_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Round_F",
		"Land_BagBunker_Large_F",
		"Land_BagBunker_Small_F",
		"Land_BagBunker_Tower_F",
		"Box_NATO_Grenades_F",
		"Box_NATO_AmmoOrd_F",
		"B_supplyCrate_F",
		"Box_NATO_WpsSpecial_F",
		"Box_NATO_Ammo_F",
		"Box_NATO_Wps_F",
		"Box_NATO_Support_F",
		"Box_NATO_AmmoVeh_F",
		"Box_NATO_WpsLaunch_F",
		/* OPFOR */
		"Box_East_WpsLaunch_F",
		"Box_East_Support_F",
		"O_supplyCrate_F",
		"Box_East_AmmoVeh_F",
		"Box_East_Grenades_F",
		"Box_East_WpsSpecial_F",
		"Box_East_AmmoOrd_F",
		"Box_East_Ammo_F",
		"Box_East_Wps_F"		
		];
		
	/* Benötigter Ladeplatz */
	pixlogisticMovableObjectsSize = [
		2, /*"B_HMG_01_F",*/
		3, /*"B_HMG_01_high_F",*/
		2, /*"B_HMG_01_A_F",*/
		2, /*"B_GMG_01_F",*/
		3, /*"B_GMG_01_high_F",*/
		2, /*"B_GMG_01_A_F",*/
		4, /*"B_Mortar_01_F",*/
		4, /*"B_static_AA_F",*/
		4, /*"B_static_AT_F",*/
		10, /*"Land_CncWall1_F",*/
		40, /*"Land_CncWall4_F",*/
		20, /*"Land_CncBarrierMedium4_F",*/
		10, /*"Land_CncBarrierMedium_F",*/
		5, /*"Land_CncBarrier_F",*/
		5, /*"Land_CncBarrier_stripes_F",*/
		5, /*"Land_Crash_barrier_F",*/
		5, /*"Land_HBarrier_1_F",*/
		5, /*"Land_HBarrier_3_F",*/
		5, /*"Land_HBarrier_5_F",*/
		5, /*"Land_HBarrierBig_F",*/
		4, /*"Land_BagFence_Short_F",*/
		4, /*"Land_BagFence_Long_F",*/
		4, /*"Land_BagFence_Round_F",*/
		80, /*"Land_BagBunker_Large_F",*/
		30, /*"Land_BagBunker_Small_F",*/
		50, /*"Land_BagBunker_Tower_F"*/
		20, /*"Box_NATO_Grenades_F",*/
		20, /*"Box_NATO_AmmoOrd_F",*/
		100, /*"B_supplyCrate_F",*/
		20, /*"Box_NATO_WpsSpecial_F",*/
		20, /*"Box_NATO_Ammo_F",*/
		20, /*"Box_NATO_Wps_F",*/
		20, /*"Box_NATO_Support_F",*/
		100, /*"Box_NATO_AmmoVeh_F",*/
		20, /*"Box_NATO_WpsLaunch_F"*/
		/* OPFOR */
		20, /*"Box_East_WpsLaunch_F",*/
		20, /*"Box_East_Support_F",*/
		100, /*"O_supplyCrate_F",*/
		100, /*"Box_East_AmmoVeh_F",*/
		20, /*"Box_East_Grenades_F",*/
		20, /*"Box_East_WpsSpecial_F",*/
		20, /*"Box_East_AmmoOrd_F",*/
		20, /*"Box_East_Ammo_F",*/
		20  /*"Box_East_Wps_F"*/
		];
		
	if (pixRadioType == "ACRE") then 
	{ 	
		pixlogisticMovableObjects = pixlogisticMovableObjects + ["ACRE_RadioBox"];
		pixlogisticMovableObjectsSize = pixlogisticMovableObjectsSize + [20];
	};
		
		
	/* Container-Gebäude die zu einem Container verpackt werden können */
	pixlogisticBuildings = [		
		"Land_Cargo_Patrol_V1_F",
		"Land_Medevac_HQ_V1_F"
	];
	/* Container-Gebäude die zu einem Container verpackt werden können */
	pixlogisticBuildingsService = [		
		"Land_Cargo_House_V2_F"
	];
	/* Container-Gebäude die zu einem Container verpackt werden können */
	pixlogisticBuildingsBarracks = [		
		"Land_Cargo_House_V1_F"
	];
	/* HQ-Container-Gebäude die zu einem Container verpackt werden können */
	pixlogisticHQs = [
		"Land_Cargo_HQ_V1_F"
	];
	/* Der entsprechende Container für die Container-Gebäude */
	pixlogisticBuildingContainer = "Land_Cargo40_military_green_F";
	
	/* Hauler (Schlepper) die bestimmte Container bewegen können */
	pixlogisticHaulers = [
		"B_Truck_01_mover_F"
	];
	/* Dinge die einem Schlepper aufgeladen werden können */
	pixlogisticHaulerCargos = [
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
		"Land_CargoBox_V1_F",
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
		"B_UAV_01_F",
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
		"O_UAV_01_F",
		"O_UGV_01_F",
		"O_UGV_01_rcws_F",
		"O_UAV_02_F",
		"O_UAV_02_CAS_F",
		"O_Heli_Light_02_unarmed_F",
		"O_Heli_Light_02_F",
		"O_Heli_Attack_02_black_F",
		"O_Heli_Attack_02_F"
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
		"B_UAV_01_F",
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
		"O_UAV_01_F",
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
		2000, /*"B_UAV_01_F",*/
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
		100,  /*"O_UAV_01_F",*/
		2000, /*"O_UGV_01_F",*/
		2000, /*"O_UGV_01_rcws_F",*/
		2000, /*"O_UAV_02_F",*/
		2000, /*"O_UAV_02_CAS_F",*/
		2000, /*"O_Heli_Light_02_unarmed_F",*/
		2000, /*"O_Heli_Light_02_F",*/
		2000, /*"O_Heli_Attack_02_black_F",*/
		2000  /*"O_Heli_Attack_02_F"*/
	];

	/*-----------------------------------------*/
	/* Definiert, welche Klassen Liften können */
	/*-----------------------------------------*/
	pixLogisticLiftPilots = [
		"B_Helipilot_F"
	];

	pixLogisticLiftRadius = 5;
	pixLogisticLiftHeightMin = 8;
	pixLogisticLiftHeightMax = 15;

	/*---------------------------------------------------*/
	/* Definiert, welche Fahrzeuge gekauft werden können */
	/*---------------------------------------------------*/
	pixLogisticStoreVehicles = [ /* Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array */
		[gettext (configFile >> "CfgVehicles" >> "B_APC_Wheeled_01_cannon_F" >> "displayName"), 4000, 0, "B_APC_Wheeled_01_cannon_F", gettext (configFile >> "CfgVehicles" >> "B_APC_Wheeled_01_cannon_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_AA_F" >> "displayName"), 5000, 0, "B_APC_Tracked_01_AA_F", gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_AA_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_rcws_F" >> "displayName"), 5000, 0, "B_APC_Tracked_01_rcws_F", gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_rcws_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_CRV_F" >> "displayName"), 4000, 0, "B_APC_Tracked_01_CRV_F", gettext (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_CRV_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MBT_01_cannon_F" >> "displayName"), 7000, 0, "B_MBT_01_cannon_F", gettext (configFile >> "CfgVehicles" >> "B_MBT_01_cannon_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MBT_01_arty_F" >> "displayName"), 7000, 0, "B_MBT_01_arty_F", gettext (configFile >> "CfgVehicles" >> "B_MBT_01_arty_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MBT_01_mlrs_F" >> "displayName"), 7000, 0, "B_MBT_01_mlrs_F", gettext (configFile >> "CfgVehicles" >> "B_MBT_01_mlrs_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Heli_Light_01_armed_F" >> "displayName"), 3000, 0, "B_Heli_Light_01_armed_F", gettext (configFile >> "CfgVehicles" >> "B_Heli_Light_01_armed_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Heli_Attack_01_F" >> "displayName"), 8000, 0, "B_Heli_Attack_01_F", gettext (configFile >> "CfgVehicles" >> "B_Heli_Attack_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Heli_Light_01_F" >> "displayName"), 3500, 0, "B_Heli_Light_01_F", gettext (configFile >> "CfgVehicles" >> "B_Heli_Light_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Heli_Transport_01_F" >> "displayName"), 4000, 0, "B_Heli_Transport_01_F", gettext (configFile >> "CfgVehicles" >> "B_Heli_Transport_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Heli_Transport_01_camo_F" >> "displayName"), 4000, 0, "B_Heli_Transport_01_camo_F", gettext (configFile >> "CfgVehicles" >> "B_Heli_Transport_01_camo_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_AA_F" >> "displayName"), 8000, 0, "I_Plane_Fighter_03_AA_F", gettext (configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_AA_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_CAS_F" >> "displayName"), 8000, 0, "I_Plane_Fighter_03_CAS_F", gettext (configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_CAS_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_mover_F" >> "displayName"), 2000, 0, "B_Truck_01_mover_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_mover_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_box_F" >> "displayName"), 3000, 0, "B_Truck_01_box_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_box_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_transport_F" >> "displayName"), 3000, 0, "B_Truck_01_transport_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_transport_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_covered_F" >> "displayName"), 3000, 0, "B_Truck_01_covered_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_covered_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_F" >> "displayName"), 1000, 0, "B_MRAP_01_F", gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_gmg_F" >> "displayName"), 3000, 0, "B_MRAP_01_gmg_F", gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_gmg_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_hmg_F" >> "displayName"), 2000, 0, "B_MRAP_01_hmg_F", gettext (configFile >> "CfgVehicles" >> "B_MRAP_01_hmg_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Quadbike_01_F" >> "displayName"), 500, 0, "B_Quadbike_01_F", gettext (configFile >> "CfgVehicles" >> "B_Quadbike_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_Repair_F" >> "displayName"), 3000, 0, "B_Truck_01_Repair_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_Repair_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_ammo_F" >> "displayName"), 3000, 0, "B_Truck_01_ammo_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_ammo_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_medical_F" >> "displayName"), 3000, 0, "B_Truck_01_medical_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_medical_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Truck_01_fuel_F" >> "displayName"), 3000, 0, "B_Truck_01_fuel_F", gettext (configFile >> "CfgVehicles" >> "B_Truck_01_fuel_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_UGV_01_rcws_F" >> "displayName"), 100, 0, "B_UGV_01_rcws_F", gettext (configFile >> "CfgVehicles" >> "B_UGV_01_rcws_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_UGV_01_F" >> "displayName"), 100, 0, "B_UGV_01_F", gettext (configFile >> "CfgVehicles" >> "B_UGV_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_UAV_02_CAS_F" >> "displayName"), 3000, 0, "B_UAV_02_CAS_F", gettext (configFile >> "CfgVehicles" >> "B_UAV_02_CAS_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_UAV_02_F" >> "displayName"), 3000, 0, "B_UAV_02_F", gettext (configFile >> "CfgVehicles" >> "B_UAV_02_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_UAV_01_F" >> "displayName"), 10, 0, "B_UAV_01_F", gettext (configFile >> "CfgVehicles" >> "B_UAV_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Boat_Transport_01_F" >> "displayName"), 1000, 0, "B_Boat_Transport_01_F", gettext (configFile >> "CfgVehicles" >> "B_Boat_Transport_01_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Lifeboat" >> "displayName"), 100, 0, "B_Lifeboat", gettext (configFile >> "CfgVehicles" >> "B_Lifeboat" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_Boat_Armed_01_minigun_F" >> "displayName"), 2000, 0, "B_Boat_Armed_01_minigun_F", gettext (configFile >> "CfgVehicles" >> "B_Boat_Armed_01_minigun_F" >> "icon"), []],
		[gettext (configFile >> "CfgVehicles" >> "B_SDV_01_F" >> "displayName"), 3000, 0, "B_SDV_01_F", gettext (configFile >> "CfgVehicles" >> "B_SDV_01_F" >> "icon"), []]
	];	
	
	/*------------------------------------------------*/
	/* Definiert, welche Waffen gekauft werden können */
	/*------------------------------------------------*/
	pixLogisticStoreWeapons = [ /* Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array */
		[gettext (configFile >> "CfgVehicles" >> "B_HMG_01_F" >> "displayName"), 1000, 0, "B_HMG_01_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_HMG_01_high_F" >> "displayName"), 1000, 0, "B_HMG_01_high_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_HMG_01_A_F" >> "displayName"), 1000, 0, "B_HMG_01_A_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_GMG_01_F" >> "displayName"), 1500, 0, "B_GMG_01_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_GMG_01_high_F" >> "displayName"), 1500, 0, "B_GMG_01_high_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_GMG_01_A_F" >> "displayName"), 1500, 0, "B_GMG_01_A_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_Mortar_01_F" >> "displayName"), 2000, 0, "B_Mortar_01_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_static_AA_F" >> "displayName"), 2000, 0, "B_static_AA_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_static_AT_F" >> "displayName"), 2000, 0, "B_static_AT_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_Grenades_F" >> "displayName"), 500, 0, "Box_NATO_Grenades_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_AmmoOrd_F" >> "displayName"), 500, 0, "Box_NATO_AmmoOrd_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "B_supplyCrate_F" >> "displayName"), 500, 0, "B_supplyCrate_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_WpsSpecial_F" >> "displayName"), 500, 0, "Box_NATO_WpsSpecial_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_Ammo_F" >> "displayName"), 500, 0, "Box_NATO_Ammo_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_Wps_F" >> "displayName"), 500, 0, "Box_NATO_Wps_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_Support_F" >> "displayName"), 500, 0, "Box_NATO_Support_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_WpsLaunch_F" >> "displayName"), 500, 0, "Box_NATO_WpsLaunch_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Box_NATO_AmmoVeh_F" >> "displayName"), 500, 0, "Box_NATO_AmmoVeh_F", "", []]		
	];
	
	if (pixRadioType == "ACRE") then 
	{ 	
		pixLogisticStoreWeapons = pixLogisticStoreWeapons + [["ACRE RadioBox", 500, 0, "ACRE_RadioBox", "", []]];
	};
		
	
	/*---------------------------------------------------*/
	/* Definiert, welche Container gekauft werden können */
	/*---------------------------------------------------*/
	pixLogisticStoreContainer = [ /* Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array */
		["Leerer Container", 10, 0, "Land_Cargo20_blue_F", "", [
			]],
		["Befestigungen (Beton)", 500, 0, "Land_Cargo20_grey_F", "", [
			"Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F","Land_CncWall1_F",
			"Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F","Land_CncBarrierMedium4_F",
			"Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium_F",
			"Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F","Land_CncBarrier_F",
			"Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F","Land_CncBarrier_stripes_F"
			]],
		["Befestigungen (Stahl)", 500, 0, "Land_Cargo20_sand_F", "", [
			"Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F","Land_Crash_barrier_F"
			]],
		["Befestigungen (Sand)", 500, 0, "Land_Cargo20_brick_red_F", "", [
			"Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F","Land_HBarrier_1_F",
			"Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F","Land_HBarrier_3_F",
			"Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F","Land_HBarrier_5_F",
			"Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F","Land_HBarrierBig_F",
			"Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F","Land_BagFence_Short_F",
			"Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_BagFence_Long_F",
			"Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F","Land_BagFence_Round_F"
			]],
		["Bunker (Sand)", 500, 0, "Land_Cargo20_red_F", "", [
			"Land_BagBunker_Small_F","Land_BagBunker_Small_F","Land_BagBunker_Small_F","Land_BagBunker_Small_F","Land_BagBunker_Small_F",
			"Land_BagBunker_Large_F","Land_BagBunker_Large_F","Land_BagBunker_Large_F",
			"Land_BagBunker_Tower_F","Land_BagBunker_Tower_F","Land_BagBunker_Tower_F"
			]],
		["Hauptquartier", 15000, 0, "Land_Cargo40_military_green_F", "", [
			"Land_Cargo_HQ_V1_F"
			]],
		["Baracken", 5000, 0, "Land_Cargo40_military_green_F", "", [
			"Land_Cargo_House_V1_F"
			]],
		["Werkstatt", 5000, 0, "Land_Cargo40_military_green_F", "", [
			"Land_Cargo_House_V2_F"
			]],
		["Wachturm", 2000, 0, "Land_Cargo40_military_green_F", "", [	
			"Land_Cargo_Patrol_V1_F"
			]],
		["Lazaret", 2000, 0, "Land_Cargo40_military_green_F", "", [
			"Land_Medevac_HQ_V1_F"
			]]			
	];
	
};
