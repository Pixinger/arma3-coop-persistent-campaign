if (isServer) then
{
	diag_log "LOGISTIC-Database saving";

	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { logisticDbInitCompleted };
	waitUntil { !logisticDbSaving };
	logisticDbSaving = true;
	"LOGISTIC-Database saving" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	#include "_databaseIndexes.hpp"

	//------------------------------------
	// Fahrzeuge
	//------------------------------------
	// ...auf der Map finden
	private["_vehicles"];
	//_vehicles = nearestObjects [logisticDbMapCenter, logisticDbVehicles, logisticDbMapRadiusSqr];
	_vehicles = nearestObjects [getpos player, logisticDbVehicles, 1000];
	diag_log format["_vehicles=%1", _vehicles];

	// Datenbank-Array erstellen
	private["_databaseVehicles"];
	_databaseVehicles = [];
	{	
		// Nur wenn wir das Fahrzeug nicht ignorieren sollen
		if (!(_x getVariable ["dbIgnore", false])) then
		{
			diag_log format["db-save-vehicle: %1", _x];
			_databaseVehicles pushBack [typeof(_x), (getPosATL _x), (getDir _x), ([_x] call fnc_logisticDb_GetVehicleDamageArray), ([_x] call fnc_logisticDb_GetVehicleCargoArray)];
		};
	} foreach _vehicles; 


	//------------------------------------
	// ReammoBox
	//------------------------------------
	private["_ammoboxes"];
	//_vehicles = nearestObjects [logisticDbMapCenter, logisticDbAmmoboxes, logisticDbMapRadiusSqr];
	_ammoboxes = nearestObjects [getpos player, logisticDbAmmoboxes, 1000];
	diag_log format["_ammoboxes=%1", _ammoboxes];

	// Datenbank-Array erstellen
	private["_databaseAmmoboxes"];
	_databaseAmmoboxes = [];
	{	
		// Nur wenn wir die Ammobox nicht ignorieren sollen
		if (!(_x getVariable ["dbIgnore", false])) then
		{
			diag_log format["db-save-ammobox: %1", _x];
			_databaseAmmoboxes pushBack [typeof(_x), (getPosATL _x), (getDir _x), (getDammage _x), ([_x] call fnc_logisticDb_GetVehicleCargoArray)];
		};
	} foreach _ammoboxes; 

	//------------------------------------
	// Objekte
	//------------------------------------
	private["_objects"];
	//_objects = nearestObjects [logisticDbMapCenter, logisticDbObjects, logisticDbMapRadiusSqr];
	_objects = nearestObjects [getpos player, logisticDbObjects, 1000];
	diag_log format["_objects=%1", _objects];

	// Datenbank-Array erstellen
	private["_databaseObjects"];
	_databaseObjects = [];
	{	
		// Nur wenn wir die Ammobox nicht ignorieren sollen
		if (!(_x getVariable ["dbIgnore", false])) then
		{
			diag_log format["db-save-_objects: %1", _x];
			_databaseObjects pushBack [typeof(_x), (getPosATL _x), (getDir _x), (getDammage _x)];
		};
	} foreach _objects; 

	//------------------------------------
	// Datenbank erstellen
	//------------------------------------
	private["_database"];
	_database = [_databaseVehicles, _databaseAmmoboxes, _databaseObjects];
	diag_log format["Final database: %1", _database];
	profileNameSpace setVariable [logisticDbPrefix + "_database", _database];
	
	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database saving complete" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};