if (isServer) then  
{
	#define MAP_CENTER	[15000,15000]
	#define MAP_RADIUS	15000
	
	// Die Fahrzeuge die in der Datenbank gespeichert werden sollen.
	dbVehicles = [
		//"C_Van_01_transport_F",
		"Van_01_base_F"];
	
	// Die Munitionskisten die in der Datenbank gespeichert werden sollen.
	dbAmmoboxes = [
		"ReammoBox_F"];
		
	// Die Objekte die in der Datenbank gespeichert werden sollen.
	dbObjects = [
		"Land_PortableLight_double_F",
		"Land_HBarrier_1_F",
		"Land_HBarrier_3_F",
		"Land_HBarrier_5_F",
		"Land_HBarrier_Big_F",
		"Land_HBarrierTower_F",		
		"Land_CncBarrier_F",		
		"Land_CncBarrier_stripes_F",
		"Land_CncBarrierMedium_F",	
		"Land_CncBarrierMedium4_F",	
		"Land_Mil_WallBig_4m_F",	
		"Land_Mil_WallBig_Corner_F",
		"Land_BagFence_Long_F",
		"Land_CncWall1_F",
		"Land_CncWall4_F"
	];
	

	dbMapCenter = MAP_CENTER;
	dbMapRadiusSqr = sqrt((MAP_RADIUS*MAP_RADIUS) + (MAP_RADIUS*MAP_RADIUS));
	dbType = "profilenamespace";

	call compile preprocessFileLineNumbers ("db\"+ dbType +"\config.sqf");
};