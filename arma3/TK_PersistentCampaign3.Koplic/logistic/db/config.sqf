if (isServer) then  
{
	logisticDbPrefix = "PC3LOG";	
	
	// Die Fahrzeuge die in der Datenbank gespeichert werden sollen.
	logisticDbVehicles = [
		// Ladeflächen Fahrzeuge
		"C_Van_01_box_F",
		"C_Van_01_transport_F",
		"B_Truck_01_box_F",
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		// Schlepper
		"B_Truck_01_mover_F"];
	
	// Die Munitionskisten die in der Datenbank gespeichert werden sollen.
	logisticDbAmmoboxes = [
		"ReammoBox_F"];
		
	// Die Objekte die in der Datenbank gespeichert werden sollen.
	logisticDbObjects = [
		"Land_Bricks_V1_F",
		"Land_Pipes_large_F",
		"Land_HBarrier_3_F",
		"Land_BagFence_Long_F",
		"Land_BagBunker_Small_F",
		"Land_BagBunker_Large_F"
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