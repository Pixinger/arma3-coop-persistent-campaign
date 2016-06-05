if (isServer) then  
{
	logisticDbPrefix = "PC3LOG";	
	
	// Die Fahrzeuge die in der Datenbank gespeichert werden sollen.
	logisticDbVehicles = [
		// Boote
		"B_Boat_Transport_01_F",
		"B_Boat_Armed_01_minigun_F",
		// Truppentransporter
		"BWA3_Leopard2A6M_Fleck",
		"B_APC_Tracked_01_rcws_F",
		"B_APC_Wheeled_01_cannon_F",
		// Fahrzeuge
		"B_MRAP_01_F",
		"B_MRAP_01_gmg_F",
		"B_MRAP_01_hmg_F",
		// Ladeflächen Fahrzeuge
		"C_Van_01_box_F",
		"C_Van_01_transport_F",
		"B_Truck_01_box_F",
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		// Schlepper
		"B_Truck_01_mover_F"];
	
	// Die Munitionskisten die in der Datenbank gespeichert werden sollen.
	logisticDbAmmoboxes = ["Box_NATO_Ammo_F"];
		
	// Die Objekte die in der Datenbank gespeichert werden sollen.
	logisticDbObjects = [
		// Buildables
		"Land_HBarrier_3_F",
		"Land_BagFence_Long_F",
		"Land_BagBunker_Small_F",
		"Land_BagBunker_Large_F",
		// Objekte
		"Land_DataTerminal_01_F",
		"Land_Pallet_MilBoxes_F",
		"Land_Sacks_heap_F",
		"Land_WaterBarrel_F",
		"Land_Bricks_V1_F",
		"Land_Timbers_F"
	];
	

	private _worldSize = [] call PIX_fnc_WorldSize;	
	diag_log format["INFO: WorldSize=%1", _worldSize];
	logisticDbMapCenter = _worldSize select 1;
	logisticDbMapRadiusSqr = sqrt(((logisticDbMapCenter select 0)*(logisticDbMapCenter select 0)) + ((logisticDbMapCenter select 0)*(logisticDbMapCenter select 0)));

	// ------------------------------------------------------------------------------
	// Runtime Variablen initialisieren (nicht verändern!)
	logisticDbInitCompleted = false;
	logisticDbSaving = false;
};